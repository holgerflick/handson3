unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.StdCtrls, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid, Classes.PhotoItem, Vcl.Menus, AdvGlowButton,
  Vcl.ExtDlgs,
  Modules.ImageCache,
  Modules.ServiceController, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, AdvTypes, AdvStyleIF,
  AdvAppStyler;

type
  TFrmMain = class(TForm)
    Grid: TAdvStringGrid;
    btnSaveAs: TAdvGlowButton;
    menImageSizes: TPopupMenu;
    btnCurated: TAdvGlowButton;
    DlgSave: TFileSaveDialog;
    btnKeywords: TAdvGlowButton;
    VectorImages: TAdvSVGImageCollection;
    ImageList: TVirtualImageList;
    procedure FormCreate(Sender: TObject);
    procedure btnCuratedClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveAsDropDown(Sender: TObject);
    procedure btnKeywordsClick(Sender: TObject);
  private
    FServiceController: TServiceController;
    FPhotos: TPhotoItemList;
    FImageCache: TImageCache;
    { Private declarations }
    procedure ProcessItems( AList: TPhotoItemList );

    procedure OnPopupMenuClick(Sender: TObject);

    procedure InitGrid;
    procedure SetPhotos(const Value: TPhotoItemList);

    function GetSelectedPhoto: TPhotoItem;

    procedure SaveImage( ABitmap: TBitmap );

    procedure BuildPopupMenu( const APhotoItem: TPhotoItem );

    procedure SelectKeywords;
  public
    { Public declarations }

    property Photos: TPhotoItemList read FPhotos write SetPhotos;
    property ServiceController : TServiceController read FServiceController;
    property ImageCache : TImageCache read FImageCache;
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses
  AdvUtils,
  IOUtils,
  Vcl.Imaging.pngimage,
  Vcl.Imaging.jpeg,
  Forms.SelectKeywords;

procedure TFrmMain.btnCuratedClick(Sender: TObject);
begin
  Photos := nil;
  ServiceController.GetCuratedPhotos( ProcessItems );
end;

procedure TFrmMain.btnKeywordsClick(Sender: TObject);
begin
  Photos := nil;

  SelectKeywords;
end;

procedure TFrmMain.btnSaveAsDropDown(Sender: TObject);
var
  LSelectedPhoto: TPhotoItem;

begin
  LSelectedPhoto := GetSelectedPhoto;
  if Assigned( LSelectedPhoto ) then
  begin
    BuildPopupMenu( LSelectedPhoto );
  end;
end;

procedure TFrmMain.BuildPopupMenu(const APhotoItem: TPhotoItem);
var
  LIndex : Integer;
  LSizes : TArray<string>;
  LSize: String;
  LMenuItem: TMenuItem;
  i: Integer;

begin
  LIndex := Photos.IndexOf(APhotoItem);
  LSizes := APhotoItem.GetSizes;

  menImageSizes.Items.Clear;

  menImageSizes.Tag := LIndex;

  for i := 0 to Length( LSizes )-1 do
  begin
    LSize := LSizes[i];

    LMenuItem := TMenuItem.Create(menImageSizes);
    LMenuItem.Caption := LSize;
    LMenuItem.Tag := i;
    LMenuItem.OnClick := OnPopupMenuClick;

    menImageSizes.Items.Add( LMenuItem );
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  InitGrid;

  FImageCache := TImageCache.Create(nil);
  FServiceController := TServiceController.Create(nil);
  FPhotos := nil;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FPhotos.Free;
  FServiceController.Free;
  FImageCache.Free;
end;

function TFrmMain.GetSelectedPhoto: TPhotoItem;
begin
  Result := nil;
  if Grid.SelectedRowCount > 0 then
  begin
    Result := Grid.Objects[ 0, Grid.SelectedRow[0] ] as TPhotoItem;
  end;
end;

procedure TFrmMain.InitGrid;
begin
  Grid.Visible := False;
  Grid.Options := Grid.Options + [ goRowSelect ];
  Grid.DefaultRowHeight := 150;

  Grid.ColumnSize.StretchColumn := 0;
  Grid.ColumnSize.Stretch := True;

  Grid.ColCount := 4;
  Grid.FixedCols := 0;

  Grid.FixedFont := Grid.Font;
  Grid.FixedFont.Size := trunc( Grid.Font.Size * (TAdvUtils.GetDPIScale));
  Grid.FixedFont.Style := [fsBold];

  Grid.Cells[0,0] := 'Preview';
  Grid.Cells[1,0] := 'Width';
  Grid.Cells[2,0] := 'Height';
  Grid.Cells[3,0] := 'Photographer';
end;

procedure TFrmMain.OnPopupMenuClick(Sender: TObject);
var
  LPhoto: TPhotoItem;
  LSizes: TArray<string>;
  LSize : String;
begin
  // we need to download the image or retrieve from cache
  LPhoto := Photos[ (Sender as TMenuItem).GetParentMenu.Tag ];

  LSizes := LPhoto.GetSizes;
  LSize := LSizes[ (Sender as TMenuItem).Tag ];

  LPhoto.ImageCache := ImageCache;
  LPhoto.LoadImage<TPhotoItem>(LPhoto, LSize,
    procedure ( APhoto: TPhotoItem; ABitmap: TObject )
    begin
      if Assigned( ABitmap ) then
      begin
        TThread.Synchronize( nil,
         procedure
         begin
           SaveImage( ABitmap as TBitmap );
           ABitmap.Free;
         end
        );
      end;
    end
  );
end;

procedure TFrmMain.ProcessItems(AList: TPhotoItemList);
var
  LItem: TPhotoItem;
  i: Integer;

begin
  try
    Grid.RowCount := AList.Count +1;
    Grid.FixedRows := 1;
    Grid.ColWidths[1] := 100;
    Grid.ColWidths[2] := 100;
    Grid.ColWidths[3] := 250;

    Grid.RowHeights[0] := 30;
    for i := 0 to AList.Count-1 do
    begin
      LItem := AList[i];

      Grid.Objects[0,i+1] := LItem;
      Grid.Cells[0,i+1] := '(Loading...)';
      Grid.RemoveBitmap(0,i+1);
      Grid.Ints[1,i+1] := LItem.Width;
      Grid.Ints[2, i+1] := LItem.Height;
      Grid.Cells[3,i+1] := LItem.Photographer.Name;

      LItem.ImageCache := ImageCache;
      LItem.LoadImage<integer>( i+1, 'small',
        procedure( ARow: Integer; ABitmap: TObject )
        begin
          if ABitmap <> nil then
          begin
            if ABitmap is TBitmap then
            begin
              TThread.Synchronize( nil,
                procedure
                var
                  LBitmap: TBitmap;

                begin
                  Grid.BeginUpdate;
                  try
                    Grid.Cells[0, ARow] := '';

                    if ( TBitmap( ABitmap ).Height > 0 ) AND
                       ( TBitmap( ABitmap ).Width  > 0 ) then
                    begin
                      // create new bitmap managed by grid
                      LBitmap := Grid.CreateBitmap( 0, ARow, False, haCenter, vaCenter );
                      LBitmap.Assign( TBitmap( ABitmap ) );
                    end
                    else
                    begin
                      Grid.Cells[0, ARow] := '(Image empty)';
                    end;
                  finally
                    // release bitmap passed by service
                    ABitmap.Free;

                    Grid.EndUpdate;
                  end;
                end
              );
            end
            else
            begin
              TThread.Synchronize( nil,
                procedure
                begin
                  Grid.Cells[ 0, ARow ] := '(Invalid data)';
                end
              );
            end;

          end
          else
          begin
            TThread.Synchronize( nil,
              procedure
              begin
                Grid.Cells[ 0, ARow ] := '(Download failed)';
              end
            );
          end;
        end
      );

    end;
  finally

    Photos := AList;
  end;
end;

procedure TFrmMain.SaveImage(ABitmap: TBitmap);
var

  LFT: TFileTypeItem;
  LTargetClass: TGraphicClass;
  LTarget: TGraphic;
  LExtension: String;

begin
  if DlgSave.Execute then
  begin
    LExtension := LowerCase( TPath.GetExtension( DlgSave.FileName ) );

    LTargetClass := nil;

    if LExtension = '.png' then
    begin
      LTargetClass := TPNGImage;
    end
    else
    begin
      if (LExtension = '.jpg') OR ( LExtension = '.jpeg' ) then
      begin
        LTargetClass := TJPEGImage;
      end;
    end;

    if not Assigned( LTargetClass ) then
    begin
      raise ENotSupportedException.Create('Unknown graphic format.');
    end;

    LTarget := LTargetClass.Create;
    try
      LTarget.Assign(ABitmap);
      LTarget.SaveToFile(Dlgsave.FileName);

      ShowMessageFmt( 'Image saved successfully to %s', [DlgSave.FileName] );
    finally
      LTarget.Free;
    end;
  end;
end;

procedure TFrmMain.SelectKeywords;
var
  LFrm: TFrmSelectKeywords;

begin
  LFrm := TFrmSelectKeywords.Create(nil);
  try
    if LFrm.ShowModal = mrOK then
    begin
      ServiceController.GetPhotoByKeywords( LFrm.Keywords, ProcessItems );
    end;
  finally
    LFrm.Free;
  end;
end;

procedure TFrmMain.SetPhotos(const Value: TPhotoItemList);
begin
  if Assigned( FPhotos ) then
  begin
    FPhotos.Free;
    FPhotos := nil;
  end;

  if Assigned( Value ) then
  begin
    FPhotos := Value;
    Grid.Visible := FPhotos.Count > 0;
  end;
end;

end.

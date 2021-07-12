unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, Vcl.StdCtrls, Forms.Wait, Helper.TAdvStringGrid;

type
  TFrmMain = class(TForm)
    Grid: TAdvStringGrid;
    procedure GridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure GridGetDisplText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure FormCreate(Sender: TObject);


  private
    { Private declarations }
    FReady:Boolean;
    FFrmWait: TFrmWait;

    procedure LoadData;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses System.Threading;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  LoadData;
end;

procedure TFrmMain.GridGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol > 1 then
  begin
    HAlign := taRightJustify;
  end;
end;

procedure TFrmMain.GridGetDisplText(Sender: TObject; ACol, ARow: Integer;
  var Value: string);

  function ISOStringToDate( AString: String ): TDate;
  var
    LFormat: TFormatSettings;

  begin
    LFormat := TFormatSettings.Create;
    LFormat.DateSeparator := '-';
    LFormat.ShortDateFormat := 'yyyy-MM-dd';
    Result := StrToDate( AString, LFormat );
  end;

var
  LDate : TDate;

begin
  if (NOT Grid.IsNode(ARow)) AND ( FReady ) then
  begin
    if ARow > 0 then
    begin
      if NOT Value.IsEmpty  then
      begin
        if ACol = 1 then
        begin
          LDate := ISOStringToDate( Value );
          Value := DateToStr(LDate);
        end
        else
        begin
          if ACol > 2 then
          begin
            Value := Format('%.0n', [Value.ToDouble]  );
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmMain.LoadData;
begin
  // set status of form
  FReady := False;

  // assign events
  Grid.OnGetDisplText := GridGetDisplText;

  // hide grid
  Grid.Visible := False;

  // show progress form with activitiy indicator
  FFrmWait := TFrmWait.Create(nil);
  FFrmWait.FormStyle := fsStayOnTop;
  FFrmWait.Show;

  TTask.Run(
    procedure
    begin
      // disable updating of grid for performance
      TThread.Synchronize( nil,
       procedure
       begin
         Grid.BeginUpdate;
       end
      );

      try
        // all actions can be executed in thread as
        // no redrawing or other threads might interfere

        // no fixed columns
        Grid.FixedCols := 0;

        // load data from resource
        Grid.LoadFromCSVResource( 'DATA' );

        // insert fixed column for node expand icon
        Grid.InsertCols(0,1);

        // hide column with id
        Grid.HideColumn(3);

        // make first column fixed
        Grid.FixedCols := 1;

        // move column 2 before 1
        Grid.MoveColumn(2,1);

        // group on column 1 (state)
        Grid.Group(1);

        // contract all nodes
        Grid.ContractAll;

        // set headers
        Grid.RealCells[1,0] := 'Date';
        Grid.RealCells[2,0] := '# Cases';
        Grid.RealCells[3,0] := '# Deaths';

        // auto size all columns
        Grid.AutoSizeColumns(True,4);
      finally
        // update user interface in main thread
        TThread.Synchronize( nil,
         procedure
         begin
            // paint changes
            Grid.EndUpdate;

            // show grid
            Grid.Visible := True;

            // hide progress form
            FFrmWait.Free;
            FFrmWait := nil;

            // set state to ready
            FReady := True;
         end
        )
      end;
    end
  );
end;

end.

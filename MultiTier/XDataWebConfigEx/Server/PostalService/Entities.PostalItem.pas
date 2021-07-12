unit Entities.PostalItem;

interface
uses
  System.Generics.Collections;

type
///  <summary>
///  Entity class to store information about one postal code. The data is
///  retrieved from a database.
///  </summary>
  TPostalItem = class
  private
    FCountryCode: String;
    FPostalCode: String;
    FPlaceName: String;
    FStateName: String;
    FStateCode: String;
    FCountyName: String;
    FCountyCode: String;
    FCommunityName: String;
    FCommunityCode: String;
    FCountryName: String;

  public
    /// ISO code for country
    property CountryCode: String read FCountryCode write FCountryCode;

    /// Name of country
    property CountryName: String read FCountryName write FCountryName;

    /// Postal code
    property PostalCode: String read FPostalCode write FPostalCode;

    /// Name of place (mostly a city)
    property PlaceName: String read FPlaceName write FPlaceName;

    /// Name of state or region
    property StateName: String read FStateName write FStateName;

    /// Abbr. code of state
    property StateCode: String read FStateCode write FStateCode;

    /// Name of county
    property CountyName: String read FCountyName write FCountyName;

    /// Abbr. code of country
    property CountyCode: String read FCountyCode write FCountyCode;

    /// Name of community
    property CommunityName: String read FCommunityName write FCommunityName;

    /// Short code for community
    property CommunityCode: String read FCommunityCode write FCommunityCode;
  end;

  TPostalItemList = TList<TPostalItem>;

implementation

end.

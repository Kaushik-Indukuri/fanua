// To parse this JSON data, do
//
//     final propertySearch = propertySearchFromJson(jsonString);

import 'dart:convert';

PropertySearch propertySearchFromJson(String str) => PropertySearch.fromJson(json.decode(str));

String propertySearchToJson(PropertySearch data) => json.encode(data.toJson());

class PropertySearch {
  PropertySearch({
    this.meta,
    this.properties,
  });

  Meta meta;
  List<Property> properties;

  factory PropertySearch.fromJson(Map<String, dynamic> json) => PropertySearch(
    meta: Meta.fromJson(json["meta"]),
    properties: List<Property>.from(json["properties"].map((x) => Property.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "properties": List<dynamic>.from(properties.map((x) => x.toJson())),
  };
}

class Meta {
  Meta({
    this.build,
    this.matchingRows,
    this.returnedRows,
    this.schema,
    this.tracking,
    this.trackingParams,
  });

  String build;
  int matchingRows;
  int returnedRows;
  String schema;
  String tracking;
  TrackingParams trackingParams;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    build: json["build"],
    matchingRows: json["matching_rows"],
    returnedRows: json["returned_rows"],
    schema: json["schema"],
    tracking: json["tracking"],
    trackingParams: TrackingParams.fromJson(json["tracking_params"]),
  );

  Map<String, dynamic> toJson() => {
    "build": build,
    "matching_rows": matchingRows,
    "returned_rows": returnedRows,
    "schema": schema,
    "tracking": tracking,
    "tracking_params": trackingParams.toJson(),
  };
}

class TrackingParams {
  TrackingParams({
    this.channel,
    this.city,
    this.county,
    this.listingActivity,
    this.neighborhood,
    this.propertyStatus,
    this.propertyType,
    this.searchBathrooms,
    this.searchBedrooms,
    this.searchCityState,
    this.searchCoordinates,
    this.searchHouseSqft,
    this.searchLotSqft,
    this.searchMaxPrice,
    this.searchMinPrice,
    this.searchRadius,
    this.searchResults,
    this.siteSection,
    this.sortResults,
    this.srpPropertyStatus,
    this.state,
    this.version,
    this.zip,
  });

  Channel channel;
  City city;
  String county;
  String listingActivity;
  String neighborhood;
  Channel propertyStatus;
  PropType propertyType;
  String searchBathrooms;
  String searchBedrooms;
  String searchCityState;
  String searchCoordinates;
  String searchHouseSqft;
  String searchLotSqft;
  String searchMaxPrice;
  String searchMinPrice;
  String searchRadius;
  String searchResults;
  Channel siteSection;
  String sortResults;
  String srpPropertyStatus;
  StateCodeEnum state;
  String version;
  String zip;

  factory TrackingParams.fromJson(Map<String, dynamic> json) => TrackingParams(
    channel: channelValues.map[json["channel"]],
    city: cityValues.map[json["city"]],
    county: json["county"],
    listingActivity: json["listingActivity"],
    neighborhood: json["neighborhood"],
    propertyStatus: channelValues.map[json["propertyStatus"]],
    propertyType: propTypeValues.map[json["propertyType"]],
    searchBathrooms: json["searchBathrooms"],
    searchBedrooms: json["searchBedrooms"],
    searchCityState: json["searchCityState"],
    searchCoordinates: json["searchCoordinates"],
    searchHouseSqft: json["searchHouseSqft"],
    searchLotSqft: json["searchLotSqft"],
    searchMaxPrice: json["searchMaxPrice"],
    searchMinPrice: json["searchMinPrice"],
    searchRadius: json["searchRadius"],
    searchResults: json["searchResults"],
    siteSection: channelValues.map[json["siteSection"]],
    sortResults: json["sortResults"],
    srpPropertyStatus: json["srpPropertyStatus"],
    state: stateCodeEnumValues.map[json["state"]],
    version: json["version"],
    zip: json["zip"],
  );

  Map<String, dynamic> toJson() => {
    "channel": channelValues.reverse[channel],
    "city": cityValues.reverse[city],
    "county": county,
    "listingActivity": listingActivity,
    "neighborhood": neighborhood,
    "propertyStatus": channelValues.reverse[propertyStatus],
    "propertyType": propTypeValues.reverse[propertyType],
    "searchBathrooms": searchBathrooms,
    "searchBedrooms": searchBedrooms,
    "searchCityState": searchCityState,
    "searchCoordinates": searchCoordinates,
    "searchHouseSqft": searchHouseSqft,
    "searchLotSqft": searchLotSqft,
    "searchMaxPrice": searchMaxPrice,
    "searchMinPrice": searchMinPrice,
    "searchRadius": searchRadius,
    "searchResults": searchResults,
    "siteSection": channelValues.reverse[siteSection],
    "sortResults": sortResults,
    "srpPropertyStatus": srpPropertyStatus,
    "state": stateCodeEnumValues.reverse[state],
    "version": version,
    "zip": zip,
  };
}

enum Channel { FOR_SALE }

final channelValues = EnumValues({
  "for_sale": Channel.FOR_SALE
});

enum City { NEWARK }

final cityValues = EnumValues({
  "Newark": City.NEWARK
});

enum PropType { SINGLE_FAMILY }

final propTypeValues = EnumValues({
  "single_family": PropType.SINGLE_FAMILY
});

enum StateCodeEnum { NJ }

final stateCodeEnumValues = EnumValues({
  "NJ": StateCodeEnum.NJ
});

class Property {
  Property({
    this.address,
    this.agents,
    this.baths,
    this.bathsFull,
    this.beds,
    this.branding,
    this.clientDisplayFlags,
    this.dataSourceName,
    this.lastUpdate,
    this.leadForms,
    this.listTracking,
    this.listingId,
    this.lotSize,
    this.mls,
    this.office,
    this.pageNo,
    this.photoCount,
    this.price,
    this.products,
    this.propStatus,
    this.propType,
    this.propertyId,
    this.rank,
    this.rdcWebUrl,
    this.thumbnail,
    this.openHouses,
    this.propSubType,
    this.virtualTour,
    this.bathsHalf,
    this.buildingSize,
  });

  Address address;
  List<Agent> agents;
  int baths;
  int bathsFull;
  int beds;
  Branding branding;
  ClientDisplayFlags clientDisplayFlags;
  DataSourceName dataSourceName;
  DateTime lastUpdate;
  LeadForms leadForms;
  String listTracking;
  String listingId;
  Size lotSize;
  Mls mls;
  Office office;
  int pageNo;
  int photoCount;
  int price;
  List<Product> products;
  Channel propStatus;
  PropType propType;
  String propertyId;
  int rank;
  String rdcWebUrl;
  String thumbnail;
  List<OpenHouse> openHouses;
  String propSubType;
  VirtualTour virtualTour;
  int bathsHalf;
  Size buildingSize;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
    address: Address.fromJson(json["address"]),
    agents: List<Agent>.from(json["agents"].map((x) => Agent.fromJson(x))),
    baths: json["baths"],
    bathsFull: json["baths_full"],
    beds: json["beds"],
    branding: Branding.fromJson(json["branding"]),
    clientDisplayFlags: ClientDisplayFlags.fromJson(json["client_display_flags"]),
    dataSourceName: dataSourceNameValues.map[json["data_source_name"]],
    lastUpdate: DateTime.parse(json["last_update"]),
    leadForms: LeadForms.fromJson(json["lead_forms"]),
    listTracking: json["list_tracking"],
    listingId: json["listing_id"],
    lotSize: json["lot_size"] == null ? null : Size.fromJson(json["lot_size"]),
    mls: Mls.fromJson(json["mls"]),
    office: Office.fromJson(json["office"]),
    pageNo: json["page_no"],
    photoCount: json["photo_count"],
    price: json["price"],
    products: List<Product>.from(json["products"].map((x) => productValues.map[x])),
    propStatus: channelValues.map[json["prop_status"]],
    propType: propTypeValues.map[json["prop_type"]],
    propertyId: json["property_id"],
    rank: json["rank"],
    rdcWebUrl: json["rdc_web_url"],
    thumbnail: json["thumbnail"],
    openHouses: json["open_houses"] == null ? null : List<OpenHouse>.from(json["open_houses"].map((x) => OpenHouse.fromJson(x))),
    propSubType: json["prop_sub_type"] == null ? null : json["prop_sub_type"],
    virtualTour: json["virtual_tour"] == null ? null : VirtualTour.fromJson(json["virtual_tour"]),
    bathsHalf: json["baths_half"] == null ? null : json["baths_half"],
    buildingSize: json["building_size"] == null ? null : Size.fromJson(json["building_size"]),
  );

  Map<String, dynamic> toJson() => {
    "address": address.toJson(),
    "agents": List<dynamic>.from(agents.map((x) => x.toJson())),
    "baths": baths,
    "baths_full": bathsFull,
    "beds": beds,
    "branding": branding.toJson(),
    "client_display_flags": clientDisplayFlags.toJson(),
    "data_source_name": dataSourceNameValues.reverse[dataSourceName],
    "last_update": lastUpdate.toIso8601String(),
    "lead_forms": leadForms.toJson(),
    "list_tracking": listTracking,
    "listing_id": listingId,
    "lot_size": lotSize == null ? null : lotSize.toJson(),
    "mls": mls.toJson(),
    "office": office.toJson(),
    "page_no": pageNo,
    "photo_count": photoCount,
    "price": price,
    "products": List<dynamic>.from(products.map((x) => productValues.reverse[x])),
    "prop_status": channelValues.reverse[propStatus],
    "prop_type": propTypeValues.reverse[propType],
    "property_id": propertyId,
    "rank": rank,
    "rdc_web_url": rdcWebUrl,
    "thumbnail": thumbnail,
    "open_houses": openHouses == null ? null : List<dynamic>.from(openHouses.map((x) => x.toJson())),
    "prop_sub_type": propSubType == null ? null : propSubType,
    "virtual_tour": virtualTour == null ? null : virtualTour.toJson(),
    "baths_half": bathsHalf == null ? null : bathsHalf,
    "building_size": buildingSize == null ? null : buildingSize.toJson(),
  };
}

class Address {
  Address({
    this.city,
    this.county,
    this.fipsCode,
    this.lat,
    this.line,
    this.lon,
    this.neighborhoodName,
    this.postalCode,
    this.state,
    this.stateCode,
    this.timeZone,
  });

  City city;
  County county;
  String fipsCode;
  double lat;
  String line;
  double lon;
  String neighborhoodName;
  String postalCode;
  PurpleState state;
  StateCodeEnum stateCode;
  String timeZone;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    city: cityValues.map[json["city"]],
    county: countyValues.map[json["county"]],
    fipsCode: json["fips_code"],
    lat: json["lat"].toDouble(),
    line: json["line"],
    lon: json["lon"].toDouble(),
    neighborhoodName: json["neighborhood_name"],
    postalCode: json["postal_code"],
    state: purpleStateValues.map[json["state"]],
    stateCode: stateCodeEnumValues.map[json["state_code"]],
    timeZone: json["time_zone"] == null ? null : json["time_zone"],
  );

  Map<String, dynamic> toJson() => {
    "city": cityValues.reverse[city],
    "county": countyValues.reverse[county],
    "fips_code": fipsCode,
    "lat": lat,
    "line": line,
    "lon": lon,
    "neighborhood_name": neighborhoodName,
    "postal_code": postalCode,
    "state": purpleStateValues.reverse[state],
    "state_code": stateCodeEnumValues.reverse[stateCode],
    "time_zone": timeZone == null ? null : timeZone,
  };
}

enum County { ESSEX }

final countyValues = EnumValues({
  "Essex": County.ESSEX
});

enum PurpleState { NEW_JERSEY }

final purpleStateValues = EnumValues({
  "New Jersey": PurpleState.NEW_JERSEY
});

class Agent {
  Agent({
    this.advertiserId,
    this.id,
    this.name,
    this.photo,
    this.primary,
  });

  String advertiserId;
  String id;
  String name;
  VirtualTour photo;
  bool primary;

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
    advertiserId: json["advertiser_id"],
    id: json["id"],
    name: json["name"],
    photo: json["photo"] == null ? null : VirtualTour.fromJson(json["photo"]),
    primary: json["primary"],
  );

  Map<String, dynamic> toJson() => {
    "advertiser_id": advertiserId,
    "id": id,
    "name": name,
    "photo": photo == null ? null : photo.toJson(),
    "primary": primary,
  };
}

class VirtualTour {
  VirtualTour({
    this.href,
  });

  String href;

  factory VirtualTour.fromJson(Map<String, dynamic> json) => VirtualTour(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class Branding {
  Branding({
    this.listingOffice,
  });

  ListingOffice listingOffice;

  factory Branding.fromJson(Map<String, dynamic> json) => Branding(
    listingOffice: ListingOffice.fromJson(json["listing_office"]),
  );

  Map<String, dynamic> toJson() => {
    "listing_office": listingOffice.toJson(),
  };
}

class ListingOffice {
  ListingOffice({
    this.listItem,
  });

  ListItem listItem;

  factory ListingOffice.fromJson(Map<String, dynamic> json) => ListingOffice(
    listItem: ListItem.fromJson(json["list_item"]),
  );

  Map<String, dynamic> toJson() => {
    "list_item": listItem.toJson(),
  };
}

class ListItem {
  ListItem({
    this.accentColor,
    this.link,
    this.name,
    this.phone,
    this.photo,
    this.showRealtorLogo,
    this.slogan,
  });

  dynamic accentColor;
  dynamic link;
  String name;
  dynamic phone;
  dynamic photo;
  bool showRealtorLogo;
  dynamic slogan;

  factory ListItem.fromJson(Map<String, dynamic> json) => ListItem(
    accentColor: json["accent_color"],
    link: json["link"],
    name: json["name"],
    phone: json["phone"],
    photo: json["photo"],
    showRealtorLogo: json["show_realtor_logo"],
    slogan: json["slogan"],
  );

  Map<String, dynamic> toJson() => {
    "accent_color": accentColor,
    "link": link,
    "name": name,
    "phone": phone,
    "photo": photo,
    "show_realtor_logo": showRealtorLogo,
    "slogan": slogan,
  };
}

class Size {
  Size({
    this.size,
    this.units,
  });

  int size;
  String units;

  factory Size.fromJson(Map<String, dynamic> json) => Size(
    size: json["size"],
    units: json["units"],
  );

  Map<String, dynamic> toJson() => {
    "size": size,
    "units": units,
  };
}

class ClientDisplayFlags {
  ClientDisplayFlags({
    this.hasOpenHouse,
    this.isCoBrokeEmail,
    this.isCoBrokePhone,
    this.isNewListing,
    this.isNewPlan,
    this.isOfficeStandardListing,
    this.isShowcase,
    this.isShowcaseChoiceEnabled,
    this.isTurbo,
    this.leadFormPhoneRequired,
    this.presentationStatus,
    this.priceChange,
    this.showContactALenderInLeadForm,
    this.showVeteransUnitedInLeadForm,
    this.suppressMapPin,
    this.advantageProFlag,
    this.hasMatterport,
  });

  bool hasOpenHouse;
  bool isCoBrokeEmail;
  bool isCoBrokePhone;
  bool isNewListing;
  bool isNewPlan;
  bool isOfficeStandardListing;
  bool isShowcase;
  bool isShowcaseChoiceEnabled;
  bool isTurbo;
  bool leadFormPhoneRequired;
  Channel presentationStatus;
  int priceChange;
  bool showContactALenderInLeadForm;
  bool showVeteransUnitedInLeadForm;
  bool suppressMapPin;
  bool advantageProFlag;
  bool hasMatterport;

  factory ClientDisplayFlags.fromJson(Map<String, dynamic> json) => ClientDisplayFlags(
    hasOpenHouse: json["has_open_house"],
    isCoBrokeEmail: json["is_co_broke_email"],
    isCoBrokePhone: json["is_co_broke_phone"],
    isNewListing: json["is_new_listing"],
    isNewPlan: json["is_new_plan"],
    isOfficeStandardListing: json["is_office_standard_listing"],
    isShowcase: json["is_showcase"],
    isShowcaseChoiceEnabled: json["is_showcase_choice_enabled"],
    isTurbo: json["is_turbo"],
    leadFormPhoneRequired: json["lead_form_phone_required"],
    presentationStatus: channelValues.map[json["presentation_status"]],
    priceChange: json["price_change"],
    showContactALenderInLeadForm: json["show_contact_a_lender_in_lead_form"],
    showVeteransUnitedInLeadForm: json["show_veterans_united_in_lead_form"],
    suppressMapPin: json["suppress_map_pin"],
    advantageProFlag: json["advantage_pro_flag"] == null ? null : json["advantage_pro_flag"],
    hasMatterport: json["has_matterport"] == null ? null : json["has_matterport"],
  );

  Map<String, dynamic> toJson() => {
    "has_open_house": hasOpenHouse,
    "is_co_broke_email": isCoBrokeEmail,
    "is_co_broke_phone": isCoBrokePhone,
    "is_new_listing": isNewListing,
    "is_new_plan": isNewPlan,
    "is_office_standard_listing": isOfficeStandardListing,
    "is_showcase": isShowcase,
    "is_showcase_choice_enabled": isShowcaseChoiceEnabled,
    "is_turbo": isTurbo,
    "lead_form_phone_required": leadFormPhoneRequired,
    "presentation_status": channelValues.reverse[presentationStatus],
    "price_change": priceChange,
    "show_contact_a_lender_in_lead_form": showContactALenderInLeadForm,
    "show_veterans_united_in_lead_form": showVeteransUnitedInLeadForm,
    "suppress_map_pin": suppressMapPin,
    "advantage_pro_flag": advantageProFlag == null ? null : advantageProFlag,
    "has_matterport": hasMatterport == null ? null : hasMatterport,
  };
}

enum DataSourceName { MLS }

final dataSourceNameValues = EnumValues({
  "mls": DataSourceName.MLS
});

class LeadForms {
  LeadForms({
    this.cashbackEnabled,
    this.flipTheMarketEnabled,
    this.form,
    this.formType,
    this.isLcmEnabled,
    this.leadType,
    this.showAgent,
    this.showBroker,
    this.showBuilder,
    this.showContactALender,
    this.showTextLeads,
    this.showVeteransUnited,
    this.smarthomeEnabled,
  });

  bool cashbackEnabled;
  bool flipTheMarketEnabled;
  Form form;
  FormType formType;
  bool isLcmEnabled;
  LeadType leadType;
  bool showAgent;
  bool showBroker;
  bool showBuilder;
  bool showContactALender;
  bool showTextLeads;
  bool showVeteransUnited;
  bool smarthomeEnabled;

  factory LeadForms.fromJson(Map<String, dynamic> json) => LeadForms(
    cashbackEnabled: json["cashback_enabled"],
    flipTheMarketEnabled: json["flip_the_market_enabled"],
    form: Form.fromJson(json["form"]),
    formType: formTypeValues.map[json["form_type"]],
    isLcmEnabled: json["is_lcm_enabled"],
    leadType: leadTypeValues.map[json["lead_type"]],
    showAgent: json["show_agent"],
    showBroker: json["show_broker"],
    showBuilder: json["show_builder"],
    showContactALender: json["show_contact_a_lender"],
    showTextLeads: json["show_text_leads"],
    showVeteransUnited: json["show_veterans_united"],
    smarthomeEnabled: json["smarthome_enabled"],
  );

  Map<String, dynamic> toJson() => {
    "cashback_enabled": cashbackEnabled,
    "flip_the_market_enabled": flipTheMarketEnabled,
    "form": form.toJson(),
    "form_type": formTypeValues.reverse[formType],
    "is_lcm_enabled": isLcmEnabled,
    "lead_type": leadTypeValues.reverse[leadType],
    "show_agent": showAgent,
    "show_broker": showBroker,
    "show_builder": showBuilder,
    "show_contact_a_lender": showContactALender,
    "show_text_leads": showTextLeads,
    "show_veterans_united": showVeteransUnited,
    "smarthome_enabled": smarthomeEnabled,
  };
}

class Form {
  Form({
    this.email,
    this.message,
    this.name,
    this.phone,
    this.show,
  });

  Email email;
  Email message;
  Email name;
  Phone phone;
  bool show;

  factory Form.fromJson(Map<String, dynamic> json) => Form(
    email: Email.fromJson(json["email"]),
    message: Email.fromJson(json["message"]),
    name: Email.fromJson(json["name"]),
    phone: Phone.fromJson(json["phone"]),
    show: json["show"],
  );

  Map<String, dynamic> toJson() => {
    "email": email.toJson(),
    "message": message.toJson(),
    "name": name.toJson(),
    "phone": phone.toJson(),
    "show": show,
  };
}

class Email {
  Email({
    this.minimumCharacterCount,
    this.required,
  });

  int minimumCharacterCount;
  bool required;

  factory Email.fromJson(Map<String, dynamic> json) => Email(
    minimumCharacterCount: json["minimum_character_count"],
    required: json["required"],
  );

  Map<String, dynamic> toJson() => {
    "minimum_character_count": minimumCharacterCount,
    "required": required,
  };
}

class Phone {
  Phone({
    this.maximumCharacterCount,
    this.minimumCharacterCount,
    this.required,
  });

  int maximumCharacterCount;
  int minimumCharacterCount;
  bool required;

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
    maximumCharacterCount: json["maximum_character_count"],
    minimumCharacterCount: json["minimum_character_count"],
    required: json["required"],
  );

  Map<String, dynamic> toJson() => {
    "maximum_character_count": maximumCharacterCount,
    "minimum_character_count": minimumCharacterCount,
    "required": required,
  };
}

enum FormType { CLASSIC }

final formTypeValues = EnumValues({
  "classic": FormType.CLASSIC
});

enum LeadType { CO_BROKE, ADVANTAGE_PRO }

final leadTypeValues = EnumValues({
  "advantage_pro": LeadType.ADVANTAGE_PRO,
  "co_broke": LeadType.CO_BROKE
});

class Mls {
  Mls({
    this.abbreviation,
    this.id,
    this.name,
    this.planId,
    this.type,
  });

  Abbreviation abbreviation;
  String id;
  Name name;
  dynamic planId;
  DataSourceName type;

  factory Mls.fromJson(Map<String, dynamic> json) => Mls(
    abbreviation: abbreviationValues.map[json["abbreviation"]],
    id: json["id"],
    name: nameValues.map[json["name"]],
    planId: json["plan_id"],
    type: dataSourceNameValues.map[json["type"]],
  );

  Map<String, dynamic> toJson() => {
    "abbreviation": abbreviationValues.reverse[abbreviation],
    "id": id,
    "name": nameValues.reverse[name],
    "plan_id": planId,
    "type": dataSourceNameValues.reverse[type],
  };
}

enum Abbreviation { GSNJ, BCNJ }

final abbreviationValues = EnumValues({
  "BCNJ": Abbreviation.BCNJ,
  "GSNJ": Abbreviation.GSNJ
});

enum Name { GARDEN_STATE, NEW_JERSEY_MLS }

final nameValues = EnumValues({
  "GardenState": Name.GARDEN_STATE,
  "NewJerseyMLS": Name.NEW_JERSEY_MLS
});

class Office {
  Office({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory Office.fromJson(Map<String, dynamic> json) => Office(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class OpenHouse {
  OpenHouse({
    this.dst,
    this.endDate,
    this.startDate,
    this.timeZone,
  });

  bool dst;
  DateTime endDate;
  DateTime startDate;
  String timeZone;

  factory OpenHouse.fromJson(Map<String, dynamic> json) => OpenHouse(
    dst: json["dst"],
    endDate: DateTime.parse(json["end_date"]),
    startDate: DateTime.parse(json["start_date"]),
    timeZone: json["time_zone"],
  );

  Map<String, dynamic> toJson() => {
    "dst": dst,
    "end_date": endDate.toIso8601String(),
    "start_date": startDate.toIso8601String(),
    "time_zone": timeZone,
  };
}

enum Product { CORE_AGENT, CO_BROKE, LISTING_OWNER_LEAD_AGENT, LISTING_OWNER_BRAND_AGENT }

final productValues = EnumValues({
  "core.agent": Product.CORE_AGENT,
  "co_broke": Product.CO_BROKE,
  "listing_owner_brand.agent": Product.LISTING_OWNER_BRAND_AGENT,
  "listing_owner_lead.agent": Product.LISTING_OWNER_LEAD_AGENT
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
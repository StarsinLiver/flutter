class GoogleMapGeocodingDto {
  PlusCode plusCode;
  List<Results> results;

  GoogleMapGeocodingDto(this.plusCode, this.results);

  factory GoogleMapGeocodingDto.fromJson(Map<String, dynamic> json) {
    PlusCode plusCodeJson = PlusCode.fromJson(json['plus_code']);

    List<Results> resultsJson =
        (json['results'] as List).map((e) => Results.fromJson(e)).toList();

    return GoogleMapGeocodingDto(plusCodeJson, resultsJson);
  }

  @override
  String toString() {
    return 'GoogleMapGeocodingDto{plusCode: $plusCode, results: $results}';
  }
}

class PlusCode {
  String compoundCode;
  String globalCode;

  PlusCode(this.compoundCode, this.globalCode);

  factory PlusCode.fromJson(Map<String, dynamic> json) {
    String compoundCodeJson = json['compound_code'] ?? "";
    String globalCodeJson = json['global_code'] ?? "";

    return PlusCode(compoundCodeJson, globalCodeJson);
  }

  @override
  String toString() {
    return 'PlusCode{compoundCode: $compoundCode, globalCode: $globalCode}';
  }
}

class Results {
  List<AddressComponents> addressComponents;
  String formattedAddress;
  Geometry geometry;
  String placeId;
  List<dynamic> types;

  Results(this.addressComponents, this.formattedAddress, this.geometry,
      this.placeId, this.types);

  factory Results.fromJson(Map<String, dynamic> json) {
    List<AddressComponents> addressComponentsJson =
        (json['address_components'] as List)
            .map((e) => AddressComponents.fromJson(e))
            .toList();
    String formattedAddressJson = json['formatted_address'] ?? "";
    Geometry geometryJson = Geometry.fromJson(json['geometry']);
    String placeIdJson = json['place_id'] ?? "";
    List<dynamic> typesJson = json['types'] as List<dynamic> ?? [];

    return Results(addressComponentsJson, formattedAddressJson, geometryJson,
        placeIdJson, typesJson);
  }

  @override
  String toString() {
    return 'Results{addressComponents: $addressComponents, formattedAddress: $formattedAddress, geometry: $geometry, placeId: $placeId, types: $types}';
  }
}

class AddressComponents {
  String longName;
  String shortName;
  List<dynamic> types;

  AddressComponents(this.longName, this.shortName, this.types);

  factory AddressComponents.fromJson(Map<String, dynamic> json) {
    String longNameJson = json['long_name'] ?? "";
    String shortNameJson = json['short_name'] ?? "";
    // 교체 필요
    List<dynamic> typesJson = json['types'] as List<dynamic> ?? [];

    return AddressComponents(longNameJson, shortNameJson, typesJson);
  }

  @override
  String toString() {
    return 'AddressComponents{longName: $longName, shortName: $shortName, types: $types}';
  }
}

class Geometry {
  // Bounds bounds; // 해당 오류
  Location location;
  String locationType;
  ViewPort viewPort;

  // Geometry(this.bounds, this.location, this.locationType, this.viewPort);
  Geometry(this.location, this.locationType, this.viewPort);

  factory Geometry.fromJson(Map<String, dynamic> json) {
    // Bounds boundsJson = Bounds.fromJson(json['bounds']) ?? null;
    Location locationJson = Location.fromJson(json['location']);
    String locationTypeJson = json['location_type'] ?? "";
    ViewPort viewPortJson = ViewPort.fromJson(json['viewport']);

    return Geometry(locationJson, locationTypeJson, viewPortJson);
  }

  @override
  String toString() {
    return 'Geometry{location: $location, locationType: $locationType, viewPort: $viewPort}';
  }
}

class ViewPort {
  Northeast northeast;
  Southwest southwest;

  ViewPort(this.northeast, this.southwest);

  factory ViewPort.fromJson(Map<String, dynamic> json) {
    Northeast northeastJson = Northeast.fromJson(json['northeast']);
    Southwest southwestJson = Southwest.fromJson(json['southwest']);

    return ViewPort(northeastJson, southwestJson);
  }

  @override
  String toString() {
    return 'ViewPort{northeast: $northeast, southwest: $southwest}';
  }
}

class Location {
  double lat;
  double lng;

  Location(this.lat, this.lng);

  factory Location.fromJson(Map<String, dynamic> json) {
    double latJson = json['lat'];
    double lngJson = json['lng'];

    return Location(latJson, lngJson);
  }

  @override
  String toString() {
    return 'Location{lat: $lat, lng: $lng}';
  }
}

class Bounds {
  Northeast northeast;
  Southwest southwest;

  Bounds(this.northeast, this.southwest);

  factory Bounds.fromJson(Map<String, dynamic> json) {
    Northeast northeastJson = Northeast.fromJson(json['northeast']);
    Southwest southwestJson = Southwest.fromJson(json['southwest']);

    return Bounds(northeastJson, southwestJson);
  }

  @override
  String toString() {
    return 'Bounds{northeast: $northeast, southwest: $southwest}';
  }
}

class Northeast {
  double lat;
  double lng;

  Northeast(this.lat, this.lng);

  factory Northeast.fromJson(Map<String, dynamic> json) {
    double latJson = json['lat'];
    double lngJson = json['lng'];

    return Northeast(latJson, lngJson);
  }

  @override
  String toString() {
    return 'Northeast{lat: $lat, lng: $lng}';
  }
}

class Southwest {
  double lat;
  double lng;

  Southwest(this.lat, this.lng);

  factory Southwest.fromJson(Map<String, dynamic> json) {
    double latJson = json['lat'];
    double lngJson = json['lng'];

    return Southwest(latJson, lngJson);
  }

  @override
  String toString() {
    return 'Southwest{lat: $lat, lng: $lng}';
  }
}

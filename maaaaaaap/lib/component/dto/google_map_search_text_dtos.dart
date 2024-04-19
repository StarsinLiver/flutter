class GoogleMapSearchTextBody {
  String textQuery;
  String languageCode;
  int maxResultCount;
  LocationBias locationBias;

  GoogleMapSearchTextBody(
      {this.textQuery = "",
        this.languageCode = "ko",
        this.maxResultCount = 10,
        required this.locationBias});

  Map<String, dynamic> toJson() {
    return {
      'textQuery': textQuery,
      'languageCode': languageCode,
      'maxResultCount': maxResultCount,
      'locationBias': locationBias.toJson(),
    };
  }

  @override
  String toString() {
    return 'GoogleMapSearchTextBody{textQuery: $textQuery, languageCode: $languageCode, maxResultCount: $maxResultCount, locationBias: $locationBias}';
  }
}

class LocationBias {
  Circle circle;

  LocationBias({required this.circle});

  Map<String, dynamic> toJson() {
    return {
      'circle': circle.toJson(),
    };
  }

  @override
  String toString() {
    return 'LocationBios{circle: $circle}';
  }
}

class Circle {
  double radius;

  Circle({this.radius = 500.0});

  Map<String, dynamic> toJson() {
    return {
      'radius': radius,
    };
  }

  @override
  String toString() {
    return 'Circle{radius: $radius}';
  }
}

class Places {
  String formattedAddress;
  LocationApi location;
  DisplayName displayName;
  String rating;
  String websiteUri;
  List<Photos> photos;

  Places(
      {required this.formattedAddress,
        required this.location,
        required this.displayName,
        required this.rating,
        this.websiteUri = "",
        required this.photos});

  factory Places.fromJson(Map<String, dynamic> json) {
    String formattedAddressJson = json['formattedAddress'];
    print("formattedAddressJson : " + formattedAddressJson);
    LocationApi locationJson = LocationApi.fromJson(json['location']);
    print("locationJson : " + locationJson.toString());
    DisplayName displayNameJson = DisplayName.fromJson(json['displayName']);
    print("displayNameJson : " + displayNameJson.toString());
    String ratingJson = json['rating'].toString() ?? "0.0";
    print("ratingJson : " + ratingJson.toString());
    String websiteUriJson =
    json['websiteUri'] ?? "";
    print("websiteUriJson : " + websiteUriJson);
    List<Photos> photosJson = json['photos'] == null ? [] :
    (json['photos'] as List).map((e) => Photos.fromJson(e)).toList();
    print("photosJson : " + photosJson.toString()) ;

    return Places(
      formattedAddress: formattedAddressJson,
      location: locationJson,
      displayName: displayNameJson,
      rating: ratingJson,
      websiteUri: websiteUriJson,
      photos: photosJson,
    );
  }

  @override
  String toString() {
    return 'Places{formattedAddress: $formattedAddress, location: $location, displayName: $displayName, rating: $rating, websiteUri: $websiteUri, photos: $photos}';
  }
}

class LocationApi {
  double latitude;
  double longitude;

  LocationApi.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'];

  @override
  String toString() {
    return 'Location{latitude: $latitude, longitude: $longitude}';
  }
}

class DisplayName {
  String text;
  String languageCode; // 수정: 올바른 키 이름 사용

  DisplayName.fromJson(Map<String, dynamic> json)
      : text = json['text'] ?? "",
        languageCode = json['languageCode'] ?? ""; // 수정: 올바른 키 이름 사용

  @override
  String toString() {
    return 'DisplayName{text: $text, languageCode: $languageCode}'; // 수정: 올바른 변수명 사용
  }
}

class Photos {
  String name;
  int widthPx;
  int heightPx;
  List<AuthorAttributions> authorAttributions;

  Photos(
      {required this.name,
        required this.widthPx,
        required this.heightPx,
        required this.authorAttributions});

  factory Photos.fromJson(Map<String, dynamic> json) {
    String nameJson = json['name'] ?? "";
    int widthPxJson = json['widthPx'] ?? 0.0;
    int heightPxJson = json['heightPx'] ?? 0.0;
    List<AuthorAttributions> authorAttributionsJson =
    (json['authorAttributions'] as List)
        .map((e) => AuthorAttributions.fromJson(e))
        .toList();

    return Photos(
        name: nameJson,
        widthPx: widthPxJson,
        heightPx: heightPxJson,
        authorAttributions: authorAttributionsJson);
  }

  @override
  String toString() {
    return 'Photos{name: $name, widthPx: $widthPx, heightPx: $heightPx, authorAttributions: $authorAttributions}';
  }
}

class AuthorAttributions {
  String displayName;
  String uri;
  String photoUri;

  AuthorAttributions.fromJson(Map<String, dynamic> json)
      : displayName = json['displayName'] ?? "",
        uri = json['uri'] ?? "",
        photoUri = json['photoUri'] ?? "";

  @override
  String toString() {
    return 'AuthorAttributions{displayName: $displayName, uri: $uri, photoUri: $photoUri}';
  }
}

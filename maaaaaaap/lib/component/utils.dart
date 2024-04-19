class Utils {
  static final googleApiKey = "";

  // google map / distance matrix url
  static final googleMapDistanceMatrixApiUrl = "https://maps.googleapis.com/maps/api/distancematrix/json";
  static final googleMapSearchTextApiUtl = "https://places.googleapis.com/v1/places:searchText";
  static final googleMapPhotoApiUrl = "https://places.googleapis.com/v1/";
  static final googleMapPhotoApiMediaParm = "/media?maxHeightPx=50&maxWidthPx=50";
  static final fieldMask = "places.displayName,places.formattedAddress,places.websiteUri,places.location,places.photos,places.rating";
  static final googleMapGeocodingApiUrl = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=';
  
  // 장소 세부 정보 가져오기
  static final googleMapPlaceDetialApiUrl = 'https://places.googleapis.com/v1/places/';
  static final googleMapPlaceDetailFields = '?fields=displayName,formattedAddress,websiteUri,location,photos,rating';
}
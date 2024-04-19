import 'dart:async';
import 'dart:convert';

import 'package:google_map/component/dto/google_map_geocoding_dto.dart';
import 'package:google_map/component/dto/google_map_search_text_dtos.dart';
import 'package:google_map/component/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googleMap;
import 'package:http/http.dart' as http;

class GoogleMapService {
  GoogleMapService();

  // 텍스트 서치 api 호출
  Future<List<Places>> getSearchTextApi(
      String text, String languageCode, int maxResultCount) async {
    // header 구성
    Map<String, String> header = {
      "X-Goog-Api-Key": Utils.googleApiKey,
      "X-Goog-FieldMask": Utils.fieldMask,
      "Content-Type": "application/json",
    };

    // 바디 구성
    Circle circle = Circle();
    LocationBias locationBias = LocationBias(circle: circle);
    GoogleMapSearchTextBody body = GoogleMapSearchTextBody(
        textQuery: text,
        languageCode: languageCode,
        maxResultCount: maxResultCount,
        locationBias: locationBias);

    // 바디 json 변환
    String bodyJson = json.encode(body.toJson());

    // API 요청
    List<Places> places = [];
    try {
      var response = await http.post(Uri.parse(Utils.googleMapSearchTextApiUtl),
          body: bodyJson, headers: header);
      // final int statusCode = response.statusCode;
      final String data = response.body;

      // 변환
      Map<String, dynamic> mapData =
          await json.decode(data); // 문자열 JSON을 Map으로 변환
      print("mapData : " + mapData.toString());
      List<dynamic> listData = mapData['places'];
      places = listData.map((e) => Places.fromJson(e)).toList();

      return places;
    } catch (e) {
      print("에러");
      return places;
    }
  }

  // 역 지오코딩
  Future<dynamic> getGeocodingApi(googleMap.LatLng latLng ,String languageCode) async {
    String uri =
        '${Utils.googleMapGeocodingApiUrl}${latLng.latitude},${latLng.longitude}&languageCode=${languageCode}&key=${Utils.googleApiKey}';

    try {
      var response = await http.get(Uri.parse(uri));
      // final int statusCode = response.statusCode;
      final String data = response.body;

      // 변환
      Map<String, dynamic> mapData =
          await json.decode(data); // 문자열 JSON을 Map으로 변환
      print(mapData.toString());

      // 디코딩
      GoogleMapGeocodingDto dto = GoogleMapGeocodingDto.fromJson(mapData);

      return dto;

    } catch (e) {
      print('getGeocodingApi () 에러');
      return null;
    }
  }

  // 장소 세부정보 가져오기
  Future<Places> getPlaceDetailApi(String placeId , String languageCode) async {

    String uri = '${Utils.googleMapPlaceDetialApiUrl}${placeId}${Utils.googleMapPlaceDetailFields}&languageCode=${languageCode}&key=${Utils.googleApiKey}';
    var response = await http.get(Uri.parse(uri));
    final String data = response.body;
    Map<String, dynamic> mapData =
    await json.decode(data); // 문자열 JSON을 Map으로 변환

    print("mapData : ${mapData.toString()}");
    print("\n");

    Places place = Places.fromJson(mapData);

    return place;
  }

}

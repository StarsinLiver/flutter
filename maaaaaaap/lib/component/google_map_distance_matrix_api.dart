import 'dart:convert';
import 'package:google_map/component/distance_matrix_parameter.dart';
import 'package:google_map/component/todo_item.dart';
import 'package:google_map/component/utils.dart';
import 'package:http/http.dart' as http;

class DistanceMatrix {
  final List<String> destinations;
  final List<String> origins;
  final List<Element> elements;
  final String status;

  DistanceMatrix(
      {required this.destinations,
      required this.origins,
      required this.elements,
      required this.status});

  factory DistanceMatrix.fromJson(Map<String, dynamic> json) {
    var destinationsJson = json['destination_addresses'];
    var originsJson = json['origin_addresses'];
    var rowsJson = json['rows'][0]['elements'] as List;

    return DistanceMatrix(
        destinations: destinationsJson.cast<String>(),
        origins: originsJson.cast<String>(),
        elements: rowsJson.map((i) => new Element.fromJson(i)).toList(),
        status: json['status']);
  }

  // 여러개의 리스트 api 호출
  static Future<DistanceMatrix> loadData(
      {required List<DistanceMatrixParameter>
          distancMatrixParameterList}) async {
    var distanceMatrix;
    try {
      String jsonData = await makeUrlAndGetDistanceMatrixApi(
          distancMatrixParameterList: distancMatrixParameterList);

      Map<String , dynamic> mapData = json.decode(jsonData);
      distanceMatrix = new DistanceMatrix.fromJson(mapData);
    } catch (e) {
      throw Exception("런타임 오류");
    }
    return distanceMatrix;
  }

  // api 한번만 호출
  static Future<DistanceMatrix> loadDataOnce(
      {required DistanceMatrixParameter distancMatrixParameter}) async {
    var distanceMatrix;
    try {
      String jsonData = await makeUrlAndGetDistanceMatrixApiOnce(
          distancMatrixParameter: distancMatrixParameter);
      distanceMatrix = DistanceMatrix.fromJson(json.decode(jsonData));
    } catch (e) {
      throw Exception("런타임 오류");
    }
    return distanceMatrix;
  }

  // url 을 만들어서 api 호출
  static Future<dynamic> makeUrlAndGetDistanceMatrixApi(
      {required List<DistanceMatrixParameter>
          distancMatrixParameterList}) async {

    String makeDestinationsParam = '';
    String makeOriginsParam = '';
    distancMatrixParameterList.map((e) {
      String DestinationsParam = '${e.startLatitude},${e.startLongitude}|';
      String originsParam = '${e.endLatitude},${e.endLongitude}|';
      makeDestinationsParam += DestinationsParam;
      makeOriginsParam += originsParam;
    }).toString();

    String url =
        '${Utils.googleMapDistanceMatrixApiUrl}?destinations=$makeDestinationsParam&origins=$makeOriginsParam&${Utils.googleApiKey}';

    return googleDistanceMatrixApi(url);
  }

  // url 을 만들어서 api 호출
  static Future<dynamic> makeUrlAndGetDistanceMatrixApiOnce(
      {required DistanceMatrixParameter distancMatrixParameter}) async {
    String makeDestinationsParam =
        '${distancMatrixParameter.startLatitude},${distancMatrixParameter.startLongitude}';
    String makeOriginsParam =
        '${distancMatrixParameter.endLatitude},${distancMatrixParameter.endLongitude}';

    String url =
        '${Utils.googleMapDistanceMatrixApiUrl}?destinations=$makeDestinationsParam&origins=$makeOriginsParam&key=${Utils.googleApiKey}';
    return googleDistanceMatrixApi(url);
  }

  // 거리 리스트 -> 리스트를 정리 후 api 호출
  static Future<DistanceMatrix> getGoogleDistance(
      List<TodoMarker> markers, int startIndex, int maxNumber) async {
    List<DistanceMatrixParameter> distancMatrixParameterList = [];
    int maxIndex = (markers.length - 1 < startIndex + maxNumber)
        ? markers.length - 1
        : startIndex + maxNumber;
    print("maxIndex : " + maxIndex.toString());

    for (int i = startIndex; i < maxIndex; i++) {
      DistanceMatrixParameter distanceMatrix = DistanceMatrixParameter(
        startLatitude: markers[i].position.latitude,
        startLongitude: markers[i].position.longitude,
        endLatitude: markers[i + 1].position.latitude,
        endLongitude: markers[i + 1].position.longitude,
      );

      distancMatrixParameterList.add(distanceMatrix);
    }
    late DistanceMatrix data;
    // try {
    data = await DistanceMatrix.loadData(
        distancMatrixParameterList: distancMatrixParameterList);
    return data;
  }

  // 거리 마커 -> 정리 후 api 호출
  static Future<DistanceMatrix> getGoogleDistanceOnce(
      List<TodoMarker> markers, int startIndex, int lastIndex) async {
    DistanceMatrixParameter distancMatrixParameter = DistanceMatrixParameter(
      startLatitude: markers[startIndex].position.latitude,
      startLongitude: markers[startIndex].position.longitude,
      endLatitude: markers[lastIndex].position.latitude,
      endLongitude: markers[lastIndex].position.longitude,
    );

    late DistanceMatrix data;

    data = await DistanceMatrix.loadDataOnce(
        distancMatrixParameter: distancMatrixParameter);
    return data;
  }

  // 최종 api 호출
  static Future<dynamic> googleDistanceMatrixApi(String url) async {
    try {
      var response = await http.get(
        Uri.parse(url),
      );

      print("받은 데이터 : " + response.body);

      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  String toString() {
    return 'DistanceMatrix{destinations: $destinations, origins: $origins, elements: $elements, status: $status}';
  }
}

class Element {
  final Distance distance;
  final Duration duration;
  final String status;

  Element(
      {required this.distance, required this.duration, required this.status});

  factory Element.fromJson(Map<String, dynamic> json) {
    return Element(
        distance: json['distance'] == null ? Distance(text: "정보가 없습니다." , value: 0) : Distance.fromJson(json['distance']),
        duration: json['duration'] == null ? Duration(text: "정보가 없습니다." , value: 0) : Duration.fromJson(json['duration']),
        status: json['status']);
  }

  @override
  String toString() {
    return 'Element{distance: $distance, duration: $duration, status: $status}';
  }
}

class Distance {
  final String text;
  final int value;

  Distance({required this.text, required this.value});

  factory Distance.fromJson(Map<String, dynamic> json) {
    return Distance(text: json['text'], value: json['value']);
  }

  @override
  String toString() {
    return 'Distance{text: $text, value: $value}';
  }
}

class Duration {
  final String text;
  final int value;

  Duration({required this.text, required this.value});

  factory Duration.fromJson(Map<String, dynamic> json) {
    return Duration(text: json['text'], value: json['value']);
  }

  @override
  String toString() {
    return 'Duration{text: $text, value: $value}';
  }
}

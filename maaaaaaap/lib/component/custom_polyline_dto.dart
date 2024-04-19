import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomPolylineDto {
  double startLatitude;
  double startLongitude;
  double endLatitude;
  double endLogitude;
  String startAddress;
  String endAddress;
  String distance;
  String duration;
  double distanceValue;
  double durationValue;

  CustomPolylineDto({
    this.startLongitude = 0,
    this.startLatitude = 0,
    this.endLatitude = 0,
    this.endLogitude = 0,
    this.startAddress = "",
    this.endAddress = "",
    this.distance = "",
    this.duration = "",
    this.distanceValue = 0,
    this.durationValue = 0,
  });

  List<LatLng> getPolylineCoordinates () {
    return [LatLng(startLatitude , startLongitude) , LatLng(endLatitude, endLogitude)];
  }
}

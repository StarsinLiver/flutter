import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_map/component/todo_item.dart';
import 'package:google_map/component/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapDirection {
  // 폴리 포인트
  PolylinePoints polylinePoints = PolylinePoints();

  TravelMode travleMode;

  GoogleMapDirection({this.travleMode = TravelMode.driving});

// Direction api 호출 여러번
  Future<List<LatLng>> getDirections(List<TodoMarker> markers, var addPolyline) async {
      List<LatLng> polylineCoordinates = [];
      // result gets little bit late as soon as in video, because package // send http request for getting real road routes
      int polyId = 0;
      for (int i = 0; i < markers.length - 1; i++) {
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          Utils.googleApiKey, //GoogleMap ApiKey
          PointLatLng(
              markers[i].position.latitude, markers[i].position.longitude),
          //first added marker
          PointLatLng(markers[i + 1].position.latitude,
              markers[i + 1].position.longitude),
          //last added marker
// define travel mode driving for real roads
          travelMode: travleMode,
// waypoints is markers that between first and last markers        wayPoints: polylineWayPoints
        );
        // Sometimes There is no result for example you can put maker to the // ocean, if results not empty adding to polylineCoordinates
// Sometimes There is no result for example you can put maker to the // ocean, if results not empty adding to polylineCoordinates
        if (result.points.isNotEmpty) {
          result.points.forEach((PointLatLng point) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          });
          polyId++;
          addPolyline(polylineCoordinates, polyId, result);
        } else {
          print(result.errorMessage);
        }
      }
      return polylineCoordinates;
  }

  // Direction api 호출 한번만
  Future<List<LatLng>> getDirectionsOnce(
      List<TodoMarker> markers, int startIndex, int lastIndex , addPolyline) async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Utils.googleApiKey, //GoogleMap ApiKey
      PointLatLng(markers[startIndex].position.latitude,
          markers[startIndex].position.longitude),
      //first added marker
      PointLatLng(markers[lastIndex].position.latitude,
          markers[lastIndex].position.longitude),
      //last added marker
// define travel mode driving for real roads
      travelMode: travleMode,
// waypoints is markers that between first and last markers        wayPoints: polylineWayPoints
    );
    // Sometimes There is no result for example you can put maker to the // ocean, if results not empty adding to polylineCoordinates
// Sometimes There is no result for example you can put maker to the // ocean, if results not empty adding to polylineCoordinates
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      addPolyline(polylineCoordinates, startIndex, result);
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }
}

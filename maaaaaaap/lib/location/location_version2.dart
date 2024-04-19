import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationVersion2 extends StatefulWidget {
  const LocationVersion2({super.key});

  @override
  State<LocationVersion2> createState() => _LocationTestState();
}

class _LocationTestState extends State<LocationVersion2> {
  final Completer<GoogleMapController> _controller = Completer();
  LocationData? currentLocation;
  bool isLocation = false;
  double cameraZoom = 13.5;


  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  // 마커
  List<Marker> _markers = [];
  List<Polyline> _polylines = [];

  @override
  void initState() {
    getCurrentLocation();
    // getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLocation
          ? const Center(child: Text("Loading"))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: cameraZoom,
              ),
              markers: {
                // 현재 내위치 마커
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                // 추가된 마커
              }.union(Set.from(_markers)),
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
              onCameraMove: (position) {
                cameraZoom = position.zoom;
              },
              polylines: Set.from(_polylines),
            ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  // 플로팅 버튼을 누른다면..
  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        // 마커 추가
        Marker marker = Marker(
            markerId: MarkerId('${_markers.length}'),
            draggable: true,
            infoWindow: InfoWindow(
              title: "${_markers.length} 번 입니다.",
              snippet: "Google's 맵 테스트용",
              onTap: () {
                // 여기에서 다양한 것들 꾸리기
              }
            ),
            position: LatLng(
                currentLocation!.latitude!, currentLocation!.longitude!));
        _markers.add(marker);

        print('${_markers.length} 번의 마커가 추가되었습니다.');

        // 거리 측정
        getDistance();

        // polyline 추가
        _drawPolyline();
      },
      label: const Text('add marker!'),
      icon: const Icon(Icons.directions_boat),
    );
  }

// 거리 정보 찾기
  void getDistance() async {
    if (_markers.length > 1) {
      for (int i = 0; i < _markers.length - 1; i++) {
        print("startLatitude : " + _markers[i].position.latitude.toString());
        print("startLongitude : " + _markers[i].position.longitude.toString());
        print("endLatitude : " + _markers[i + 1].position.latitude.toString());
        print(
            "endLongitude : " + _markers[i + 1].position.longitude.toString());

        try {
          // DistanceMatrix distanceMatri = await DistanceMatrix.loadData(
          //   startLatitude: _markers[i].position.latitude,
          //   startLongitude: _markers[i].position.longitude,
          //   endLatitude: _markers[i + 1].position.latitude,
          //   endLongitude: _markers[i + 1].position.longitude,
          // );
          // print("받은 데이터 : " + distanceMatri.toString());
        } catch (e) {
          print("정보를 찾을 수 없습니다.");
        }
      }
    }
  }

  // List<LatLng> polylineCoordinates = [];
  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     'AIzaSyAGpnIV7bSP74QdGHil6t_-Onx0cUemjKw', // Your Google Map Key
  //     PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
  //     PointLatLng(destination.latitude, destination.longitude),
  //   );
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach(
  //           (PointLatLng point) => polylineCoordinates.add(
  //         LatLng(point.latitude, point.longitude),
  //       ),
  //     );
  //     setState(() {});
  //   }
  // }

  void _drawPolyline() {
    // length 가 2 이상일 경우 그리기
    if (_markers.length >= 2 && !_markers.isEmpty)
      for (int i = 0; i < _markers.length - 1; i++) {
        Polyline polyline = Polyline(
          polylineId: PolylineId('$i'),
          // 탭 이벤트 활성화
          consumeTapEvents: true,
          onTap: () {
            return print("$i 번 폴리라인");
          },
          points: [
            LatLng(
                _markers[i].position.latitude, _markers[i].position.longitude),
            LatLng(_markers[i + 1].position.latitude,
                _markers[i + 1].position.longitude)
          ],
        );
        _polylines.add(polyline);
      }
  }

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
        isLocation = true;
        // 어쨌든 있어야 하네...
        setState(() {
          print("정보를 받았습니다. ");
          print(location.latitude.toString());
          print(location.longitude.toString());
        });
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        // googleMapController.animateCamera(
        //   CameraUpdate.newCameraPosition(
        //     CameraPosition(
        //       zoom: cameraZoom,
        //       target: LatLng(
        //         newLoc.latitude!,
        //         newLoc.longitude!,
        //       ),
        //     ),
        //   ),
        // );
        setState(() {});
      },
    );
  }
}

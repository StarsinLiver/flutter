import 'dart:async';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_map/component/custom_polyline_dto.dart';
import 'package:google_map/component/dto/google_map_geocoding_dto.dart'
    as googleMapGeocoding;
import 'package:google_map/component/google_map_camera.dart';
import 'package:google_map/component/google_map_direction.dart';
import 'package:google_map/component/google_map_distance_matrix_api.dart';
import 'package:google_map/component/dto/google_map_search_text_dtos.dart';
import 'package:google_map/component/grabber.dart';
import 'package:google_map/component/todo_item.dart';
import 'package:google_map/component/item_box.dart';
import 'package:google_map/component/utils.dart';
import 'package:google_map/service/google_map_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modalSheet;
import 'package:uuid/uuid.dart';

class GoogleMapVersion6 extends StatefulWidget {
  const GoogleMapVersion6({super.key});

  @override
  State<GoogleMapVersion6> createState() => MapSampleState();
}

class MapSampleState extends State<GoogleMapVersion6> {
  // 구글 맵 컨트롤러
  late Completer<GoogleMapController> _controller;

  // 구글 맵
  late GoogleMap _googleMap;

  // 카메라
  late GoogleMapCamera _camera;

  // 구글 맵 서비스
  late GoogleMapService _googleMapService;

  // 난수 생성
  late Uuid uuid;

  String languageCode = "ko";

  // location
  Location location = Location();
  StreamSubscription<LocationData>? locationSubscription;
  late LocationData currentLocation;
  late GoogleMapDirection googleMapDiretion;

  // 폴리 포인트
  late PolylinePoints polylinePoints;

  late TravelMode travelMode;

  bool isLoaded = false;
  bool isIndoorViewEnabled = false;
  bool isTrafficEnabled = false;
  bool isBuildingsEnabled = false;
  bool isMapToolbarEnabled = false;
  bool isMarkerEnabled = false;
  bool isDrawedPolyline = false;
  bool isLocationEnabled = false;
  bool isLocationPermissionEnabled = false;

  final int VALUE =
      1; // 이 부분만 교체 가능 ( 다만 , 구글은 최대 10개 까지만 받음 , 따라서 사실상 변경 불가능 )
  final int MIN_VALUE = 10; // 이 부분 만지면 안됨

  final double initZoom = 1.0;
  late final double latitude;
  late final double longitude;
  double _sheetPosition = 0.5;
  final double _dragSensitivity = 600;
  double adjustmentLng = 1.0;

  final List<TodoMarker> _markers = [];
  final List<Polyline> _polylines = [];
  late List<Places> _searchPlaces;

  List<Item> items = [
    Item.disable,
    Item.marker,
    Item.polyline,
    Item.straightPolyline,
    Item.location,
    Item.clear
  ];
  Item? selectedValue = Item.disable;
  late Map<Item, ItemBoxDto> iconMap;

  @override
  void initState() {
    // 접근 권한 조회
    checkLocationPermission();
    // 컨트롤러 초기화
    _controller = Completer<GoogleMapController>();
    // 폴리 포인트 초기화
    polylinePoints = PolylinePoints();
    // 서비스 초기화
    _googleMapService = GoogleMapService();

    // 첫 트래블 모드
    travelMode = TravelMode.driving;

    // 난수 생성 초기화
    uuid = const Uuid();

    // 위치 초기화 ( 자신의 마지막 위치 알아오기 )
    latitude =
        (isLocationEnabled ? currentLocation.latitude : 37.43296265331129)!;
    longitude =
        (isLocationEnabled ? currentLocation.longitude : -122.08832357078792)!;

    // 카메라 초기화
    _camera =
        GoogleMapCamera(target: LatLng(latitude, longitude), zoom: initZoom);

    // 로딩 끝
    isLoaded = true;

    setState(() {});
    super.initState();
  }

  clearAllItem() {
    _polylines.clear();
    _markers.clear();
    isMarkerEnabled = false;
    isDrawedPolyline = false;
  }

  @override
  Widget build(BuildContext context) {
    // 구글 맵 초기화
    _googleMap = buildGoogleMap();
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("맵 지도"),
      ),
      body: isLoaded == false
          ? Container(
              child: Text("Loading ...."),
            )
          : Stack(
              children: [
                _googleMap,
                _buildSearchBox(),
                // _ItemBox(),
                _ItemBoxes(),
                _markers.length > 0
                    ? _buildDraggableScrollableSheet()
                    : SizedBox(),
              ],
            ),
      // 액션 버튼 누를 시
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // 새로고침 작업을 수행합니다.
          });
        },
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  // 드래그 바텀 시트
  DraggableScrollableSheet _buildDraggableScrollableSheet() {
    Color clickColor = Colors.lightGreen;

    return DraggableScrollableSheet(
      initialChildSize: _sheetPosition,
      builder: (context, scrollController) {
        return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Grabber(
                onVerticalDragUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _sheetPosition -= details.delta.dy / _dragSensitivity;
                    if (_sheetPosition < 0.25) {
                      _sheetPosition = 0.25;
                    }
                    if (_sheetPosition > 1.0) {
                      _sheetPosition = 1.0;
                    }
                  });
                },
                isOnDesktopAndWeb: _isOnDesktopAndWeb,
              ),
              const Icon(Icons.water),
              // Marker title , snippet
              _markers.isNotEmpty
                  ? Flexible(
                      child: ListView.builder(
                        controller:
                            _isOnDesktopAndWeb ? null : scrollController,
                        itemCount: _markers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              LatLng target = LatLng(
                                  _markers[index].position.latitude -
                                      adjustmentLng,
                                  _markers[index].position.longitude);
                              moveCamera(target);
                            },
                            child: Column(
                              children: [
                                Card(
                                  // color : index == _selectedIndex ? clickColor : null,
                                  elevation: 4,
                                  margin: EdgeInsets.all(8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: ListTile(
                                    leading: _markers[index]
                                                .place
                                                .photos
                                                .isEmpty ==
                                            false
                                        ? Image.network(getImageUrl(
                                            _markers[index]
                                                .place
                                                .photos[0]
                                                .name))
                                        : Image.asset('assets/empty_photo.png'),
                                    title: Text(
                                      _markers[index].infoWindow.title!,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                      ),
                                    ),
                                    subtitle: Text(
                                      _markers[index].infoWindow.snippet!,
                                      style: TextStyle(
                                        fontSize: 10.0,
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      // 크기 조절을 위해 mainAxisSize를 min으로 설정
                                      children: [
                                        // 추가
                                        IconButton(
                                            onPressed: () async {
                                              await _markers[index]
                                                  .addTodoItem(context);
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                                Icons.add_circle_outline)),
                                        // 삭제
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () async{
                                              // 마커 재분배
                                              await redistributionMarker(index);

                                              // 폴리 라인 재분배
                                              // _polylines.clear();
                                              await redistributionPolyline(index);
                                              setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // TodoItems title , Content
                                _markers[index].todoItem.isNotEmpty
                                    ? Card(
                                        elevation: 4,
                                        margin: EdgeInsets.all(8),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Column(
                                          children: _markers[index]
                                              .todoItem!
                                              .map((todoItem) {
                                            return ListTile(
                                              leading: Icon(Icons.toc),
                                              title: Text(todoItem.title),
                                              subtitle: Text(todoItem.content),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                // 크기 조절을 위해 mainAxisSize를 min으로 설정
                                                children: [
                                                  // 수정
                                                  IconButton(
                                                    icon: Icon(
                                                        Icons
                                                            .mode_edit_outline_outlined,
                                                        color: Colors.blue),
                                                    onPressed: () async {
                                                      await todoItem
                                                          .updateTodoItem(
                                                              context);
                                                      setState(() {});
                                                    },
                                                  ),
                                                  // 삭제
                                                  IconButton(
                                                    icon: Icon(Icons.delete,
                                                        color: Colors.red),
                                                    onPressed: () {
                                                      setState(() {
                                                        _markers[index]
                                                            .todoItem
                                                            .remove(todoItem);
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 10.0,
                                      ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox(
                      height: 10.0,
                    ),
            ],
          ),
        );
      },
    );
  }

  // 구글 카메라 업데이트
  Future<void> moveCamera(LatLng target) async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: target,
      zoom: _camera.zoom,
    )));
  }

  void initIconMap() {
    iconMap = {
      Item.disable: ItemBoxDto(Icons.disabled_by_default, "디폴트"),
      Item.marker: ItemBoxDto(
          isMarkerEnabled
              ? Icons.auto_fix_off_outlined
              : Icons.add_location_alt_outlined,
          "마킹"),
      Item.polyline: ItemBoxDto(
          isDrawedPolyline ? Icons.highlight_remove_rounded : Icons.line_axis,
          "도로 라인"),
      Item.straightPolyline: ItemBoxDto(
          isDrawedPolyline
              ? Icons.highlight_remove_rounded
              : Icons.straight_outlined,
          "직선 라인"),
      Item.location: ItemBoxDto(
          isLocationEnabled ? Icons.location_disabled : Icons.location_on,
          "위치 활성"),
      Item.clear: ItemBoxDto(Icons.clear, "전체 삭제"),
    };
  }

  // 아이콘 박스
  Widget _ItemBoxes() {
    // 아이콘 맵 초기화
    initIconMap();
    Size size = MediaQuery.of(context).size;
    double topSize = size.height * (1 / 10);
    double leftSize = size.height * (1 / 40);
    double roundSize = size.height * (1 / 20);
    return Padding(
      padding: EdgeInsets.only(top: topSize, left: leftSize),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              isMarkerEnabled = !isMarkerEnabled;
              setState(() {});
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                    color: Colors.white,
                    child: Icon(
                      iconMap[Item.marker]!.icon,
                      size: roundSize,
                    ))),
          ),
          const SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              isLocationEnabled = !isLocationEnabled;
              setState(() {});
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                    color: Colors.white,
                    child: Icon(
                      iconMap[Item.location]!.icon,
                      size: roundSize,
                    ))),
          ),
          const SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              clearAllItem();
              setState(() {});
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                    color: Colors.white,
                    child: Icon(
                      iconMap[Item.clear]!.icon,
                      size: roundSize,
                    ))),
          ),
        ],
      ),
    );
  }

  // 구글 맵
  GoogleMap buildGoogleMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _camera,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      onTap: (argument) async {
        // 마커 생성
        if (isMarkerEnabled) {
          // 장소 상세조회 api 호출
          LatLng latLng = LatLng(argument.latitude, argument.longitude);
          googleMapGeocoding.GoogleMapGeocodingDto geocoding =
              await _googleMapService.getGeocodingApi(latLng, languageCode);

          // 만약 geocoding 정보가 없다면
          if (geocoding == null)
            buildAlertDialog("잘못된 입력입니다.");
          else {
            // 만약 gecoding 정보가 있다면
            await buildShowDialogGoogleMapOnTap(geocoding);

            int startIndex = _markers.length - 2;
            int lastIndex = _markers.length - 1;
            await makeDistance(startIndex , lastIndex);
          }
        }
        setState(() {});
      },
      markers: _markers.toSet(),
      // 건물 내부 보기
      indoorViewEnabled: isIndoorViewEnabled,
      // 교통 상황
      trafficEnabled: isTrafficEnabled,
      // 빌딩 보기
      buildingsEnabled: isBuildingsEnabled,
      mapToolbarEnabled: isMapToolbarEnabled,
      // 자신 위치 알려주기
      myLocationEnabled: isLocationEnabled,
      myLocationButtonEnabled: isLocationEnabled,
      // 마커와 마커 사이의 선 긋기
      polylines: _polylines.toSet(),
    );
  }

  Future<void> makeDistance(int startIndex, int lastIndex) async {
    // 만약 마커가 두개 이상이라면? 해당 거리를 측정 , polyline 생성
    if (_markers.length > 1) {
      print("build distance");
      googleMapDiretion = GoogleMapDirection(travleMode: travelMode);
      try {
        await googleMapDiretion.getDirectionsOnce(
            _markers, startIndex, lastIndex, addPolyline);
      } catch (e) {
        // 만약 distance api 가 먹히지 않는다면 polyline 을 생성후 거리만 측정
        print("googlePolyline");
        await getGooglePolylineOnce(startIndex, lastIndex);
      }
    }
  }

  Future<dynamic> buildShowDialogGoogleMapOnTap(
      googleMapGeocoding.GoogleMapGeocodingDto geocoding) {
    Size media = MediaQuery.of(context).size;
    double size = 2 / 3;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: media.height * (size),
            width: media.width * (size),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: geocoding.results.length,
              itemBuilder: (context, index) {
                googleMapGeocoding.Results results = geocoding.results[index];
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "주소 : ${results.formattedAddress}",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: TextButton(
                              // 선택 클릭시
                              onPressed: () async {
                                // 플레이스 아이디값으로 세부 정보 찾기
                                Places place =
                                    await _googleMapService.getPlaceDetailApi(
                                        results.placeId, languageCode);
                                LatLng latLng = LatLng(place.location.latitude,
                                    place.location.longitude);
                                addMarker(latLng, place);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "선택",
                                style: TextStyle(fontSize: 13.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  bool get _isOnDesktopAndWeb {
    if (kIsWeb) {
      return true;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }

  // 마커 추가
  void addMarker(LatLng latLng, Places place) {
    int index = _markers.length;
    dynamic markerId = uuid.v1();

    TodoMarker? marker = null;

    marker = TodoMarker(
      order : index,
      place: place,
      todoItem: [],
      markerId: MarkerId('$markerId'),
      draggable: true,
      infoWindow: InfoWindow(
        title: place.formattedAddress,
        snippet: place.websiteUri,
        onTap: () {},
      ),
      position: LatLng(latLng.latitude, latLng.longitude),
    );

    _markers.add(marker);

    setState(() {});
  }

  // alert 창
  void buildAlertDialog(String title) {
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // 마커 재분배
  List<TodoMarker> redistributionMarker(int index) {
    List<TodoMarker> newList = [];
    int jumpIndex = 0;
    // 마커 아이디 재 분배
    for (int i = 0; i < _markers.length; i++) {
      TodoMarker currentMarker = _markers[i];

      if (currentMarker.order == index) {
        jumpIndex++;
        continue;
      }
      int newIndex = i - jumpIndex;
      TodoMarker newMarker = TodoMarker(
        order : newIndex,
        place: currentMarker.place,
        todoItem: currentMarker.todoItem,
        markerId: MarkerId('${currentMarker.markerId}'),
        draggable: true,
        infoWindow: InfoWindow(
            title: currentMarker.infoWindow.title,
            snippet: currentMarker.infoWindow.snippet,
            onTap: () {}),
        position: LatLng(
            currentMarker.position.latitude, currentMarker.position.longitude),
      );
      newList.add(newMarker);
    }
    _markers.clear();
    // 마커 재 분배
    _markers.addAll(newList);
    return newList;
  }

  // 폴리라인 재분배
  Future<void> redistributionPolyline(int startIndex)  async {
    // 해당 인덱스 폴리라인 교체

    late int lastIndex;
    // 제일 첫번째 인덱스 라면
    if(startIndex == 0) {
      print("startIndex : $startIndex");
      _polylines.removeAt(startIndex);
    }
    // 가운데 인덱스 라면
    else if(_markers.length == 2 || startIndex > 0 && startIndex < _polylines.length - 1) {
      startIndex = startIndex - 1;
      lastIndex = startIndex + 1;

      print("startIndex : $startIndex");
      print("lastIndex : $lastIndex");
      await makeDistance(startIndex, lastIndex);
      _polylines.removeAt(startIndex);
      _polylines.removeAt(lastIndex);
      final item = _polylines.removeLast();
      _polylines.insert(startIndex, item);
    }
    // 마지막 인덱스라면
    else if(_markers.length > 2 && startIndex == _polylines.length - 1) {
      print("startIndex : $startIndex--");
      _polylines.removeAt(startIndex--);
    }

    // Polyline 맨 뒤에 넣어짐
    // await makeDistance(startIndex, lastIndex);
    // 이전 폴리라인 삭제
    // _polylines.removeAt(startIndex);
    // _polylines.removeAt(lastIndex);


    // 새로운 폴리라인 (마지막 인덱스) 위치 변경
    // final item = _polylines.removeLast();
    // _polylines.insert(startIndex, item);
  }

  getGooglePolylineOnce(int startIndex, int lastIndex) async {
    try {
      // length 가 2 이상일 경우 그리기
      if (_markers.length >= 2 && _markers.isEmpty == false) {
        late DistanceMatrix distanceMatrix;

        distanceMatrix = await DistanceMatrix.getGoogleDistanceOnce(
            _markers, startIndex, lastIndex);

        double startLatitude = _markers[startIndex].position.latitude;
        double startLongitude = _markers[startIndex].position.longitude;
        double endLatitude = _markers[lastIndex].position.latitude;
        double endLongitude = _markers[lastIndex].position.longitude;
        String startAddress = distanceMatrix.destinations[0];
        String endAddress = distanceMatrix.origins[0];
        String distance = distanceMatrix.elements[0].distance.text;
        String duration = distanceMatrix.elements[0].duration.text;

        CustomPolylineDto data = CustomPolylineDto(
          startLatitude: startLatitude,
          startLongitude: startLongitude,
          endLatitude: endLatitude,
          endLogitude: endLongitude,
          startAddress: startAddress,
          endAddress: endAddress,
          distance: distance,
          duration: duration,
        );
        addPolyline(data.getPolylineCoordinates(), startIndex, data);
      }
    } catch (e) {
      buildAlertDialog("정보를 가져올 수 없습니다. 죄송합니다.");
      isDrawedPolyline = false;
      _polylines.clear();
    }
  }

  // google 직선 라인 한번에 그리기
  // getGooglePolyline() async {
  //   _polylines.clear();
  //   try {
  //     final int MAX_LIST = VALUE * MIN_VALUE;
  //     // length 가 2 이상일 경우 그리기
  //     if (_markers.length >= 2 && _markers.isEmpty == false) {
  //       late DistanceMatrix distanceMatrix;
  //
  //       for (int i = 0; i < _markers.length - 1; i++) {
  //         if (i % MAX_LIST == 0) {
  //           distanceMatrix =
  //               await DistanceMatrix.getGoogleDistance(_markers, i, MAX_LIST);
  //         }
  //         double startLatitude = _markers[i].position.latitude;
  //         double startLongitude = _markers[i].position.longitude;
  //         double endLatitude = _markers[i + 1].position.latitude;
  //         double endLongitude = _markers[i + 1].position.longitude;
  //         String startAddress =
  //             distanceMatrix.destinations[i >= MAX_LIST ? i % MAX_LIST : i];
  //         String endAddress =
  //             distanceMatrix.origins[i >= MAX_LIST ? i % MAX_LIST : i];
  //         String distance = distanceMatrix
  //             .elements[i >= MAX_LIST ? i % MAX_LIST : i].distance.text;
  //         String duration = distanceMatrix
  //             .elements[i >= MAX_LIST ? i % MAX_LIST : i].duration.text;
  //
  //         CustomPolylineDto data = CustomPolylineDto(
  //           startLatitude: startLatitude,
  //           startLongitude: startLongitude,
  //           endLatitude: endLatitude,
  //           endLogitude: endLongitude,
  //           startAddress: startAddress,
  //           endAddress: endAddress,
  //           distance: distance,
  //           duration: duration,
  //         );
  //         addPolyline(data.getPolylineCoordinates(), i, data);
  //       }
  //     }
  //   } catch (e) {
  //     buildAlertDialog("정보를 가져올 수 없습니다. 죄송합니다.");
  //     isDrawedPolyline = false;
  //     _polylines.clear();
  //   }
  //   setState(() {}); // 새로 고침
  // }

  // 폴리라인 추가
  addPolyline(List<LatLng> polylineCoordinates, int polyId, data) {
    Polyline polyline = Polyline(
      polylineId: PolylineId('$polyId'),
      color: Colors.blue,
      points: List<LatLng>.from(polylineCoordinates),
      width: 4,
      consumeTapEvents: true,
      onTap: () {
        modalSheet.showMaterialModalBottomSheet(
          context: context,
          enableDrag: true,
          expand: true,
          builder: (context) => Container(
            child: ListView(
              children: [
                // Text("이곳에 정보 추가"),
                Text("시작점 : " + data.startAddress.toString()),
                Text("끝 지점 : " + data.endAddress.toString()),
                Text("거리 : 약 " + data.distance.toString()),
                Text("거리 값 : " + data.distanceValue.toString()),
                Text("이동 시간 : " + data.duration.toString()),
                Text("이동 시간 값 : 약 " + data.durationValue.toString()),
              ],
            ),
          ),
        );
      },
    );
    _polylines.add(polyline);
  }

  void currentLocationEnable() async {
    if (isLocationPermissionEnabled == false) {
      print("접근 권한이 없습니다.");
    }

    if (isLocationEnabled && isLocationPermissionEnabled) {
      checkLocationPermission();
      // 첫 실행
      location.getLocation().then(
        (location) {
          currentLocation = location;
        },
      );
      GoogleMapController googleMapController = await _controller.future;
      locationSubscription = location.onLocationChanged.listen(
        (newLoc) {
          currentLocation = newLoc;
        },
      );
    } else if (!isLocationPermissionEnabled) {
      // 권한 없음
      print("권한이 없습니다.");
    } else if (!isLocationEnabled) {
      // location 스탑
      locationSubscription!.cancel();
    }
  }

  Future<void> checkLocationPermission() async {
    // 지도의 권한이 있는지 확인
    print("권한을 체크합니다.");
    location.hasPermission().then((permissionStatus) => {
          if (permissionStatus == PermissionStatus.granted)
            isLocationPermissionEnabled = true
          else if (permissionStatus == PermissionStatus.grantedLimited)
            isLocationPermissionEnabled = true
          else if (permissionStatus == PermissionStatus.denied)
            isLocationPermissionEnabled = false
          else if (permissionStatus == PermissionStatus.deniedForever)
            isLocationPermissionEnabled = false
        });

    // 권한 요청
    if (isLocationPermissionEnabled == false) {
      buildAlertDialog("위치 접근 권한이 없습니다. 접근 권한을 풀어 주세요.");
      location.requestPermission().then((permissionStatus) => {
            if (permissionStatus == PermissionStatus.granted)
              isLocationPermissionEnabled = true
            else if (permissionStatus == PermissionStatus.grantedLimited)
              isLocationPermissionEnabled = true
            else if (permissionStatus == PermissionStatus.denied)
              isLocationPermissionEnabled = false
            else if (permissionStatus == PermissionStatus.deniedForever)
              isLocationPermissionEnabled = false
          });
    }
  }

  Widget _buildSearchBox() {
    TextEditingController _editingController = TextEditingController();
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: TextField(
          controller: _editingController,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.search),
            hintText: "Search Anything..",
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: (value) async {},
          onSubmitted: (value) async {
            _searchPlaces = await _googleMapService.getSearchTextApi(
                _editingController.text, languageCode, 10);
            if (_searchPlaces.length > 0)
              await _showSearchPlaces();
            else
              buildAlertDialog("정보를 찾을 수 없습니다.");

            int startIndex = _markers.length - 2;
            int lastIndex = _markers.length - 1;
            await makeDistance(startIndex , lastIndex);
            setState(() {});
          },
        ),
      ),
    );
  }

  Future<void> _showSearchPlaces() {
    Size media = MediaQuery.of(context).size;
    double size = 2 / 3;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: media.height * (size),
            width: media.width * (size),
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Places place = _searchPlaces[index];
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                  getImageUrl(place.photos[0].name))),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "주소 : ${place.formattedAddress}",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  "평점 : ${place.rating}",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: TextButton(
                              // 선택 클릭시
                              onPressed: () {
                                LatLng latLng = LatLng(place.location.latitude,
                                    place.location.longitude);
                                addMarker(latLng, place);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "선택",
                                style: TextStyle(fontSize: 13.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                );
              },
              itemCount: _searchPlaces.length,
            ),
          ),
        );
      },
    );
  }

  String getImageUrl(String name) {
    return '${Utils.googleMapPhotoApiUrl}${name}${Utils.googleMapPhotoApiMediaParm}&key=${Utils.googleApiKey}';
  }
}

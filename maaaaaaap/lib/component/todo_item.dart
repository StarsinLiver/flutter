import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:google_map/component/dto/google_map_search_text_dtos.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/cluster_manager.dart';
import 'package:flutter/material.dart';

class TodoMarker extends Marker {
  List<Todo> todoItem;
  Places place;
  int order;

  TodoMarker({
    required this.order,
    required this.place,
    required this.todoItem,
    required super.markerId,
    super.alpha = 1.0,
    super.anchor = const Offset(0.5, 1.0),
    super.consumeTapEvents = false,
    super.draggable = false,
    super.flat = false,
    super.icon = BitmapDescriptor.defaultMarker,
    super.infoWindow = InfoWindow.noText,
    super.position = const LatLng(0.0, 0.0),
    super.rotation = 0.0,
    super.visible = true,
    super.zIndex = 0.0,
    super.clusterManagerId,
    super.onTap,
    super.onDrag,
    super.onDragStart,
    super.onDragEnd,
  });

  TodoMarker copyWith({
    double? alphaParam,
    Offset? anchorParam,
    bool? consumeTapEventsParam,
    bool? draggableParam,
    bool? flatParam,
    BitmapDescriptor? iconParam,
    InfoWindow? infoWindowParam,
    LatLng? positionParam,
    double? rotationParam,
    bool? visibleParam,
    double? zIndexParam,
    VoidCallback? onTapParam,
    ValueChanged<LatLng>? onDragStartParam,
    ValueChanged<LatLng>? onDragParam,
    ValueChanged<LatLng>? onDragEndParam,
    ClusterManagerId? clusterManagerIdParam,
  }) {
    return TodoMarker(
      order : order,
      place : place,
      markerId: markerId,
      alpha: alphaParam ?? alpha,
      anchor: anchorParam ?? anchor,
      consumeTapEvents: consumeTapEventsParam ?? consumeTapEvents,
      draggable: draggableParam ?? draggable,
      flat: flatParam ?? flat,
      icon: iconParam ?? icon,
      infoWindow: infoWindowParam ?? infoWindow,
      position: positionParam ?? position,
      rotation: rotationParam ?? rotation,
      visible: visibleParam ?? visible,
      zIndex: zIndexParam ?? zIndex,
      onTap: onTapParam ?? onTap,
      onDragStart: onDragStartParam ?? onDragStart,
      onDrag: onDragParam ?? onDrag,
      onDragEnd: onDragEndParam ?? onDragEnd,
      clusterManagerId: clusterManagerIdParam ?? clusterManagerId,
      todoItem: todoItem,
    );
  }

  // Todo 아이템 추가
  Future<void> addTodoItem(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Todolist"),
          content: Column(
            children: [
              // 제목
              TextField(
                controller: titleController,
                onChanged: (String value) {
                  titleController.text = value;
                },
                obscureText: false,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: '제목을 적어주세요',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.greenAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              // 컨텐츠
              TextField(
                controller: contentController,
                onChanged: (String value) {
                  contentController.text = value;
                },
                obscureText: false,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  hintText: '컨텐츠를 적어주세요',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.greenAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Todo todo = Todo(
                      title: titleController.text,
                      content: contentController.text);
                  // Todo  리스트 추가
                  this.todoItem.add(todo);
                  // 창 닫음
                  Navigator.of(context).pop();
                },
                child: Text("Add"))
          ],
        );
      },
    );
  }

}

class Todo {
  String title;
  String content;
  String icon; // IconData 를 변환

  Todo({this.title = "", this.content = "", this.icon = ""});


  Future<void> updateTodoItem(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    titleController.text = this.title;
    contentController.text = this.content;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Todolist"),
          content: Column(
            children: [
              // 제목
              TextField(
                controller: titleController,
                onChanged: (String value) {
                  titleController.text = value;
                },
                obscureText: false,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: '제목을 적어주세요',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.greenAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              // 컨텐츠
              TextField(
                controller: contentController,
                onChanged: (String value) {
                  contentController.text = value;
                },
                obscureText: false,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  hintText: '컨텐츠를 적어주세요',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.greenAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  // Todo  리스트 수정
                  this.title = titleController.text;
                  this.content = contentController.text;
                  // 창 닫음
                  Navigator.of(context).pop();
                },
                child: Text("Update"))
          ],
        );
      },
    );
  }

  @override
  String toString() {
    return 'Todo{title: $title, content: $content, icon: $icon}';
  }
}

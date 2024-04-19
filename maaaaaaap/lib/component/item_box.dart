import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

enum Item {
  disable, marker , polyline ,straightPolyline, location , clear
}

class ItemBoxDto{
  IconData icon;
  String name;

  ItemBoxDto(this.icon , this.name);
}
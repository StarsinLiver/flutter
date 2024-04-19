import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapCamera extends CameraPosition {

  GoogleMapCamera(
      {super.zoom = 14,
        super.tilt = 0.0, super.bearing = 0.0, required super.target,
      });

}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';

class GoogleMapWidget extends GetView<MapController> {
  GoogleMapWidget({Key? key}) : super(key: key);
  final MapController _controller = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    // Get.find<AppPermissionController>().requestPermission();

    return Obx(
      () => GoogleMap(
        onLongPress: (pos) {
          //controller.addDestinationMarkers(pos);
        },
        myLocationEnabled: true,
        mapToolbarEnabled: false,
        compassEnabled: false,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _controller.initialPosition,
        markers: {
          ..._controller.destinationMarkers,
          if (_controller.originMarker.value != null)
            _controller.originMarker.value!,
          if (_controller.showPlaceIcons.value) ..._controller.placeMarkers
        },
        polylines: {
          if (_controller.polylinesPoints.isNotEmpty)
            Polyline(
                polylineId: const PolylineId('polylines'),
                color: kPrimaryColor.withOpacity(0.7),
                width: 5,
                points: _controller.polylinesPoints)
        },
        onCameraIdle: () {
          _controller.onMapCameraIdle();
        },
        onCameraMove: (cameraPosition) {
          _controller.onMapCameraMove(cameraPosition);
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.onMapCreate(controller);
        },
      ),
    );
  }
}

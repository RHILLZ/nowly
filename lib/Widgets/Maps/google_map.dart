import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';


class GoogleMapWidget extends GetView<MapController> {
  const GoogleMapWidget({Key? key}) : super(key: key);

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
        myLocationButtonEnabled  : false,
        zoomControlsEnabled: false,
        //myLocationButtonEnabled: true,
        initialCameraPosition: controller.initialPosition,
        markers: {
          ...controller.destinationMarkers,
          if (controller.originMarker.value != null)
            controller.originMarker.value!,
          if(controller.showPlaceIcons.value)
          ...controller.placeMarkers  
        },
        polylines: {
          if (controller.polylinesPoints.isNotEmpty)
            Polyline(
                polylineId: const PolylineId('polylines'),
                color: kPrimaryColor.withOpacity(0.7),
                width: 5,
                points: controller.polylinesPoints)
        },
        
        onCameraIdle: (){
          controller.onMapCameraIdle();
        },
        onCameraMove: (cameraPosition){
          controller.onMapCameraMove(cameraPosition);
        },
        onMapCreated: (GoogleMapController controller) {
          this.controller.onMapCreate(controller);
        },
      ),
    );
  }
}

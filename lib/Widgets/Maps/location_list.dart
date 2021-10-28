import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Controllers/controller_exporter.dart';

class LocationList extends StatelessWidget {
  LocationList({Key? key, required MapController controller})
      : _controller = controller,
        super(key: key);

  final MapController _controller;
  final SessionController _sessionController = Get.find<SessionController>();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (ctx, i) => const Divider(),
      itemCount: _controller.nearbyParks.length,
      itemBuilder: (ctx, index) => Obx(() => ListTile(
            title: Text(_controller.nearbyParks[index].parkName),
            selectedTileColor: ListTileTheme.of(context).selectedTileColor,
            selected: _controller.selectedPark.parkName ==
                _controller.nearbyParks[index].parkName,
            onTap: () {
              _controller.selectedPark = _controller.nearbyParks[index];
              _controller.viewParkLocation();
              _sessionController.sessionLocationCoords =
                  _controller.nearbyParks[index].parkLocation;
              _sessionController.sessionLocationName =
                  _controller.nearbyParks[index].parkName;
            },
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Screens/Sessions/current_session_details_screen.dart';
import 'package:nowly/Screens/Sessions/session_confirmation_screen_2.dart';

import '../controller_exporter.dart';

enum NavigationStatus { notAvailable, thisIs, thisIsnt }

class MapNavigatorController extends GetxController {
  final availableMaps = <AvailableMap>[].obs;
  final curruntSessionController = Rxn<TrainerInPersonSessionController>();

  void openAvialableMaps(
      {required TrainerInPersonSessionController sessionController}) async {
    endNavigations();
    final availableMaps = await MapLauncher.installedMaps;
    this.availableMaps.value = availableMaps;
    final trainerLocation =
        sessionController.trainerSession.locationDetailsModel;
    final coordinates =
        Coords(trainerLocation.latitude, trainerLocation.longitude);

    if (availableMaps.isEmpty) {
      Get.rawSnackbar(
          message: 'Maps not available', icon: const Icon(Icons.map_outlined));
      return;
    }

    if (availableMaps.length == 1) {
      curruntSessionController.value = sessionController;
      openMaps(availableMaps.first.mapType, coordinates);
      update([
        'navigationIndicatorId'
      ]); //to dismiss UserNavigatorIndicatorDetailedBanner Widget
      return;
    }

    Get.bottomSheet(
      Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Continue with',
                  style: k16BoldTS,
                ),
              ),
              ListView.builder(
                itemCount: availableMaps.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    horizontalTitleGap: 0,
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SvgPicture.asset(
                          availableMaps[index].icon,
                          width: 30,
                        )),
                    title: Text(availableMaps[index].mapName),
                    onTap: () {
                      curruntSessionController.value = sessionController;
                      openMaps(availableMaps[index].mapType, coordinates);
                      update([
                        'navigationIndicatorId'
                      ]); //to dismiss UserNavigatorIndicatorDetailedBanner Widget
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ],
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      backgroundColor: Theme.of(Get.overlayContext!).canvasColor,
      isScrollControlled: true,
    );
  }

  void navigateToCurrentSessionDetailsScreen() {
    if (curruntSessionController.value == null) return;
    Get.toNamed(CurrentSessionDetailsScreen.routeName,
        arguments: curruntSessionController.value!);
  }

  NavigationStatus hasThisOnGoingNavigation(
      TrainerInPersonSessionController controller) {
    //Check currently has a map  navigation and check if it belongs to this session
    if (curruntSessionController.value == null) {
      return NavigationStatus.notAvailable;
    }
    if (curruntSessionController.value!.trainerSession.trainer.id ==
        controller.trainerSession.trainer.id) {
      return NavigationStatus.thisIs;
    } else {
      return NavigationStatus.thisIsnt;
    }
  }

  void openMaps(MapType type, Coords destination) async {
    MapController _mapController = Get.find();
    LocationData _myLocation = _mapController.getOriginLocation!;
    await MapLauncher.showDirections(
        mapType: type,
        origin: Coords(_myLocation.latitude!, _myLocation.longitude!),
        destination: destination);
    navigateToCurrentSessionDetailsScreen();
  }

  void openBanner(TrainerInPersonSessionController sessionController) {
    final trainer = sessionController.trainerSession.trainer;
    ScaffoldMessenger.of(Get.overlayContext!).showMaterialBanner(
      MaterialBanner(
        contentTextStyle: const TextStyle(color: Colors.white),
        //padding: const EdgeInsets.only(top: kScreenPadding2, left: kScreenPadding, right: kScreenPadding, bottom: 5),
        content: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You are on your way to ${trainer.firstName}\'s session',
                style: k16RegularTS,
              ),
              // Text(
              //   '${trainer.address}',
              //   style: k10RegularTS,
              // )
            ],
          ),
        ),
        leading: const Icon(Icons.navigation_rounded, color: Colors.white),
        backgroundColor: Colors.green.withOpacity(0.95),
        actions: <Widget>[
          TextButton(
            child: const Text('Review', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Get.to(SessionConfirmationScreen2(
                  trainerInPersonSessionController: sessionController));
            },
          ),
          TextButton(
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
            onPressed: () {
              endNavigations();
            },
          ),
        ],
      ),
    );
  }

  void endNavigations() {
    update([
      'navigationIndicatorId'
    ]); //to dismiss/show UserNavigatorIndicatorDetailedBanner Widget
    if (curruntSessionController.value == null) return;
    curruntSessionController.value = null;
    ScaffoldMessenger.of(Get.overlayContext!).removeCurrentMaterialBanner();
  }
}

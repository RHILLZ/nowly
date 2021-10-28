import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Widgets/widget_exporter.dart';


class PlaceSearchScreen extends StatelessWidget {
  PlaceSearchScreen({Key? key}) : super(key: key);
  double get headerHeight => 55.0;
  final _focusNode = FocusNode();
  final MapController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    _focusNode.requestFocus();
    return SafeArea(
      child: Padding(
        padding: UIParameters.screenPadding,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kCardCornerRadius),
                      color: Theme.of(context).scaffoldBackgroundColor),
                  child: Column(
                    children: [
                      Row(
                        children: const [BackButton()],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 10, right: 5),
                            child: TextField(
                              onChanged: (v) {
                                _controller.searchQuery.value = v;
                              },
                              focusNode: _focusNode,
                              decoration: const InputDecoration(
                                label: Text('Search place'),
                                prefixIcon: Icon(Icons.search),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          )),
                          const Material(
                              type: MaterialType.transparency,
                              child: SessionFilterButton(
                                enableShadow: false,
                              )),
                          const SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ],
                  )),
              Expanded(
                child: Obx(
                  () => Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kCardCornerRadius),
                        color: Theme.of(context).scaffoldBackgroundColor),
                    child: _controller.isLoadingSearchedPlaces.value ? const Center(
                            child: SpinKitFadingFour(
                              color: kPrimaryColor,
                              size: 50.0,
                            ),
                          ) : (_controller.placeSearchResult.isEmpty)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               SvgPicture.asset(
                                  'assets/images/map/empty_locations.svg'),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Empty result',
                                style: k16LightdGrayTS,
                                textAlign: TextAlign.center,
                              )
                            ],
                          )
                        : ListView.separated(
                            itemCount: _controller.placeSearchResult.length,
                            separatorBuilder:(BuildContext context, int index) {
                              return const Divider(
                                height: 0,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              PlacePrediction place =
                                  _controller.placeSearchResult[index];
                              return ListTile(
                                onTap: (){
                                  _controller.getPlaceDetails(place);
                                  Get.back();
                                },
                                title: Text(place.description),
                              );
                            },
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

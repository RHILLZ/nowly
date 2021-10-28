import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TrainerSessionCard extends StatelessWidget {
  const TrainerSessionCard({Key? key}) : super(key: key);

  // TrainerSessionCard({
  //   Key? key,
  //   required TrainerSessionController controller,
  // })  : _controller = controller,
  //       super(key: key) {
  //   // _session = _controller.trainerSession;
  //   Future.delayed(Duration.zero, () {});
  // }

  // late TrainerSessionModel _session;
  // final TrainerSessionController _controller;

  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 0.75,
      // child: Stack(
      //   clipBehavior: Clip.none,
      //   children: [
      //     InkWell(
      //       onTap: () {
      //         _controller.openSessionDetailsBottomSheet();
      //         _controller.addOriginMarkerAndDrawPolyLinePath();
      //       },
      //       child: Ink(
      //         padding: const EdgeInsets.all(8),
      //         decoration: BoxDecoration(
      //             boxShadow:UIParameters.getShadow(spreadRadius: 5, blurRadius: 5),
      //             color: _session.isOnline
      //                 ? Theme.of(context).scaffoldBackgroundColor
      //                 : geDisabledColor(context),
      //             borderRadius: BorderRadius.circular(2)),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             SizedBox(
      //               height: 120,
      //               child: CachedNetworkImage(
      //                 imageUrl: _session.thumbNailImage,
      //                 placeholder: (context, url) =>
      //                     const ImageBoxLoadingPlaceHolder(),
      //                 errorWidget: (context, url, error) =>
      //                     const Icon(Icons.error),
      //                 fit: BoxFit.cover,
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.symmetric(vertical: 4),
      //               child: Text(
      //                 _session.trainer.name,
      //                 maxLines: 1,
      //                 overflow: TextOverflow.fade,
      //               ),
      //             ),
      //             Text(
      //               _session.trainer.address ?? '',
      //               maxLines: 2,
      //               overflow: TextOverflow.ellipsis,
      //               style: kRegularTS,
      //             ),
      //             const Spacer(),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 if (_session.trainer.rating != null)
      //                   StarRatingBar(
      //                     rating: _session.trainer.rating!,
      //                     onRate: (v) {},
      //                   ),
      //                 const Text('0.5 mi')
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //     Positioned(
      //         top: -5,
      //         right: -5,
      //         width: 25,
      //         height: 25,
      //         child: Visibility(
      //           visible: _session.isOnline,
      //           child: Container(
      //             decoration: BoxDecoration(
      //                 color: kActiveColor,
      //                 shape: BoxShape.circle,
      //                 border: Border.all(
      //                     color: Theme.of(context).scaffoldBackgroundColor,
      //                     width: 4)),
      //           ),
      //         )),
      //   ],
      // ),
    );
  }
}

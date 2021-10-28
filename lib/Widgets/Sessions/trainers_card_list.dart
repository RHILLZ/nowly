



// class TrainersCardsList extends StatelessWidget {
//   const TrainersCardsList({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final _controller = Get.find<SessionListController>();
//     return SizedBox(
//       height: 212 + kScreenPadding,
//       child: Obx(
//         () => ListView.separated(
//           clipBehavior: Clip.none,
//           scrollDirection: Axis.horizontal,
//           itemCount: _controller.trainersSessionControllers.length,
//           padding: const EdgeInsets.only(bottom: kScreenPadding, left: kScreenPadding2, right: kScreenPadding2),
//           separatorBuilder: (BuildContext context, int index) {
//             return const SizedBox(
//               width: kContentGap,
//             );
//           },
//           itemBuilder: (BuildContext context, int index) {
//             // final TrainerSessionController _sessionController = _controller.trainersSessionControllers[index]; 
//             // return TrainerSessionCard(controller: _sessionController);
//           },
//         ),
//       ),
//     );
//   }
// }



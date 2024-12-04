// import 'package:flutter/material.dart';
// import '../../dashboard/views/installedapps_view.dart';
//
//
// class InstalledAppsView extends StatelessWidget {
//   InstalledAppsView({
//     Key? key,
//
//     required this.noDataTextStyle,
//   }) : super(key: key);
//
//
//   final TextStyle noDataTextStyle;
//
//   final List<String> urls = [
//     "https://www.uber.com",
//     "https://www.washingtonpost.com",
//     "https://www.github.com",
//     "https://www.flutter.dev",
//     "https://weather.com",
//     "https://playtictactoe.org",
//     "https://www.holidayheroes.de/",
//     "https://freepacman.org"
//   ];
//
//   final List<String> names = [
//     "Uber",
//     "Washington Post",
//     "Github",
//     "Flutter",
//     "Weather",
//     "Tic Tac Toe",
//     "holiday heroes",
//     "Pacman"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 4,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 10,
//           childAspectRatio: 1,
//         ),
//         itemCount: urls.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.of(context).push(
//                 PageRouteBuilder(
//                   opaque: false,
//                   barrierColor: Colors.black54,
//                   pageBuilder: (context, _, __) => Stack(
//                     children: [
//                       GestureDetector(
//                         onTap: () => Navigator.of(context).pop(),
//                         child: Container(color: Colors.transparent),
//                       ),
//                       CustomWebViewBottomSheet(url: urls[index], name: names[index]),
//                     ],
//                   ),
//                   transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                     return SlideTransition(
//                       position: Tween<Offset>(
//                         begin: const Offset(0, 1),
//                         end: Offset.zero,
//                       ).animate(CurvedAnimation(
//                         parent: animation,
//                         curve: Curves.easeOut,
//                       )),
//                       child: child,
//                     );
//                   },
//                 ),
//               );
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.blueAccent,
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 4,
//                     offset: Offset(2, 2),
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Text(
//                   names[index],
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
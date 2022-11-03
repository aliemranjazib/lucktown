// import 'package:flutter/material.dart';
// import 'package:responsive_framework/responsive_framework.dart';

// class FlutterFavorites extends StatelessWidget {
//   const FlutterFavorites({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       color: const Color(0xFFF5F5F7),
//       child: Center(
//         child: Container(
//           constraints: const BoxConstraints(maxWidth: 1110),
//           padding: const EdgeInsets.fromLTRB(0, 44, 0, 32),
//           margin: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Flutter Favorites',
//               ),
//               RichText(
//                 text: TextSpan(
//                   // style: const TextStyle(
//                   //     color: textPrimaryColor, fontSize: 18, height: 1.6),
//                   children: [
//                     const TextSpan(
//                       text: 'Packages that demonstrate the ',
//                     ),
//                     // TextSpan(
//                     //     recognizer: TapGestureRecognizer()
//                     //       ..onTap = () {
//                     //         openUrl(
//                     //             'https://flutter.dev/docs/development/packages-and-plugins/favorites');
//                     //       },
//                     //     text: 'highest levels of quality',
//                     //     style: const TextStyle(color: linkColor)),
//                     const TextSpan(
//                         text: ', selected by the Flutter Ecosystem Committee'),
//                   ],
//                 ),
//               ),
//               const Padding(padding: EdgeInsets.only(bottom: 10)),
//               if (ResponsiveWrapper.of(context).isLargerThan(MOBILE))
//                 ResponsiveGridView.builder(
//                   gridDelegate: const ResponsiveGridDelegate(
//                       crossAxisExtent: 260,
//                       mainAxisSpacing: 16,
//                       crossAxisSpacing: 16,
//                       childAspectRatio: 1.37),
//                   maxRowCount: 1,
//                   itemCount: 4,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   padding: const EdgeInsets.fromLTRB(4, 8, 0, 8),
//                   alignment: Alignment.center,
//                   itemBuilder: (context, index) {
//                     return PackageCard(package: favoritePackages[index]);
//                   },
//                 ),
//               if (ResponsiveWrapper.of(context).isSmallerThan('MOBILE_LARGE'))
//                 ...favoritePackages.map((e) => Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       child: PackageCard(package: e),
//                     )),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 16),
//                   child: MouseRegion(
//                     cursor: SystemMouseCursors.click,
//                     child: GestureDetector(
//                       onTap: () => openUrl('https://pub.dev/flutter/favorites'),
//                       child: const Text('VIEW ALL',
//                           style: TextStyle(
//                               color: linkColor,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

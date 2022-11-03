// import 'package:flutter/material.dart';
// import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
// import 'package:flutter_application_lucky_town/utils/components/gradient_text_style.dart';
// import 'package:flutter_application_lucky_town/utils/components/select_category.dart';
// import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
// import 'package:flutter_application_lucky_town/widgets/select_country.dart';
// import 'package:responsive_framework/responsive_framework.dart';

// class HomePage extends StatelessWidget {
//   List<SelectCountryModel> select = [
//     SelectCountryModel(text: "LODON", image: london),
//     SelectCountryModel(text: "CHINA", image: china),
//     SelectCountryModel(text: "THAILAND", image: thailand),
//     SelectCountryModel(text: "MALAYSIA", image: malaysia),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           // width: double.infinity,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/images/bg.png"),
//               fit: BoxFit.cover,
//               alignment: Alignment.center,
//             ),
//           ),
//           child: Column(
//             children: [
//               ResponsiveVisibility(
//                   hiddenWhen: const [Condition.equals(name: TABLET)],
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.asset(star),
//                   )),
//               // widget(),
//               ResponsiveVisibility(
//                 hiddenWhen: const [Condition.equals(name: TABLET)],
//                 child: Image.asset(curve),
//               ),
//               logoWork(),
//               silverGradient("Pick Your Country", 24),
//               Image.asset(line),
//               ResponsiveRowColumnItem(
//                 rowFlex: ResponsiveValue<int?>(context,
//                     defaultValue: null,
//                     valueWhen: [
//                       const Condition.smallerThan(name: DESKTOP, value: 1)
//                     ]).value,
//                 child: Column(
//                   children: [
//                     ResponsiveWrapper.of(context).isLargerThan(MOBILE)
//                         ? ResponsiveGridView.builder(
//                             gridDelegate: const ResponsiveGridDelegate(
//                                 crossAxisExtent: 260,
//                                 mainAxisSpacing: 16,
//                                 crossAxisSpacing: 16,
//                                 childAspectRatio: 1.37),
//                             // maxRowCount: 2,
//                             itemCount: select.length,
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             padding: const EdgeInsets.fromLTRB(4, 8, 0, 16),
//                             alignment: Alignment.center,
//                             itemBuilder: (context, index) {
//                               return selectCountry(
//                                 select[index].text!,
//                                 () {},
//                                 select[index].image!,
//                               );
//                             },
//                           )
//                         : ResponsiveWrapper.of(context)
//                                 .isSmallerThan('MOBILE_LARGE')
//                             ? ResponsiveGridView.builder(
//                                 gridDelegate: const ResponsiveGridDelegate(
//                                     crossAxisExtent: 144,
//                                     mainAxisSpacing: 6,
//                                     crossAxisSpacing: 6,
//                                     childAspectRatio: 1),
//                                 // maxRowCount: 2,
//                                 itemCount: select.length,
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 padding: const EdgeInsets.fromLTRB(4, 8, 0, 16),
//                                 alignment: Alignment.center,
//                                 itemBuilder: (context, index) {
//                                   return selectCountry(
//                                     select[index].text!,
//                                     () {},
//                                     select[index].image!,
//                                   );
//                                 },
//                               )
//                             : silverGradient("text", 90)
//                   ],
//                 ),
//               ),

//               // SelectCountry(),
//               // Container(
//               //   width: double.infinity,
//               //   child: Row(
//               //     children: [
//               //       selectCountry("LONDIN", () {}),
//               //       selectCountry("CHINA", () {}),
//               //       selectCountry("THAILAND", () {}),
//               //       selectCountry("MALAYSIA", () {}),
//               //     ],
//               //   ),
//               // ),
//               Image.asset(footerbrand),
//             ],
//           ) /* add child content here */,
//         ),
//       ),
//     );
//   }

//   Column logoWork() {
//     return Column(
//       children: [
//         Image.asset(logo),
//         silverGradient('Welcome to the', 40),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             silverGradient('Lucky', 40),
//             whitegradient(),
//           ],
//         ),
//       ],
//     );
//   }

//   GradientText whitegradient() {
//     return GradientText(
//       'TownApp',
//       style: const TextStyle(
//         fontSize: 40,
//         fontFamily: "gotham",
//       ),
//       gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           // tileMode: TileMode.clamp,
//           colors: [
//             Color(0xFFFFFF).withOpacity(1),
//             Color(0xCECECE).withOpacity(1),
//             Color(0xFFFFD1).withOpacity(1),
//             Color(0xF7E1C0).withOpacity(1),
//           ]),
//     );
//   }
// }

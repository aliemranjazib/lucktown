import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web/home/select.dart';
import 'package:responsive_framework/responsive_framework.dart';

Container sidebar(BuildContext context, String sIndex) {
  return Container(
    height: 400,
    child: GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            ResponsiveWrapper.of(context).isLargerThan(MOBILE) ? 2 : 1,
      ),
      children: [
        selection(popular, 'popular', () {
          sIndex = 'popular';
          print(sIndex);
        }),
        selection(favourite, 'favourite', () {
          sIndex = 'favourite';
          print(sIndex);
        }),
        selection(LiveCasino, 'Live Casino', () {
          sIndex = 'casino';
          // filterProducts("LIVECASINO");
          print(sIndex);
        }),
        selection(egame, 'Egame', () {
          sIndex = 'egame';
          // filterProducts("EGAMES");
        }),
        selection(sport, 'Sport', () {
          sIndex = 'sport';
          // filterProducts("SPORT");
        }),
        selection(lottery, 'Lottery', () {
          sIndex = 'lottery';
        }),
      ],
    ),
  );
}

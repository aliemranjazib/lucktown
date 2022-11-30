import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web/home/select.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SideBar extends StatefulWidget {
  String sIndex;
  SideBar({super.key, required this.sIndex});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              ResponsiveWrapper.of(context).isLargerThan(MOBILE) ? 2 : 1,
        ),
        children: [
          // selection(popular, 'popular', () {
          //   sIndex = 'popular';
          //   print(sIndex);
          // }),
          selection(favourite, 'All Games', () {
            setState(() {
              widget.sIndex = 'all';
            });
            print(widget.sIndex);
          }),

          selection(egame, 'Egame', () {
            setState(() {
              widget.sIndex = 'egame';
            });
            // filterProducts("EGAMES");
          }),
          selection(sport, 'Sport', () {
            setState(() {
              widget.sIndex = 'sport';
            });
            // filterProducts("SPORT");
          }),
          selection(LiveCasino, 'Live Casino', () {
            setState(() {
              widget.sIndex = 'casino';
            });
            // filterProducts("LIVECASINO");
            print(widget.sIndex);
          }),
          selection(lottery, 'Lottery', () {
            setState(() {
              widget.sIndex = 'lottery';
            });
          }),
        ],
      ),
    );
  }
}

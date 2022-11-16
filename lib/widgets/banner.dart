import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerArea extends StatefulWidget {
  // const BannerArea({super.key});
  List g = [];
  BannerArea(this.g);

  @override
  State<BannerArea> createState() => _BannerAreaState();
}

class _BannerAreaState extends State<BannerArea> {
  // List imageList = [banner, banner, banner];
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        options: CarouselOptions(
            autoPlay: true,
            viewportFraction: .9,
            // height: 200,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            height: MediaQuery.of(context).size.height / 2.6,
            onPageChanged: (i, r) {
              setState(() {
                _current = i;
              });
            }),
        items: widget.g
            .map((e) => Container(
                  child: Image.network(
                    e,
                    // width: double.infinity,
                    // height: 300,
                    // fit: BoxFit.fill,
                  ),
                  // child: Image.network(
                  //   e,
                  //   fit: BoxFit.contain,
                  //   width: 1396,
                  //   height: 273,
                  // ),
                ))
            .toList(),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 2.0),
        child: AnimatedSmoothIndicator(
          activeIndex: _current,
          count: widget.g.length,
          effect: WormEffect(
              activeDotColor: Colors.grey, dotWidth: 8, dotHeight: 8),
        ),
      )
    ]);
  }
}

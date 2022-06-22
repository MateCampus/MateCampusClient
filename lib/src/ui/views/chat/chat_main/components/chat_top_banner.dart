import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ChatTopBanner extends StatelessWidget {
  const ChatTopBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bannerList = [
      Image.asset('assets/images/temp/banner1.jpg', fit: BoxFit.cover),
      Image.asset('assets/images/temp/banner2.jpg', fit: BoxFit.cover),
      Image.asset('assets/images/temp/banner3.jpg', fit: BoxFit.cover),
    ];

    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(10)),
        child: CarouselSlider(
          options: CarouselOptions(
              height: getProportionateScreenHeight(80),
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayCurve: Curves.easeInOut,
              autoPlayInterval: const Duration(seconds: 4)),
          items: _bannerList.map((bannerImg) {
            return Builder(builder: (context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: bannerImg,
              );
            });
          }).toList(),
        ));
  }
}

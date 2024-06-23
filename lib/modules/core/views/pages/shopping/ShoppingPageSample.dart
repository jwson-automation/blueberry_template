import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../utils/AppStrings.dart';

/**
 * ShoppingPageSample.dart
 *
 * Shopping Page Sample
 * - 쇼핑 페이지 샘플
 * - 쇼핑 페이지 샘플 화면
 *
 * @jwson-automation
 */

const String pathPrefix = kIsWeb ? "" : "assets/";

class ShoppingPageSample extends StatelessWidget {
  final List<String> eventImages = [
    // 이벤트 이미지 파일
    '600x400/sample1.jpg',
    '600x400/sample2.jpg',
    '600x400/sample3.jpg',
  ];

  final List<String> itemImages = [
    // 이벤트 이미지 파일
    '300x420/sample1.jpg',
    '300x420/sample2.jpg',
    '300x420/sample3.jpg',
    '300x420/sample4.jpg',
    '300x420/sample5.jpg',
    '300x420/sample1.jpg',
    '300x420/sample2.jpg',
    '300x420/sample3.jpg',
    '300x420/sample4.jpg',
    '300x420/sample5.jpg',
  ];

  final String eventBanner = '700x150/sample1.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.shoppingPageTitle), // AppStrings 참조
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            eventWidget(eventImages),
            const Card(
              child: ListTile(
                title: Text(AppStrings.shoppingPageTitle1),
                subtitle: Text(AppStrings.shoppingPageSubTitle1),
              ),
            ),
            horizontalListView(itemImages),
            const Card(
              child: ListTile(
                title: Text(AppStrings.shoppingPageTitle2),
                subtitle: Text(AppStrings.shoppingPageSubTitle2),
              ),
            ),
            itemsGridView(itemImages),
            companyInfo(),
          ],
        ),
      ),
    );
  }
}

Widget eventWidget(List<String> eventImages) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: eventImages.map((item) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(pathPrefix + item,
                  fit: BoxFit.fill, width: 1000)),
        );
      }).toList(),
    ),
  );
}

Widget itemsGridView(_Images) {
  return Container(
    child: GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _Images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(pathPrefix + _Images[index],
                fit: BoxFit.fill, width: 100),
          ),
        );
      },
    ),
  );
}

Widget horizontalListView(List<String> images) {
  ScrollController _controller = ScrollController();
  return Stack(
    children: [
      SizedBox(
        height: 200,
        child: ScrollConfiguration(
          behavior: MyCustomScrollBehavior(),
          child: ListView.builder(
            controller: _controller,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      pathPrefix + images[index],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      )
    ],
  );
}

Widget companyInfo() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              AppStrings.companyInfoTitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(AppStrings.companyInfoPhone)
          ],
        ),
      ),
      Column(
        children: [
          Text(AppStrings.companyInfoPrivacy),
          Text(AppStrings.companyInfoCenter),
        ],
      ),
      Column(
        children: [
          Text(AppStrings.companyInfoTerms),
          Text(AppStrings.companyInfoAbout),
        ],
      )
    ],
  );
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

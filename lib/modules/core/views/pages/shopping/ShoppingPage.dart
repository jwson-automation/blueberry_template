import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../dto/EventDto.dart';
import '../../../dto/ItemDto.dart';
import '../../../providers/BannerImageProvider.dart';
import '../../../providers/EventDataProvider.dart';
import '../../../providers/item/ItemDataProvider.dart';
import '../../../utils/AppStrings.dart';
import '../../../utils/ResponsiveLayoutBuilder.dart';
import 'EventDetailPage.dart';
import 'ItemDetailPage.dart';

/**
 * ShoppingPage.dart
 *
 * Shopping Page
 * - 쇼핑 페이지
 * - 쇼핑 화면
 *
 * @jwson-automation
 */

const String pathPrefix = kIsWeb ? "" : "assets/";

class ShoppingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerUrl = ref.watch(bannerImageStreamProvider);
    final eventProvider = ref.watch(eventDataProvider);
    final itemProvider = ref.watch(itemDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.shoppingPageTitle), // AppStrings 참조
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            bannerWidget(bannerUrl),
            eventWidget(eventProvider, context),
            const Card(
              child: ListTile(
                title: Text(AppStrings.shoppingPageTitle1),
                subtitle: Text(AppStrings.shoppingPageSubTitle1),
              ),
            ),
            itemsListView(itemProvider, context),
            const Card(
              child: ListTile(
                title: Text(AppStrings.shoppingPageTitle2),
                subtitle: Text(AppStrings.shoppingPageSubTitle2),
              ),
            ),
            itemsGridView(itemProvider),
            companyInfo(),
          ],
        ),
      ),
    );
  }
}

Widget bannerWidget(AsyncValue<String> bannerProvider) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: bannerProvider.when(
          data: (url) => Image.network(
                url,
                fit: BoxFit.fill,
                width: 1000,
              ),
          error: (e, _) => Container(),
          loading: () => Container(
                  decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(20),
              ))),
    ),
  );
}

Widget eventWidget(
    AsyncValue<List<EventDTO>> eventProvider, BuildContext context) {
  return eventProvider.when(
    data: (events) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          items: events.map((event) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EventDetailPage(event: event);
                }));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(event.imageUrl,
                          fit: BoxFit.fill, width: 1000),
                      Align(
                        alignment: Alignment.bottomCenter, // 텍스트를 하단 중앙에 배치
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          // 텍스트 주변에 여백을 추가
                          color: Colors.black.withOpacity(0.5),
                          // 반투명 배경을 추가하여 텍스트를 돋보이게 함
                          child: Text(
                            event.title, // 이벤트 이름을 표시
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ), // 사용하는 이미지 URL
                ),
              ),
            );
          }).toList(),
        ),
      );
    },
    loading: () => ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: 1000,
            height: 200,
          ),
        )),
    error: (error, stack) => Center(child: Text('Error loading events')),
  );
}

Widget itemsGridView(AsyncValue<List<ItemDTO>> itemProvider) {
  return itemProvider.when(
    data: (items) {
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductItemGridTile(item: items[index]);
        },
      );
    },
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (e, _) => const Center(child: Text('Error loading items')),
  );
}

Widget itemsListView(
    AsyncValue<List<ItemDTO>> itemProvider, BuildContext context) {
  ScrollController _controller = ScrollController();
  return itemProvider.when(
    data: (items) {
      return Stack(
        children: [
          SizedBox(
            height: 300,
            child: GestureDetector(
              onTap: () {
                _controller.jumpTo(0);
              },
              child: ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: ListView.builder(
                  controller: _controller,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ResponsiveLayoutBuilder(
                              context, ItemDetailPage(item: items[index]));
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductItemListTile(item: items[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
    },
    loading: () => Center(child: CircularProgressIndicator()),
    error: (e, _) => Center(child: Text('Error loading items')),
  );
}

Widget companyInfo() {
  return const Card(
    child: Row(
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
    ),
  );
}

class ProductItemListTile extends StatelessWidget {
  final ItemDTO item;

  const ProductItemListTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    double discountPercentage =
        ((item.originalPrice - item.discountedPrice) / item.originalPrice) *
            100;
    return SizedBox(
      width: 225,
      child: Card(
        elevation: 4.0,
        clipBehavior: Clip.antiAlias, // 이미지가 카드 밖으로 나가지 않도록 함
        child: Stack(
          children: [
            Image.network(
              item.imageUrl,
              fit: BoxFit.fill, // 이미지를 박스에 꽉 차도록 설정
              width: double.infinity, // 너비를 최대로 설정
              height: double.infinity, // 높이를 최대로 설정
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10, // 오른쪽 위치도 설정
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 10), // 패딩 설정
                color: Colors.black54, // 텍스트 전체에 적용되는 배경색
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${item.originalPrice}원',
                      style: const TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${discountPercentage.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '${item.discountedPrice}원',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItemGridTile extends StatelessWidget {
  final ItemDTO item;

  const ProductItemGridTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    double discountPercentage =
        ((item.originalPrice - item.discountedPrice) / item.originalPrice) *
            100;

    return Container(
      width: 225,
      child: Column(
        children: [
          Expanded(
            child: Card(
              elevation: 4.0,
              clipBehavior: Clip.antiAlias, // 이미지가 카드 밖으로 나가지 않도록 함
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                height: 150, // 이미지 높이 설정
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${discountPercentage.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  '${item.discountedPrice}원',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../dto/ItemDto.dart';
import '../../../dto/ItemReviewDTO.dart';
import '../../../providers/firebase/FirebaseStoreServiceProvider.dart';
import '../../../providers/firebase/fireStorageServiceProvider.dart';
import '../../../providers/item/ItemLikedProvider.dart';
import '../../../providers/item/ItemProductImagesProvider.dart';
import '../../../providers/item/ItemProductdesImagesProvider.dart';
import '../../../providers/item/ItemReviewProvider.dart';
import '../../../providers/user/UserInfoProvider.dart';
import '../../../services/PaymentService.dart';
import '../../../utils/AppColors.dart';
import '../../../utils/Formatter.dart';
import 'UploadReviewDialog.dart';

/**
 * ItemDetailPage.dart
 *
 * Item Detail Page
 * - 상품 상세 페이지
 * - 상품 상세 정보, 리뷰, 문의 등을 표시하는 화면
 *
 * @jwson-automation
 */

class ItemDetailPage extends ConsumerWidget {
  final ItemDTO item;

  const ItemDetailPage({super.key, required ItemDTO this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _firestorageService = ref.read(fireStorageServiceProvider);
    final _firestoreService = ref.read(firebaseStoreServiceProvider);
    final _user = ref.watch(userInfoNotifierProvider);
    final _likedUsers = ref.watch(itemLikedProvider(item.itemId));
    final _productImages = ref.watch(productImagesProvider(item.itemId));
    final _reviews = ref.watch(reviewInfoProvider(item.itemId));
    final _productdesImages = ref.watch(productdesImagesProvider(item.itemId));
    var scrollController = ScrollController();

    double discountPercentage =
        ((item.originalPrice - item.discountedPrice) / item.originalPrice) *
            100;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: ListView(
          shrinkWrap: true,
          children: [
            _productImages.maybeWhen(
              data: (List<String> images) => SizedBox(
                height: 300,
                child: CarouselSlider(
                  items: images
                      .map((imageUrl) => ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(imageUrl)))
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enableInfiniteScroll: false,
                  ),
                ),
              ),
              orElse: () => Container(
                height: 300,
                color: Colors.grey,
              ),
            ),
            buildAddImageButton(context, item.itemId, _firestorageService,
                _firestoreService),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productTitle,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.category,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                _firestoreService.toggleLike(
                                    item.itemId, _user.userId);
                              },
                              icon: _likedUsers.maybeWhen(orElse: () {
                                return Icon(
                                  Icons.favorite_border,
                                  color: blue,
                                );
                              }, data: (users) {
                                if (users.contains(_user.userId)) {
                                  return Icon(Icons.favorite,
                                      color: Colors.red);
                                } else {
                                  return Icon(Icons.favorite_border);
                                }
                              })),
                          Text(
                            _likedUsers.maybeWhen(
                                data: (users) => users.length.toString(),
                                orElse: () => '0'),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    item.productDescription,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        '${discountPercentage.toInt()}%',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        '${formatWonNumber(item.originalPrice.toInt())}원',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    formatWonNumber(item.discountedPrice.toInt()) + '원',
                    style: TextStyle(
                      fontSize: 24,
                      color: blueWater,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      print('결제하기');
                      PaymentService().startPayment(context, item);
                    },
                    child: Text('결제하기'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            buildProductQnAWidget(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // 아래로 스크롤
                      scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text('상품 상세 정보'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      scrollController.animateTo(
                        500,
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text('상품 리뷰'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      scrollController.animateTo(
                        0,
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text('상품 문의'),
                  ),
                ),
              ],
            ),
            buildAddDesImageButton(context, item.itemId, _firestorageService,
                _firestoreService),
            buildReviewButton(context, item.itemId),
            _productdesImages.maybeWhen(
              data: (List<String> images) => buildItemDesImagesWidget(images),
              orElse: () => Container(
                height: 300,
                color: Colors.grey,
              ),
            ),
            _reviews.maybeWhen(
              data: (List<ItemReviewDTO> reviews) => buildReviewWidget(reviews),
              orElse: () => Container(
                height: 300,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildAddDesImageButton(BuildContext context, String _itemId,
    FirebaseStorageService _firestorageService, FirestoreService _firestoreService) {
  return Row(
    children: [
      Expanded(
        child: ElevatedButton(
          onPressed: () async {
            if (kIsWeb) {
              final ImagePicker _picker = ImagePicker();
              final XFile? image = await _picker.pickImage(
                  source: ImageSource.gallery);
              if (image != null) {
                final imageUrl = await _firestorageService.uploadImageFromWeb(
                    await image.readAsBytes(), ImageType.descriptionImage);
                await _firestoreService.addItemDescriptionImages(_itemId, imageUrl);
              }
            }
            if (!kIsWeb) {
              final ImagePicker _picker = ImagePicker();
              final XFile? image = await _picker.pickImage(
                  source: ImageSource.gallery);
              if (image != null) {
                final imageUrl = await _firestorageService.uploadImageFromApp(
                    File(image.path), ImageType.descriptionImage);
                await _firestoreService.addItemProductImages(_itemId, imageUrl);
              }
            }
          },
          child: Text('이미지 추가'),
        ),
      ),
    ],
  );
}

Widget buildAddImageButton(BuildContext context, String _itemId,
    FirebaseStorageService _firestorageService, FirestoreService _firestoreService) {
  return Row(
    children: [
      Expanded(
        child: ElevatedButton(
          onPressed: () async {
            if (kIsWeb) {
              final ImagePicker _picker = ImagePicker();
              final XFile? image = await _picker.pickImage(
                  source: ImageSource.gallery);
              if (image != null) {
                final imageUrl = await _firestorageService.uploadImageFromWeb(
                    await image.readAsBytes(), ImageType.item);
                await _firestoreService.addItemProductImages(_itemId, imageUrl);
              }
            }
            if (!kIsWeb) {
              final ImagePicker _picker = ImagePicker();
              final XFile? image = await _picker.pickImage(
                  source: ImageSource.gallery);
              if (image != null) {
                final imageUrl = await _firestorageService.uploadImageFromApp(
                    File(image.path), ImageType.item);
                await _firestoreService.addItemProductImages(_itemId, imageUrl);
              }
            }
          },
          child: Text('이미지 추가'),
        ),
      ),
    ],
  );
}

Widget buildReviewButton(BuildContext context, String _itemId) {
  return Row(
    children: [
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => UploadReviewDialog(
                      itemId: _itemId,
                    ));
          },
          child: Text('리뷰 작성'),
        ),
      ),
    ],
  );
}

Widget buildProductQnAWidget() {
  return Column(
    children: [
      Text('상품 문의',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      SizedBox(height: 16),
      ListTile(
        leading: Icon(Icons.account_circle, size: 40),
        title: Text('작성자 이름', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('문의 내용', style: TextStyle(color: Colors.grey[800])),
            SizedBox(height: 5),
            Text(
              '2021-05-01',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildItemDesImagesWidget(List<String> images) {
  return ListView(
    shrinkWrap: true,
    children: images
        .map((imageUrl) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                imageUrl,
                width: 200,
                fit: BoxFit.cover,
              ),
            ))
        .toList(),
  );
}

Widget buildReviewWidget(List<ItemReviewDTO> reviews) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: reviews.length,
    itemBuilder: (BuildContext context, int index) {
      final review = reviews[index];
      return ListTile(
        leading: Icon(Icons.account_circle, size: 40), // 아이콘으로 사용자를 나타냅니다.
        title: Text(review.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(review.content, style: TextStyle(color: Colors.grey[800])),
                SizedBox(height: 5),
                Text(
                  '${review.createdAt.year}-${review.createdAt.month.toString().padLeft(2, '0')}-${review.createdAt.day.toString().padLeft(2, '0')}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            SizedBox(width: 16),
            // 평점을 별로 표시합니다.
            Row(
              children: List.generate(5, (index) {
                if (index < review.rating) {
                  return Icon(Icons.star, color: Colors.amber);
                } else {
                  return Icon(Icons.star, color: Colors.grey);
                }
              }),
            ),
          ],
        ),
      );
    },
  );
}

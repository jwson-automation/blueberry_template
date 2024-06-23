import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dto/ItemReviewDTO.dart';
import '../../../providers/firebase/FirebaseStoreServiceProvider.dart';
import '../../../providers/user/UserInfoProvider.dart';

/**
 * UploadReviewDialog.dart
 *
 * Upload Review Dialog
 * - 리뷰를 작성하는 다이얼로그
 *
 * @jwson-automation
 */

class UploadReviewDialog extends ConsumerStatefulWidget {
  final String itemId;

  UploadReviewDialog({required this.itemId});

  @override
  _UploadReviewDialogState createState() => _UploadReviewDialogState();
}

class _UploadReviewDialogState extends ConsumerState<UploadReviewDialog> {
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 0; // 사용자가 선택한 별점을 저장하는 변수

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _firestoreService = ref.read(firebaseStoreServiceProvider);
    final user = ref.read(userInfoNotifierProvider);
    return AlertDialog(
      title: Text('Write a Review'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Rating:', style: TextStyle(fontWeight: FontWeight.bold)),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) =>
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(
                hintText: 'Enter your review here...',
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Upload'),
          onPressed: () {
            if (_reviewController.text.isNotEmpty) {
              // 리뷰 업로드
              _firestoreService.addItemReview(
                widget.itemId,
                ItemReviewDTO(
                  userId: user.userId,
                  content: _reviewController.text,
                  rating: _rating,
                  name: user.name,
                ),
              );

              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../../model/DogProfileModel.dart';
import '../../widgets/match/SwiperCardWidget.dart';
import 'ProfileScreen.dart';

///  MatchPage - 프로필 스와이프 매칭 화면
///
///  주요 구성 요소:
///  - CardSwiper: 프로필 카드를 스와이프할 수 있는 메인 위젯
///  - FloatingActionButton: 수동으로 좌/우 스와이프를 할 수 있는 버튼


final List<DogProfileModel> dogProfiles = [
  const DogProfileModel(
    name: '멍멍이',
    gender: '수컷',
    breed: '골든 리트리버',
    location: '서울',
    bio: '산책을 좋아하는 활발한 강아지예요!',
    imageUrl: 'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FcY8RCd%2FbtsC31gfzPL%2FbSnADONPu66xPesaWHmW00%2Fimg.jpg',
  ),
  const DogProfileModel(
    name: '뭉치',
    gender: '암컷',
    breed: '푸들',
    location: '부산',
    bio: '애교 많고 사랑스러운 강아지입니다.',
    imageUrl: 'https://image.dongascience.com/Photo/2017/07/14994185580021.jpg',
  ),
  const DogProfileModel(
    name: '초코',
    gender: '수컷',
    breed: '비글',
    location: '대구',
    bio: '장난기 많고 활발한 성격이에요.',
    imageUrl: 'https://cdn.newscj.com/news/photo/201309/170126_122268_2013.jpg',
  ),
];

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  final CardSwiperController controller = CardSwiperController();
  final cards = dogProfiles.map(SwiperCardWidget.new).toList();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: CardSwiper(
                controller: controller,
                cardsCount: cards.length,
                onSwipe: _onSwipe,
                cardBuilder: (
                  context,
                  index,
                  horizontalThresholdPercentage,
                  verticalThresholdPercentage,
                ) =>
                    cards[index],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: '0',
                  onPressed: () => controller.swipe(CardSwiperDirection.left),
                  child: const Icon(Icons.close),
                ),
                FloatingActionButton(
                  heroTag: '1',
                  onPressed: () => controller.swipe(CardSwiperDirection.right),
                  child: const Icon(Icons.check),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _onSwipe(
      int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    if (direction == CardSwiperDirection.right) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              ProfileScreen(dogProfile: dogProfiles[previousIndex]),
        ),
      );
    }
    return true;
  }
}

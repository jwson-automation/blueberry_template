import 'package:blueberry_flutter_template/modules/core/views/match/widget/SwiperCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import 'ProfilePage.dart';
import 'model/DogProfileModel.dart';

///  MatchPage - 프로필 스와이프 매칭 화면
///
///  주요 구성 요소:
///  - CardSwiper: 프로필 카드를 스와이프할 수 있는 메인 위젯
///  - FloatingActionButton: 수동으로 좌/우 스와이프를 할 수 있는 버튼

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  final CardSwiperController controller = CardSwiperController();
  final cards = dogProfiles.map(SwiperCard.new).toList();

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
                cardBuilder: (context, index, horizontalThresholdPercentage, verticalThresholdPercentage,) => cards[index],
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

  bool _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    if (direction == CardSwiperDirection.right) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProfilePage(dogProfile: dogProfiles[previousIndex]),
        ),
      );
    }
    return true;
  }
}
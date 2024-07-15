import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../../model/DogProfileModel.dart';
import '../../widgets/match/SwiperCard.dart';
import 'ProfileScreen.dart';

///  MatchPage - 프로필 스와이프 매칭 화면
///
///  주요 구성 요소:
///  - CardSwiper: 프로필 카드를 스와이프할 수 있는 메인 위젯
///  - FloatingActionButton: 수동으로 좌/우 스와이프를 할 수 있는 버튼

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
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

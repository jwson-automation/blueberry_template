import 'package:blueberry_flutter_template/model/MBTIQuestionModel.dart';
import 'package:blueberry_flutter_template/providers/MBTIProvider.dart';
import 'package:blueberry_flutter_template/utils/AppStringEnglish.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MBTITestWidget extends ConsumerWidget {
  final pageController = PageController();

  final _buttonTexts = [
    AppStrings.stronglyAgree,
    AppStrings.agree,
    AppStrings.neutral,
    AppStrings.disagree,
    AppStrings.stronglyDisagree,
  ];

  MBTITestWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mbtiList = ref.watch(mbtiQuestionProvider);
    return mbtiList.when(
        data: (data) => Column(
              children: [
                Expanded(child: _buildPageView(pageController, data)),
                _buildListView(pageController, ref, _buttonTexts, data),
              ],
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('${AppStringEnglish.errorTitle}: $error')));
  }
}

Widget _buildPageView(
    PageController pageController, List<MBTIQuestionModel> questions) {
  return PageView.builder(
    controller: pageController,
    itemCount: questions.length,
    itemBuilder: (BuildContext context, int index) {
      return Center(
        child: Column(
          children: [
            Text(
              questions[index].question,
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            Image.network(
              questions[index].imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.fitHeight,
            )
          ],
        ),
      );
    },
  );
}

Widget _buildListView(PageController pageController, WidgetRef ref,
    List<String> buttonText, List<MBTIQuestionModel> data) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: buttonText.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: TextButton(
          onPressed: () {
            // 페이지 전환 중 버튼 입력 차단
            if (pageController.page != pageController.page?.ceilToDouble()) {
              return;
            }
            ref.read(mbtiProvider.notifier).updateScore(
                data[pageController.page!.toInt()].type, 2 - index);
            if (pageController.page == data.length - 1) {
              ref.read(mbtiProvider.notifier).setMBTI();
              Navigator.pop(context);
            } else {
              pageController.nextPage(
                duration: const Duration(microseconds: 1000000),
                curve: Curves.decelerate,
              );
            }
          },
          child: Text(style: const TextStyle(fontSize: 20), buttonText[index]),
        ),
      );
    },
  );
}

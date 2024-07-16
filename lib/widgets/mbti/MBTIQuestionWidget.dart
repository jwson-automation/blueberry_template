import 'package:blueberry_flutter_template/model/MBTIQuestionModel.dart';
import 'package:blueberry_flutter_template/providers/MBTIProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MBTIQuestionWidget extends ConsumerWidget {
  final pageController = PageController();

  // TODO: 텍스트 리소스 관리
  final _list = ['매우 그렇다', '그렇다', '보통이다', '아니다', '전혀 아니다'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _mbtiList = ref.watch(mbtiQuestionProvider);
    return _mbtiList.when(
        data: (data) => Column(
              children: [
                Expanded(child: _buildPageView(pageController, data)),
                _buildListView(pageController, _list),
              ],
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')));
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
              fit: BoxFit.cover,
            )
          ],
        ),
      );
    },
  );
}

Widget _buildListView(PageController pageController, List<String> data) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: TextButton(
          onPressed: () {
            pageController.nextPage(
              duration: const Duration(microseconds: 1000000),
              curve: Curves.decelerate,
            );
          },
          child: Text(style: const TextStyle(fontSize: 20), data[index]),
        ),
      );
    },
  );
}

import 'package:blueberry_flutter_template/model/MBTIModel.dart';
import 'package:blueberry_flutter_template/providers/MBTIProvider.dart';
import 'package:blueberry_flutter_template/screens/mbti/MBTITestScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MBTIHomeWidget extends ConsumerWidget {
  const MBTIHomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _mbti = ref.watch(mbtiProvider);

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
              _mbti != MBTIType.NULL
                  ? '당신의 MBTI는 ${_mbti.name}'
                  : 'MBTI를 검사해주세요'),
          Image.network(
            'gs://blueberrytemplate-2024-summer.appspot.com/mbti-question/mbti-test.webp',
            height: 300,
          ),
          TextButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MBTITestScreen()),
                  ),
              child: Text(
                  style: const TextStyle(fontSize: 24),
                  _mbti != MBTIType.NULL ? '재검사 하기' : '검사하기'))
        ],
      ),
    );
  }
}

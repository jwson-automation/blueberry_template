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
    final mbti = ref.watch(mbtiProvider);
    final imageUrl = ref.watch(mbtiImageProvider(mbti.name));

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
              mbti != MBTIType.NULL
                  ? '당신의 MBTI는 ${mbti.name}'
                  : 'MBTI를 검사해주세요'),
          imageUrl.when(
            data: (url) {
              return Center(
                child: Image.network(url, height: 300),
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
          ),
          TextButton(
              onPressed: () => {
                    ref.read(mbtiProvider.notifier).initScore(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MBTITestScreen()),
                    )
                  },
              child: Text(
                  style: const TextStyle(fontSize: 24),
                  mbti != MBTIType.NULL ? '재검사 하기' : '검사하기'))
        ],
      ),
    );
  }
}

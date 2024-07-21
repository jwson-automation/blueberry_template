import 'package:blueberry_flutter_template/providers/MBTIProvider.dart';
import 'package:blueberry_flutter_template/screens/mbti/MBTITestScreen.dart';
import 'package:blueberry_flutter_template/utils/AppStringEnglish.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';
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
              // mbti가 없으면 mbti 보여주기, 있으면 '검사해주세요'
              mbti != MBTIType.NULL
                  ? '${AppStrings.yourMBTIIs} ${mbti.name}'
                  : AppStrings.pleaseCheckMBTI),
          imageUrl.when(
            data: (url) {
              return Center(
                child: Image.network(url, height: 300),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('${AppStringEnglish.errorTitle}: $error')),
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
                  // mbti가 없으면 검사하기, 있으면 재검사하기
                  mbti != MBTIType.NULL ? AppStrings.reCheckMBTI : AppStrings.checkMBTI))
        ],
      ),
    );
  }
}

enum MBTIType {
  INFP, INFJ, INTP, INTJ, ISFP, ISFJ, ISTP, ISTJ, ENFP, ENFJ, ENTP, ENTJ, ESFP, ESFJ, ESTP, ESTJ, NULL
}

enum Extroversion { E, I }

enum Sensing { S, N }

enum Thinking { T, F }

enum Judging { J, P }
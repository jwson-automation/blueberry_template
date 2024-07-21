import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/camera/camera_provider.dart';
import '../../../providers/camera/image_quility_provider.dart';

class FixSettingCameraMediaPage extends ConsumerWidget {
  const FixSettingCameraMediaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraState = ref.watch(cameraProvider);
    final imageState = ref.watch(imageQualityProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("카메라 & 미디어 설정 페이지"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              cameraQualitySetBottomSheet(context, ref);
            },
            child: Expanded(
                child: ListTile(
              leading: const Icon(Icons.photo_camera_front_outlined),
              title: const Text(
                "카메라 화질 설정",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Text(
                cameraState.cameraQuality ? "고화질" : "일반화질",
                style: TextStyle(color: Colors.grey[500]),
              ),
            )),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              imageQualitySetBottomSheet(context, ref);
            },
            child: Expanded(
                child: ListTile(
              leading: const Icon(Icons.photo_camera_front_outlined),
              title: const Text(
                "이미지 화질 설정",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Text(
                imageState.imageQuality ? "고화질" : "일반화질",
                style: TextStyle(color: Colors.grey[500]),
              ),
            )),
          ),
        ],
      ),
    );
  }

  Future<dynamic> cameraQualitySetBottomSheet(
      BuildContext context, WidgetRef ref) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SizedBox(
              width: double.infinity,
              height: 150,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      ref.read(cameraProvider.notifier).setQuality(false);
                      Navigator.pop(context);
                    },
                    child: const Text("일반화질"),
                  ),
                  const Divider(),
                  TextButton(
                      onPressed: () {
                        ref.read(cameraProvider.notifier).setQuality(true);
                        Navigator.pop(context);
                      },
                      child: const Text("고화질")),
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> imageQualitySetBottomSheet(
      BuildContext context, WidgetRef ref) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SizedBox(
              width: double.infinity,
              height: 150,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      ref
                          .read(imageQualityProvider.notifier)
                          .setImageQuality(false);
                      Navigator.pop(context);
                    },
                    child: const Text("일반화질"),
                  ),
                  const Divider(),
                  TextButton(
                      onPressed: () {
                        ref
                            .read(imageQualityProvider.notifier)
                            .setImageQuality(true);
                        Navigator.pop(context);
                      },
                      child: const Text("고화질")),
                ],
              ),
            ),
          );
        });
  }
}

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../providers/camera/camera_provider.dart';
import '../../../providers/camera/PageProvider.dart';
import 'CameraShadow.dart';
import 'MyPageProfileImagePreview.dart';

class ProfileCameraPage extends ConsumerStatefulWidget {
  const ProfileCameraPage({super.key});

  @override
  ConsumerState<ProfileCameraPage> createState() => _TakePhotoState();
}

class _TakePhotoState extends ConsumerState<ProfileCameraPage> {
  bool _isPressed = false;
  Size size = Size.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cameraProvider.notifier).getReadyToTakePhoto();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageNotifier = ref.watch(pageProvider.notifier);
    final cameraState = ref.watch(cameraProvider);
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Photo'),
        leading: IconButton(
          onPressed: () {
            pageNotifier.moveToPage(0);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: size.width,
                height: size.width * 1.3,
                color: Colors.black,
                child:
                    cameraState.readyTakePhoto && cameraState.controller != null
                        ? _getPreview(cameraState.controller!, context)
                        : _buildErrorMessage(cameraState.changeCamera),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () async {
                      try {
                        await ref.read(cameraProvider.notifier).toggleCamera();
                        print("turn Camera");
                      } catch (error) {
                        print("Error toggling camera: $error");
                        print("A");
                      }
                    },
                    icon: const Icon(Icons.change_circle),
                  ))
            ],
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  if (cameraState.readyTakePhoto) {
                    attemptTakePhoto(cameraState, context);
                  }
                },
                onTapDown: (_) {
                  setState(() {
                    _isPressed = true;
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    _isPressed = false;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    _isPressed = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(
                        side: BorderSide(
                          color: _isPressed ? Colors.red : Colors.black12,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPreview(CameraController controller, BuildContext context) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Stack(children: [
            SizedBox(
              width: size.width,
              height: size.width * 1.2,
              child: CameraPreview(controller),
            ),
            Positioned.fill(
              child: CustomPaint(
                painter: CameraShadow(radius: size.width * 0.48),
                // 프리뷰 원 내부 사이즈 조정
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildErrorMessage(bool isFrontCamera) {
    String message = isFrontCamera
        ? "전면 카메라 모드 입니다. 카메라 상태를 확인 해 주세요."
        : "후면 카메라 모드 입니다. 카메라 상태를 확인 해 주세요.";
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  void attemptTakePhoto(CameraState cameraState, BuildContext context) async {
    // file에 접근할꺼임 사진을 촬영하고 저장하기 위해서
    final String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
    // 이미지를 저장할때 시간을 기준으로 이미지명을 만들기 위해서 사용함
    try {
      final path =
          join((await getTemporaryDirectory()).path, '$timeInMilli.png');

      final XFile file = await cameraState.controller!.takePicture();

      await file.saveTo(path);

      final File imageFile = File(path);

      if (context.mounted) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => SharePostScreen(imageFile)));
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

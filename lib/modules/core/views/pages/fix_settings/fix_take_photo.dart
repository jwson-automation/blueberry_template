import 'dart:io';
import 'package:blueberry_flutter_template/modules/core/providers/camera/camera_provider.dart';
import 'package:blueberry_flutter_template/modules/core/views/pages/fix_settings/fix_camera_preview_overlay.dart';
import 'package:blueberry_flutter_template/modules/core/views/pages/fix_settings/fix_setting_sharepost_image.dart';
import 'package:blueberry_flutter_template/modules/core/views/pages/fix_settings/fix_setting_size.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class TakePhoto extends ConsumerStatefulWidget {
  const TakePhoto({super.key});

  @override
  ConsumerState<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends ConsumerState<TakePhoto> {
  bool _isPressed = false;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cameraProvider.notifier).getReadyToTakePhoto();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cameraState = ref.watch(cameraProvider);
    size = MediaQuery.of(context).size;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: size.width,
              height: size.width * 1.3,
              color: Colors.black,
              child: cameraState.readyTakePhoto && cameraState.controller != null
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
                  icon: Icon(Icons.change_circle),
                )
            )
          ],
        ),

        Expanded(
          child: Center(
            child: GestureDetector(
              onTap: () {
                if (cameraState.readyTakePhoto){
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
    );
  }

  Widget _getPreview(CameraController controller, BuildContext context) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Stack(
            children: [
              Container(
              width: size.width,
              height: size.width *1.2,
              child: CameraPreview(controller),
            ),
              Positioned.fill(
                child: CustomPaint(
                  painter: DarkenOutsideCirclePainter(radius: size.width * 0.48),
                  // 프리뷰 원 내부 사이즈 조정
                ),
              ),
          ]
          ),
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
        style: TextStyle(color: Colors.white, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
  void attemptTakePhoto(CameraState cameraState, BuildContext context) async {
    // file에 접근할꺼임 사진을 촬영하고 저장하기 위해서
    final String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
    // 이미지를 저장할때 시간을 기준으로 이미지명을 만들기 위해서 사용함
    try{
      final path = join( (await getTemporaryDirectory()).path, '$timeInMilli.png');

      final XFile file = await cameraState.controller!.takePicture();

      await file.saveTo(path);

      final File imageFile = File(path);

      if (context.mounted) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SharePostScreen(imageFile)));
      }
    }catch(e){
      print('Error: $e');
    }
  }

}
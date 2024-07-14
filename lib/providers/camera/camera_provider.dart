import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// CameraState 클래스 정의
class CameraState {
  final CameraController? controller;  // 현재 카메라 컨트롤러 인스턴스 (nullable)
  final CameraDescription? cameraDescription;  // 현재 사용 중인 카메라의 설명 (nullable)
  final bool readyTakePhoto;  // 사진을 찍을 준비가 되었는지를 나타내는 불리언 값
  final bool changeCamera;  // 카메라 전환 여부를 나타내는 불리언 값
  final bool cameraQuality;

  // CameraState 클래스의 생성자
  CameraState({
    this.controller,
    this.cameraDescription,
    this.readyTakePhoto = false,  // 기본값은 false
    this.changeCamera = false,
    this.cameraQuality = false// 기본값은 false
  });

  // 현재 상태를 복사하여 새로운 상태를 반환하는 copyWith 메서드
  CameraState copyWith({
    CameraController? controller,
    CameraDescription? cameraDescription,
    bool? readyTakePhoto,
    bool? changeCamera,
    bool? cameraQuality,
  }) {
    return CameraState(
      controller: controller ?? this.controller,  // 전달된 값이 없으면 기존 값을 사용
      cameraDescription: cameraDescription ?? this.cameraDescription,
      readyTakePhoto: readyTakePhoto ?? this.readyTakePhoto,
      changeCamera: changeCamera ?? this.changeCamera,
      cameraQuality: cameraQuality ?? this.cameraQuality
    );
  }
}

// CameraStateNotifier 클래스는 StateNotifier를 상속받아 CameraState를 관리합니다.
class CameraStateNotifier extends StateNotifier<CameraState> {
  CameraStateNotifier() : super(CameraState());

  void setQuality(bool highQuality) {
    state = state.copyWith(cameraQuality: highQuality);

    // 변경된 카메라 퀄리티로 카메라 설명 설정
    if (state.cameraDescription != null) {
      setCameraDescription(state.cameraDescription!);
    }
    print(state.cameraQuality);
  }

  // 사진을 찍을 준비를 하는 비동기 메서드
  Future<void> getReadyToTakePhoto() async {
    List<CameraDescription> cameras = await availableCameras();  // 사용 가능한 카메라 목록을 가져옴

    if (cameras.isNotEmpty) {
      // changeCamera 값에 따라 카메라 선택
      setCameraDescription(cameras[state.changeCamera ? 1 : 0]);
    }

    bool init = false;
    while (!init) {
      init = await initialize();
    }
  }

  // 카메라 설명을 설정하고 카메라 컨트롤러를 초기화하는 메서드
  void setCameraDescription(CameraDescription cameraDescription) {
      final controller = CameraController(cameraDescription,
          state.cameraQuality ? ResolutionPreset.high : ResolutionPreset.medium); // 카메라 컨트롤러 생성
      // 만약에 카메라 퀄리티를 높이고 싶ㅇ면 medium -> high 로 변경 해 주세요 !!

      state = state.copyWith(
        cameraDescription: cameraDescription,
        controller: controller,
        readyTakePhoto: false,
      );

      controller.initialize().then((_) {
        state = state.copyWith(
          controller: controller,
          readyTakePhoto: true,
        );
      }).catchError((e) {
        state = state.copyWith(
          controller: controller,
          readyTakePhoto: false,
        );
      });

  }


  // 카메라 컨트롤러를 초기화하는 비동기 메서드
  Future<bool> initialize() async {
    try {
      await state.controller?.initialize();
      state = state.copyWith(readyTakePhoto: true);
      return true;
    } catch (e) {
      return false;
    }
  }

  // 카메라 전환을 위한 메서드
  Future<void> toggleCamera() async {
    List<CameraDescription> cameras = await availableCameras();  // 사용 가능한 카메라 목록을 가져옴

    if (cameras.length > 1) {
      // changeCamera 값을 반전시켜 전면/후면 카메라 전환
      bool newChangeCamera = !state.changeCamera;
      setCameraDescription(cameras[newChangeCamera ? 1 : 0]);
      state = state.copyWith(changeCamera: newChangeCamera);

      // 카메라 초기화 완료 후 상태 업데이트
      bool init = false;
      while (!init) {
        init = await initialize();
      }
    }
  }

  // 리소스를 정리하는 dispose 메서드
  @override
  void dispose() {
    state.controller?.dispose();  // 카메라 컨트롤러가 있다면 해제
    super.dispose();
  }
}

// 카메라 상태를 관리하는 StateNotifierProvider 생성
final cameraProvider = StateNotifierProvider<CameraStateNotifier, CameraState>((ref) {
  return CameraStateNotifier();
});
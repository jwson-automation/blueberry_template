import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageState {
  bool imageQuality;
  int imageQualityLevel = 100;

  ImageState({
    this.imageQuality = false,
    required this.imageQualityLevel
});
  ImageState copyWith({
    bool? imageQuality,
    int? imageQualityLevel,
}) {
    return ImageState(
      imageQuality: imageQuality ?? this.imageQuality,
      imageQualityLevel: imageQualityLevel ?? this.imageQualityLevel
    );
  }
}


class ImageQualityStateNotifier extends StateNotifier<ImageState> {
  ImageQualityStateNotifier() : super (ImageState(imageQualityLevel: 100));

  void setImageQuality(bool newQuality) {
    state = state.copyWith(
      imageQuality: newQuality,

    );
    if (!state.imageQuality) {
      state = state.copyWith(
          imageQualityLevel: 80
      );
    } else {
      state = state.copyWith(
          imageQualityLevel: 100
      );
    }
  }
}

final imageQualityProvider = StateNotifierProvider<ImageQualityStateNotifier, ImageState>((ref){
  return ImageQualityStateNotifier();
});



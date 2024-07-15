import 'package:flutter/material.dart';

import 'AppTextStyle.dart';



class DialogStyle extends ThemeExtension<DialogStyle> {
  const DialogStyle({
    this.title = black16BoldTextStyle,
    this.description = black12TextStyle,
    this.cancelButtonText = blue16BoldTextStyle,
    this.agreeButtonText = blue16TextStyle,
  });

  final TextStyle? title;
  final TextStyle? description;
  final TextStyle? cancelButtonText;
  final TextStyle? agreeButtonText;

  @override
  ThemeExtension<DialogStyle> copyWith({
    TextStyle? title,
    TextStyle? description,
    TextStyle? cancelButtonText,
    TextStyle? agreeButtonText,
  }) =>
      DialogStyle(
        title: title ?? this.title,
        description: description ?? this.description,
        cancelButtonText: cancelButtonText ?? this.cancelButtonText,
        agreeButtonText: agreeButtonText ?? this.agreeButtonText,
      );

  @override
  ThemeExtension<DialogStyle> lerp(
      ThemeExtension<DialogStyle>? other,
      double t,
      ) {
    if (other is! DialogStyle) {
      return this;
    }

    return DialogStyle(
      cancelButtonText: TextStyle.lerp(
        cancelButtonText,
        other.cancelButtonText,
        t,
      ),
    );
  }
}

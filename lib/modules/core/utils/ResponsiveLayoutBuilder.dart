import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder(this.context, this.child, {super.key});

  final BuildContext context;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          // 태블릿 디바이스일 경우
          return Stack(
            children: [
              Container(
                color: Colors.black12, // 검정색 배경
              ),
              Center(
                child: SizedBox(
                  width: 550, // 가운데 화면의 너비
                  child: child,
                ),
              ),
            ],
          );
        }
        return child!;
      },
    );
  }
}

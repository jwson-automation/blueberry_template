import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';


class FixSettingNotice extends ConsumerStatefulWidget {
  const FixSettingNotice({super.key});

  @override
  ConsumerState<FixSettingNotice> createState() => _FixSettingNoticeState();
}

class _FixSettingNoticeState extends ConsumerState<FixSettingNotice> {
  bool _isWebViewVisible = false;
  bool _isWebViewVisible2 = false;
  late WebViewController _webViewController;
  late WebViewController _webViewController2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _webViewController = WebViewController();
    _webViewController2 = WebViewController();
  }

  void _toggleWebView() {
    setState(() {
      _isWebViewVisible = !_isWebViewVisible;
    });
  }

  void _toggleWebView2() {
    setState(() {
      _isWebViewVisible = !_isWebViewVisible;
      _isWebViewVisible2 = !_isWebViewVisible2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("공지 사항"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                _toggleWebView();
                if (_isWebViewVisible) {
                  _webViewController.loadRequest(Uri.parse('https://flutter.dev/'),
                  );
                }
              },
              child: const ListTile(
                leading: Icon(Icons.speaker_notes),
                title: Text("블루베리 템플릿 버젼 1.0.0v"),
              ),
            ),
            AnimatedContainer(
                duration: const Duration(microseconds: 3000),
              curve: Curves.easeInOut,
              height: _isWebViewVisible? 500.0 : 0,
              child: _isWebViewVisible
              ? WebViewWidget(
                  controller: _webViewController,
              ) : Container()
            ),
            const Divider(),

            GestureDetector(
              onTap: (){
                _toggleWebView2();
                if (_isWebViewVisible2) {
                  _webViewController.loadRequest(Uri.parse('https://www.google.co.kr/'),
                  );
                }
              },
              child: const ListTile(
                leading: Icon(Icons.speaker_notes),
                title: Text("블루베리 템플릿 버젼 0.1.0v"),
              ),
            ),
            AnimatedContainer(
                duration: const Duration(microseconds: 3000),
                curve: Curves.easeInOut,
                height: _isWebViewVisible2? 500.0 : 0,
                child: _isWebViewVisible2
                    ? WebViewWidget(
                  controller: _webViewController,
                ) : Container()
            ),

          ],
        ),
      )
    );
  }
}

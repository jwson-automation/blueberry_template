## 블루베리 템플릿이 뭔가요?

- 쇼핑몰, 커뮤니티, 소개팅, 등의 자주 사용되는 서비스에 필요한 코드를 모두 넣어둔 템플릿입니다.

## 코드를 어떻게 확인하면 되나요?

<img alt="a1" width="500" src="https://github.com/jwson-automation/blueberry_template/assets/108061510/fcb2e019-5cbc-4d5f-b47e-a0b6755858ac">

- 블루베리 템플릿의 모든 코드는 `위젯 - 프로바이더`의 아주 단순한 구조로 이루어져 있습니다.
- 빌드 후 필요한 화면을 찾으셨다면 해당 화면에 필요한 버튼(위젯)을 찾으시고 그 위젯과 연결된 프로바이더를 확인해주세요.

## 이 레포지토리에 기여하려면 어떻게 하면 되나요?
- 오픈소스인 블루베리 템플릿을 함께 만들어가실 개발자, 디자이너 모집중입니다 :)
- 카카오톡 링크 : https://open.kakao.com/o/savka5yg
( 플러터 초심자 분들의 협업 학습을 위한 2주간의 인턴 체험도 진행중이니 신청해주세요! )

## 어떻게 빌드하나요?

0. Android Studio, Xcode의 최신화를 해 주세요.

1. 플러터 버전을 최신으로 업데이트 해 주세요. `FVM 설정 예정` 
- Flutter Version Upgrade

2. 앱 빌드를 위한 폴더들을 생성해주세요.
- 터미널에 `flutter create .` 입력

3. 파이어베이스 설정을 해주세요.
- 파이어베이스 프로젝트 생성
- 'curl -sL https://firebase.tools | bash'
- 'dart pub global activate flutterfire_cli'
- `flutterfire configure --project={본인의 파이어베이스 프로젝트 명}'
    ```
    Which platforms should your configuration support (use arrow keys & space to select)?
  
    [v] Android
    [v] iOS
    [v] Web 
  
    Which Android application id (or package name) do you want to use for this configuration, e.g. 'com.example.app'
    
    package name
    Android : com.blueberry.template
    ios : com.example.blueberryTemplate
    ```
4. google-services.json, GoogleService-Info.plist 파일을 프로젝트에 추가해주세요. 
- `파이어베이스 콘솔 접속 > 프로젝트 설정 > 프로젝트 설정 > 아래로 스크롤 > 내 앱` 에서 다운로드 가능합니다.

    !!주의!!

    3번 항목은 하지말아주세요! `빌드가 불안정하게 변합니다.`

    <img width="500" alt="caution!" src ="https://github.com/user-attachments/assets/911a03ec-a1ca-4054-a36e-b6e4e67f0c7e">

    만약 이미 해버리셨다면 iOS 폴더를 삭제 후 다시 `flutter create .` 해주세요.


5. Firebase 기능을 활성화 해주세요.
```
Authentication > 시작하기 > 로그인 방법 > 이메일/비밀번호 활성화
Firestore Database > 데이터베이스 만들기 > 테스트 모드에서 시작
Storage > 시작하기 > 테스트 모드에서 시작
```

6. Freezed 파일과 Gen 파일을 생성해주세요.
- `flutter pub run build_runner build --delete-conflicting-outputs` 커맨드를 터미널에 입력합니다.
- `fluttergen` 커맨드를 터미널에 입력합니다.

## 참고
웹 빌드시에는 렌더러를 사용해야 합니다.
WEB IMAGE RENDERING (https://docs.flutter.dev/development/platform-integration/web/renderers)
- `flutter run -d chrome --web-renderer html`

## 템플릿 기반 서비스 오픈 계획

![image](https://github.com/jwson-automation/blueberry_template/assets/108061510/e451dfde-9141-42a5-805c-a0062a9c11e2)


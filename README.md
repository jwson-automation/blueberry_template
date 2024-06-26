## What is blueberry Template

- 쇼핑몰, 커뮤니티, 소개팅, 등의 자주 사용되는 서비스에 필요한 코드를 모두 넣어둔 템플릿입니다.
- 공통적인 부분만 넣어 사용하는 일반적인 템플릿과 다르게, 여기에는 필요한 모든 코드들을 넣어두고, 클론해서 필요 없는 기능을 삭제하는 방향으로 템플릿을 사용합니다.
- 코어 부분의 코드에 `회원가입, 로그인, 마이페이지, 설정, 다이얼로그, 비밀번호 찾기, AI챗봇` 기능이 포함되어 있어서 초반에 쉽게 공통 기능을 만들 수 있습니다.
- 추가로 모듈에 `쇼핑, 커뮤니티, 소개팅` 각각의 목적에 맞게 분리된 기능들과 위젯도 포함되어 있어서, 누구나 쉽게 자신만의 앱을 만들 수 있습니다.

- 항상 같이 운영하고 만들어 갈 개발자 분들을 모집중입니다 :) 아래 카카오톡 링크로 언제든 연락주세요!
- https://open.kakao.com/o/savka5yg

- 소통은 디스코드로 이루어지고 매주 일요일 8시에 회의가 있습니다!

## How to Build

- 플러터 버전을 최신으로 업데이트 해 주세요. `현재버전 : ??` 
Flutter Version Upgrade

- 파이어베이스 설정을 해주세요.
1. 파이어베이스 프로젝트 생성
2. - 'curl -sL https://firebase.tools | bash'
   - 'dart pub global activate flutterfire_cli'
   - `flutterfire configure --project={프로젝트명}'
   (이것만 해도 앱이 빌드 됩니다.)

4. Authentication > 시작하기 > 로그인 방법 > 이메일/비밀번호 활성화
5. Firestore Database > 데이터베이스 만들기 > 테스트 모드에서 시작
6. Storage > 시작하기 > 테스트 모드에서 시작

7. Admin Page에서 초기 설정 버튼을 눌러주세요. ( 아직 통합 버튼이 없어서, 배너, 항목, 이벤트 업로드를 해줘야 함 )

- 웹 빌드시에는 렌더러를 사용해야 합니다.
WEB IMAGE RENDERING (https://docs.flutter.dev/development/platform-integration/web/renderers)
- `flutter run -d chrome --web-renderer html`

## TO DO LIST

- [x] 초기 인원 모집
- [x] 팀 빌딩 ( 아키텍쳐와 협업 방향에 대한 회의 )
- [x] 멤버들에게 깃헙 프로젝트 오픈
- [x] 깃헙 이슈 작성 및 할당
- [ ] 템플릿 1차 완성

- [ ] 사이드 프로젝트 결과물 공유 웹 사이트 만들기
- [ ] 각자 사이드 프로젝트 진행
- [ ] 사이드 프로젝트 진행 후 추가된 컴포넌트 템플릿에 추가
- [ ] 2차 인원 모집

## 템플릿 기반 서비스 오픈 계획

![image](https://github.com/jwson-automation/blueberry_template/assets/108061510/e451dfde-9141-42a5-805c-a0062a9c11e2)


## .gitignore 에 platform 예외 처리에 대한 변화

개발자마다 환경이 다르므로 설정 파일이 충돌해 코드 공유가 어려울 수 있습니다. 예를 들어, package name 이나 bundle id 부터 시작해서, 결제 관련 코딩을 하는 경우 예를 들면, 페이팔, Stripe, 인앱결제를 사용하려면 AndroidManifest, google-service.json, Info.plist, GoogleService-Info.plist 등의 파일 수정이 필요하지만, 이 정보는 공유되면 안되는 정보 일 수 있으며, 또 공유가 되면, 필요 없는 설정이 추가되거나 자신의 설정이 삭제되거나 하는 일이 발생 합니다. 따라서 각 개발자가 필요한 플랫폼을 직접 설정하도록 합니다.

그래서 가장 간단한 방법은 자신이 필요한 플랫폼만 직접 설치해서 사용하는 것입니다. 플랫폼 설정/추가하는 자세한 방법은 플러터 공식 홈페이지에 있으므로 참고해 주시기 바랍니다.

Andoid,iOS,Web 추가하는 방법

```sh
rm -rf android ios web
flutter create . --platform=android,ios,web --org [도메인] --project-name [앱이름]
```

예를 들면, `flutter create . --platform=android,ios,web --org com.lab --project-name preset` 와 같이 하면 된다.

## 비밀번호 리셋

이메일/비밀번호 로그인에서 비밀번호를 잃어 버린 경우, 사용자는 다음 같은 시나리오를 통해서 비밀번호를 변경 할 수 있습니다.

### 웹에서 비밀번호 리셋

1. (웹에서) 비밀번호 리셋 요청하면 리셋 링크가 메일로 전달 됨
2. 이메일 박스에서 비밀번호 리셋 링크 클릭하면 웹 페이지가 열림
3. 구글에서 제공하는 비밀번호 변경 폼에서 비밀번호 변경
4. 홈페이지를 열어서 변경된 비밀번호로 로그인

### 앱에서 비밀번호 리셋

1. (앱에서) 비밀번호 리셋 요청하면 리셋 링크가 메일로 전달 됨
2. 이메일 박스에서 리셋 링크 터치하면 **앱이 열림**
3. (앱 내에서) 비밀번호 변경
4. 새 비밀번호로 로그인

앱에서 비밀번호를 변경하면 Deeplink 로 웹 페이지가 아닌, 앱 내에서 비밀번호를 변경할 수 있습니다. 즉, 웹 페이지가 열리고, 웹 페이지를 닫고, 앱을 열고 할 필요 없이 부드럽게 동작이 연결됩니다.




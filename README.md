How to Build

- 플러터 버전을 최신으로 업데이트 해 주세요. `현재버전 : 2.5.0-8.1.pre` 
Flutter Version Upgrade

- 파이어베이스 설정을 해주세요.
1. 파이어베이스 프로젝트 생성
2. `flutterfire configure --project={프로젝트명}`
   (이것만 해도 앱이 빌드 됩니다.)

4. Authentication > 시작하기 > 로그인 방법 > 이메일/비밀번호 활성화
5. Firestore Database > 데이터베이스 만들기 > 테스트 모드에서 시작
6. Storage > 시작하기 > 테스트 모드에서 시작

7. Admin Page에서 초기 설정 버튼을 눌러주세요. ( 아직 통합 버튼이 없어서, 배너, 항목, 이벤트 업로드를 해줘야 함 )

- 웹 빌드시에는 렌더러를 사용해야 합니다.
WEB IMAGE RENDERING (https://docs.flutter.dev/development/platform-integration/web/renderers)
- `flutter run -d chrome --web-renderer html`


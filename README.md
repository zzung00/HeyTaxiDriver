# HeyTaxiDriver

지역 택시 기사용 iOS 어플리케이션입니다.

# 주요 내용

### ✏️ Code Base로 개발했습니다.
---------------------------------
#### Storyboard vs Code Base
* Storyboard는 결과물에 대해 예측이 쉽고 소스코드를 일일이 기억하지 않아도 되지만, 무겁고 규모가 커질수록 가독성이 떨어지며 conflict 발생하면 해결이 어렵습니다.
* Code Base는 어떤 화면이 만들어질지 파악하기 힘들고 코드가 길어지지만, 따로 무거워지지 않고 상대적으로 diff를 보고 알아보기 쉬워 conflict 가능성이 상대적으로 낮습니다.

### ✏️ MVVM 패턴을 적용하여 개발했습니다.
---------------------------------
* Model, View, ViewModel 계층으로 나누어 개발 및 유지보수의 안정함을 경험했습니다.
* 각각의 부분이 독립적이기 때문에 모듈화하여 개발 가능합니다.
* View와 Model 사이의 의존성이 없고 View와 ViewModel 사이의 의존성이 없으므로 오류를 보다 찾기 쉽습니다.

<img width="456" alt="스크린샷 2022-02-02 오후 2 24 26" src="https://user-images.githubusercontent.com/90949515/152097736-8deb9eb2-0419-4682-8866-8ffe74dc382a.png">

### ✏️ HTTP 통신
----------------------------------
* Alamofire 라이브러리를 활용했습니다. (참조: [Alamofire Library](https://github.com/Alamofire/Alamofire))
* [HeyTaxi-Driver Server](https://github.com/jeyog/heytaxi)와 통신

### ✏️ 라이브러리 설치
* 순서 (project내에서 처리)
1. pod init
2. open Podfile
3. pod 'Alamofire', 'RxSwift', 'RxCocoa' 추가
4. pod install

‼️ Mac M1 칩셋일 경우, 터미널을 Rosetta를 이용하여 열어 ffi 설치 후 pod install 진행해주세요.

### ✏️ WebSocket 통신
-----------------------------------
* StompClientLib를 활용했습니다.
* 택시의 실시간 위치를 서버에 보내기 위해 사용했습니다.

### ✏️ 라이브러리 설치
* 순서 (project내에서 처리)
1. open Podfile
2. pod 'StompClientLib' 추가
3. pod install

### ✏️ Keychain 활용
------------------------------------
* Keychain 이란?
  - Mac OS와 iOS에서 사용하는 암호화된 저장소로, 사용자의 수고를 덜어주기 위해 대신 데이터를 안전하게 저장하는 저장소.


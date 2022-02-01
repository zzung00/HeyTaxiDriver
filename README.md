# HeyTaxiDriver
==================================
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

![mvvm](https://user-images.githubusercontent.com/90949515/151707888-399e5e83-4fcd-4f95-b228-d4fc648d9143.png)

### ✏️ HTTP 통신
----------------------------------
* Alamofire 라이브러리를 활용했습니다. (참조: [Alamofire Library](https://github.com/Alamofire/Alamofire))
* [HeyTaxi-Driver Server](https://github.com/jeyog/heytaxi)와 통신

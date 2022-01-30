# HeyTaxiDriver

지역 택시 기사용 iOS 어플리케이션입니다.

# 주요 내용
### MVVM 패턴을 적용하여 개발했습니다.
* Model, View, ViewModel 계층으로 나누어 개발 및 유지보수의 안정함을 경험했습니다.
* 각각의 부분이 독립적이기 때문에 모듈화하여 개발 가능합니다.
* View와 Model 사이의 의존성이 없고 View와 ViewModel 사이의 의존성이 없으므로 오류를 보다 찾기 쉽습니다.

### HTTP 통신
* Alamofire 라이브러리를 활용했습니다. (참조: [Alamofire Library](https://github.com/Alamofire/Alamofire))
* [HeyTaxi-Driver Server](https://github.com/jeyog/heytaxi)와 통신

# location

- MapKit은 작은범위의 위치에는 그리 찾는 성능이 좋지 못함
- micro-locationd에 대해 배우자
- 물체간 작은 거리를 측정하는 기술
- iBeacon 은 iOS7부터 도입
- Locate Beacon을 단말에 설치하고 블루투스켜야함

- 위치는 비밀정보이므로, 퍼미션을 요구해야함
- info.plist 에 허용옵션설정

```swift
import CoreLocation

var locationManager: CLLocationManager?

class ViewController: UIViewController, CLLocationManagerDelegate {

```

- Core Location class 는 어떻게 location을 노티받을지 설정 가능
- CLLocationManagerDelegate 로 위임 필요

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    locationManager = CLLocationManager()
    locationManager?.delegate = self
    locationManager?.requestAlwaysAuthorization()

    view.backgroundColor = .gray
}
```

```swift
func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways {
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            if CLLocationManager.isRangingAvailable() {
                // do stuff
            }
        }
    }
}
```

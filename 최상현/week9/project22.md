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


```swift
func update(distance: CLProximity) {
    UIView.animate(withDuration: 1) {
        switch distance {
        case .unknown:
            self.view.backgroundColor = UIColor.gray
            self.distanceReading.text = "UNKNOWN"

        case .far:
            self.view.backgroundColor = UIColor.blue
            self.distanceReading.text = "FAR"

        case .near:
            self.view.backgroundColor = UIColor.orange
            self.distanceReading.text = "NEAR"

        case .immediate:
            self.view.backgroundColor = UIColor.red
            self.distanceReading.text = "RIGHT HERE"
        }
    }
}
```

- 위 의 경우 CLProxmity 가 enum으로 개발되어있어서. 나중에 애플이 위 enum을 변경할 수도 있다
- 이 경우 해결책은 2가지가 있는데, @unknown default 를 case로 추가한다

```swift
@unknown default:
self.view.backgroundColor = .black
self.distanceReading.text = "WHOA!"

// 혹은..
        default:
            self.view.backgroundColor = UIColor.gray
            self.distanceReading.text = "UNKNOWN"
        }
```

```swift
func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
    if let beacon = beacons.first {
        update(distance: beacon.proximity)
    } else {
        update(distance: .unknown)
    }
}
```

- 만약 비콘을 아무거나 받게 된다면, 첫번째를 꺼내 proximity 를 이용해 update를 호출
- 비콘 기기와의 거리가 가까워지면 NEAR로, 멀어지면 FAR로

<img width="305" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/96da5d9c-d67d-48c1-9d89-640e9bbcf3c0">

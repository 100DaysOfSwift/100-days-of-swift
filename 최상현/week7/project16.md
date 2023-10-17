# MapKit

- apple's mapping framework
- 핀도 놓고 루트도 짜고 줌도 하고

- 스토리보드에서 MKMapView 를 생성해 viewController에 할당
- 필드로 추가 `@IBOutlet var mapView: MKMapView!`
- MapKit 임포트 해야만 MKMapView 가 무엇인지 swift가 이해함

- CLLocationCoordinate2D : 위경도를 지니는 새로운 데이터타입
  MKAnnotation protocol 을 통해 MKView에 addAnnotation() 메서드를 사용 가능


```swift

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
    
}

class ViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let seoul = Capital(title: "Seoul", coordinate: CLLocationCoordinate2D(latitude: 37.532600, longitude: 127.024612
), info: "capital of korea")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([seoul,oslo,paris,rome,washington])
        
    }
    
    
}
```

<img width="451" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/a4c339bd-e4f9-49c1-9f2b-6c2395db11e1">


- annotation View 를 수정하는 건 table view cell 을 커스터마이징하는것과 같다
- iOS가 reuse 해줘서 메모리 사용을 최적화한다

- 리액티브한 맵 메시지를 쓰기 위해 delegate를 추가한다 `class ViewController: UIViewController, MKMapViewDelegate {`

```swift
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1 수도여야만 한다
        guard annotation is Capital else { return nil }

        // 2 reuse identifier 정의. annotation view 재사용하도록 해줌
        let identifier = "Capital"

        // 3  map 안쓰는 뷰의 view's pool에서 dequeue
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            //4 없으면 새로 할당
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true

            // 5 버튼을 콜아웃뷰로 매핑 
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // 6 있으면 재할당?
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info

        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
```
<img width="448" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/d5335aab-2680-4c7e-a520-79cb58175c27">
- 만약 콜아웃등 정상 동작안한다면 viewdidLoad() 내 이것을 추가. `mapView.delegate = self`


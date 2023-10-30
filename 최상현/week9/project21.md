# local notification

- app 이 run 하지 않을 때, 알람을 잠금화면에 전송
- 해야할 것: 권한이없으면 앱에서 잠금화면으로 메시지 못쏨


```swift

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "register", style: .plain, target: self, action: #selector(registerLocal))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }

    
    @objc func registerLocal() {
        
    }
    
    @objc func scheduleLocal() {
        
    }

}


```

- 권한 요청을 해야함. 이게 registerLocal()
- requestAuthorization() in UNUserNotificationCenter 로 해결
- 클로져를 제공해야 함
- 권한부여의 잦은 테스트를 위해선 `Choose the Hardware menu then “Erase all Content and Settings" to make this happen.`
```swift
@objc func registerLocal() {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }

    @objc func scheduleLocal() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "late wake up call" // main title of alarm
        content.body = "일찍일어난 새가 벌레를 잡고 두번째 쥐는 치즈를 잡는다" // main text
        content.categoryIdentifier = "alarm" // // 커스텀 액션
        content.userInfo = ["customData": "fizzbuzz"] // 커스텀 데이터
        content.sound = UNNotificationSound.default // 특정 소리를 내고 싶다면
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10 // 10:30 에 동작할 것
        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        // 5초후 1번 발생
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
```

# 응답에 반응하는법 
- categoryIdentifier: 버튼 생성을 위해 이 문자열을 이용 가능
- show me more 를 만들 것

```swift
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self

        let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])

        center.setNotificationCategories([category])
    }
```

- scheduleLocal() 메서드 맨 앞에 두자. 알람 카테고리를 등록했다
- 이제 알림센터의 didReceive 메서드를 구현하면 된다.
- UserInfo 에 고객데이터를 저장. 알람과 앱 컨텐츠를 연결 가능
- Identifier값으로 실행할 액션을 구분
```swift
func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    // pull out the buried userInfo dictionary
    let userInfo = response.notification.request.content.userInfo

    if let customData = userInfo["customData"] as? String {
        print("Custom data received: \(customData)")

        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            // the user swiped to unlock
            print("Default identifier")

        case "show":
            // the user tapped our "show more info…" button
            print("Show more information…")

        default:
            break
        }
    }

    // you must call the completion handler when you're done
    completionHandler()
}
```



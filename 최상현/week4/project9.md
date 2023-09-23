# GCD 

## UI 를 Locking하는게 나쁜 이유
 프로젝트7에서 viewDidLoad 내에서 API를 통해 json데이터를 가져와 리스트뷰를 만들었음
- 이 때, Data의 contextsOf 를 internet으로부터의 data를 가져오도록 사용했는데,
이건 blocking call (동기식 호출) 임
- 즉, 서버랑 연결되고 데이터 다 가져올때까지 다른 코드는 실행못함
- cpu core 갯수만큼 동시 작업 가능함

- 만약 외부 자원을 접근하려면, background thread를 통해서 해야 한다
- main thread에서 하지말자
- GCD 는 자동적으로 스레드를 만들어주는 일을 하기 때문에 귀찮음이 없다
- 제일 중요한 것 중 하나는 `async()`

## async()
- GCD 는 큐로 동작한다.
- 시작 순서는 제어되지만 종료순서는 보장안됨
- quality of servie 라는 것에 의해 얼마나 코드가 중요한지가 결정됨
- 메인스레드를 실행하는 메인큐가 제일 중요.
- 쓸 수 있는 4가지 백그라운드 큐가 존재하는데 각각의 QoS 레벨이 있다

1. UI : 가장 높은 백그라운드 스레드 우선순위. UI 동작이 이어지기 위해 제일. 
시스템에게 모든 시피유를 쓰게 만듬
2. user initiated: UI 만큼의 우선순위는 아니나, 유저가 실행하려고 동작한 작업을 의미함. 예를 들어 불러오기 버튼같은 걸 누르면 먼저 실행되어야한다
3. Utility queue: 유저가 인지하고 있는 오래 실행되는 작업에 쓰여야 한다. 그러나 당장 필요로 하지않는 작업이여야 한다.
4. background queue: 유저가 인지하지 못하는 한참 걸리는 작업

```swift
DispathchQueue.global(qoas: .userInitiated).async { ... }

DispatchQueue.global(qos: .userInitiated).async {
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            self.parse(json: data)
            return
        }
    }
}

showError()
```
- async() 는 클로저를 쓰기 때문에 `[weak self] in` 을 써서 강한 참조순환의 문제를 풀어야 할 것ㄱ ㅏㅌ지만
- GCD 는 코드를 실행한 뒤 throw해버리기 때문에 괜찮다고 한다
- async() 는 클로져를 쓰기 때문에 내부의 코드는 self prefix를 붙여야 한다



## DispatchQueue.main
- 위 코드의 문제점들이 몇개 생겨버렸다.
- showError() 는 클로저 내 return 문이 있더라도 반드시 호출된다
- 왜냐면 비동기로 실행되는 함수 내에서 return을 해봤자 전체 메서드는 다음라인이 실행되므로
- JSON 을 받아온 뒤 실행되는 tableView의 reloadData는 background thread에서 실행된다
- `UI 작업은 background Thread에선 절대 실행해서는 안된다`
- 메인스레드인 `DispatchQueue.main`에서 작업한다.

```swift
DispatchQueue.main.async { [weak self] in
  if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            self.parse(json: data)
            return
        }
  }
  self?.showError()
// show error 내에서는 UIAlertController 생성하므로. 백그라운드에서 실행해선 안된다

func showError() {
    DispatchQueue.main.async { [weak self] in
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
}

}
```

- closure 안에 있는 메서드들에 대해서는 self 키워드를 추가
- showError() 는 UI 작업을 하는 메서드이므로 실행시 메인스레드에 작업을 푸쉬 시킨다


## performSelector(inBackground:)
- GCD 쓰는 다른 방법: performSelector()
- 2개 변수 가짐
- performSelector(inBackground:) and performSelector(onMainThread:).
- 동일하게 동작하고 메서드를 넘겨주면 됨
- 하나는 백그라운드고 하나는 메인스레드에서 동작하게 됨
- 근데 내가 그걸 정리할 필요는 없고 GCD가 알아서 해줌

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    performSelector(inBackground: #selector(fetchJSON), with: nil)
}

@objc func fetchJSON() {
    let urlString: String

    if navigationController?.tabBarItem.tag == 0 {
        urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    } else {
        urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
    }

    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            parse(json: data)
            return
        }
    }

    performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
}

func parse(json: Data) {
    let decoder = JSONDecoder()

    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
        petitions = jsonPetitions.results
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
}

@objc func showError() {
    let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}
```
- selector 를 쓰므로 @objc 를 메소드에 붙여야한다
- fetchJSON 으로 메소드 리팩터링
- 이전 섹션 코드보다 훨씬 깔끔
- return문도 의도대로 동작하게 됨

```swift
if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
    petitions = jsonPetitions.results
    tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
} else {
    performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
}
```
- showError 도 else문을 활용해 머리 덜아프게 작성 가능
- 이걸 제일 쉽게 이해하는 방법으로 깅사도 제시하고 있음

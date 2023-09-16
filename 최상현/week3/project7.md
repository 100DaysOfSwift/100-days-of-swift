## UITabBarController

- view controller 들의 배열을 관리
- 유저가 view를 고를 수 있음

## Parsing JSON using the Codable protocol
- JSON 데이터를 처리할 수 있는 프로토콜을 Codable이라 한다
- 아래의 petition json data 를 struct로 담아낼 수 있다
```json
{
    "metadata":{
        "responseInfo":{
            "status":200,
            "developerMessage":"OK",
        }
    },
    "results":[
        {
            "title":"Legal immigrants should get freedom before undocumented immigrants – moral, just and fair",
            "body":"I am petitioning President Trump's Administration to take a humane view of the plight of legal immigrants. Specifically, legal immigrants in Employment Based (EB) category. I believe, such immigrants were short changed in the recently announced reforms via Executive Action (EA), which was otherwise long due and a welcome announcement.",
            "issues":[
                {
                    "id":"28",
                    "name":"Human Rights"
                },
                {
                    "id":"29",
                    "name":"Immigration"
                }
            ],
            "signatureThreshold":100000,
            "signatureCount":267,
            "signaturesNeeded":99733,
        },
        {
            "title":"National database for police shootings.",
            "body":"There is no reliable national data on how many people are shot by police officers each year. In signing this petition, I am urging the President to bring an end to this absence of visibility by creating a federally controlled, publicly accessible database of officer-involved shootings.",
            "issues":[
                {
                    "id":"28",
                    "name":"Human Rights"
                }
            ],
            "signatureThreshold":100000,
            "signatureCount":17453,
            "signaturesNeeded":82547,
        }
    ]
}

```

```swift

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

struct Petitions: Codable {
    var results: [Petition]
}
```

- `results: [...]` 를 받아내야 하므로. Petitions 를 선언하고 results 라는 key 이름을 프로퍼티 명으로 한다

```swift
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            parse(json: data)
            return
        }
    }
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
```

- Data 오브젝트를 생성하고 JSONDecoder 를 통해 파싱

## Rendering a petition: loadHTMLString

- 대부분의 복잡한 content lendering 은 WKWebView 를 쓴다. (import WebKit)

```swift
import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }
}
```

- guard let 써서 unwrap 할때 동일 이름으로 매핑하는게 일반적
- HTML 문자열을 생성하고 loadHTMLString으로 넘긴다
- viewController 에서 쓰기 위해서는 table view controller 에 `didSelectRowAt` 메서드를 구현해야 한다
- 이전에는 Main storyboard 에서 view controller 를 load 하려고 `instantiateViewController` 를 썼지만
여기서는 스토리보드에 DetailViewController 가 없어서 UI가 아니라 코드레벨로 로딩이 가능하다

```swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.detailItem = petitions[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
}
```

- 앞서 만든 HTML view에 detailItem property를 petitions[row] 로 설정해서 navigationController 의 stack에 push한다



## Finishing touches: didFinishLaunchingWithOptions
- 스토리보드에 2번째 탭을 넣을 수 없다. 왜냐면 둘다 ViewController를 호스팅하니까.
  스토리보드에 2개의 똑같은 view controller를 넣어야하는데, 이렇게하면 재앙이 펼쳐짐
  대신에 code를 이용한 2번쨰 view controller를 만든다. 좀 어려움.

```swift
if let tabBarController = window?.rootViewController as? UITabBarController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
    vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
    tabBarController.viewControllers?.append(vc)
}
```
- root 뷰컨트롤러는 UITabBarController 다.
- as 는 upcasting downcasting. as?는 조건절 다운캐스팅에 해당함.
- Main.storyboard 를 code로 불러내, instantiateViewController() 를 통해 vc를 만들고 withIdentifier를 통해
보내길 원하는 storyboard ID 를 넣는다.
- UITabBarItem을 만들고 Top rated Icon을 주입한뒤, tag1 로 하는데 이는 지금 중요하다
- 새로운 view controller 를 tab bar controller 의 viewControllers 에 추가했다. 이제 tab bar에 나올거다
- tag 는 tabBarItem.tag 를 통해 지금의 viewController 가 어떤 탭을 로딩했는지를 식별할 수 있음

```swift
let urlString: String

if navigationController?.tabBarItem.tag == 0 {
    // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
} else {
    // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
    urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
}
```


## error 처리

```swift
if let url = URL(string: urlString) {
    if let data = try? Data(contentsOf: url) {
        parse(json: data)
        return
    }
}

showError()
	func showError() {
		let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "OK", style: .default))
		present(ac, animated: true)
	}
```


## 배운 것들
- Nav controller 는 tab bar controller 안에 있어야한다
- 기본적인 table view cell은 label 이 있다
- storyboard 이름을 first param으로 제공하면 나머진 알아서 UIStoryboard가 해준다.
- AppDelegate 는 시스템 노티에 대한 반응을 구현한다
- Codable 을 구현할땐 JSON 의 필드 이름과 property명을 일치시켜야 한다
- Storyboard id 는 코드레벨로 story board view controller를 구현할 수 있게 해준다
- ~UITabBarController는 view controller 여러개를 저장할 수 있고 유저가 선택할 수 있게 해준다~
- APPLE 은 UITabBarItem type 여러개를 기본적으로 제공한다. (ex. .favorites, .search, .downloads, .contacts, .bookmarks)
- UILabel 의 텍스트는 기본적으로 세로로 가운데 정렬 (centered vertically)
- multi line 문자열은 quote 3개로 시작
- UITabBarItem 의 tag는 integer다
- Data type은 모든 binary data (string, zip, img) 를 수용가능하다
- ios app 은 root view controller가 필수이다

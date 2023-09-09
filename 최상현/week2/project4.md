
# web browser app

- UIBarButtonItem
- UIAlertController
- ..

## Creationg a simple browser with WKWebView

```swift

import UIKit

//NEW !!
//  web views
import WebKit


class ViewController: UIViewController, WKNavigationDelegate {
    // parent class 가 먼저 오고, protocol 이 다음에 추가되어야 한다!
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
//        delegation. Delegation is what's called a programming pattern – a way of writing code – and it's used extensively in iOS. And for good reason: it's easy to understand, easy to use, and extremely flexible.
        webView.navigationDelegate = self

        // delegate: 위임, 대리인. 이벤트에 반응하게 함
        // 프로토콜에 순응(conform)
        // when any web page navigation happens, please tell me – the current view controller.
        // WKWebview 의 모든 행동에 대한 통제권을 delegate를 통해 얻을 수 있다.
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.naver.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}

```

## UIAlertController action sheets
- `navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
```swift

@objc func openTapped() {
        let ac = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet)
        // 다양한 옵션 제공을 위해 actionSheet 스타일을 사용 
    
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "google.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        // 액션들을 추가
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
        
    }
    
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else {return}
//        let url = URL(string: "https://" + action.title!)!
        
        webView.load(URLRequest(url: url))
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // WKNavigationDelegate에 의해 메서드 구현 및 사용가능해짐
        title = webView.title
    }

```

<img width="389" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/eb2f2e08-d93d-453a-b780-c53bf3937a71">


## monitoring page loads

- UIToolbar
- UIProgressView
- KVO (Key Value Observer)

```swift
class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // UIView subclass 를 UIToolbar 에 쓸 수 있는건 아니다.
        // UTBarButtonItem 으로 wrap해서 써야 한다.
        // WKWebView는 estimatedProgress 속성으로 우리에게 얼마나 페이지가 로딩되었나 알려주지만, WKNavigationDelegate는
        // 이 값이 변할떄를 알려주지 않아서 우리가 iOS에 물어봐야한다. KVO 를 통해서.
        progressView = UIProgressView(progressViewStyle: UIProgressView.Style.default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton, spacer, refresh]
        // flexibleSpace 와 reload 기능 2개를 가진 array 초기화 후, toolbar 를 보이도록 함
        navigationController?.isToolbarHidden = false
        
        // WKWebView 의 estimatedProgress 를 옵저빙하겠다
        // 우리가 원하는 값. 지금은 새 값을 원함

        // forKeyPath 는 #selector 처럼 컴파일러에게 code가 맞는지를 체크하도록 함
        // 복잡한 환경에선 removeObserver() 는 쌍으로 구현되어야 함  
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

        
        let url = URL(string: "https://www.naver.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    
    // 옵저버를 KVO와 함께 쓰기위한 필수 구현 메서드
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}


```

<img width="381" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/092a3204-761c-411b-ba4b-2655bad9402b">


## refactoring for the win

### 문제

- 페이지를 우리가 만든 액션을 통해 들어가면, 거기 안에선 아무 링크로나 연결될 수 있다
- 해결법: WKNavigationDelegate 에서 decisionHandler closure 를 호출해서, 허용 여부를 제어!

```swift
      
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // WKNavigationDelegate 에 있는 메서드를 사용
        // 페이지를 열지 말지 정책을 결정
        // decisionHandler closure
        let url = navigationAction.request.url
        
        if let host = url?.host {
            // url 의 host가 있다면 아래를 실행하므로 안전한 코드.
            // 모든 url이 호스트를 가지고 있진 않기 때문.
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        decisionHandler(WKNavigationActionPolicy.cancel)
        
    }
```

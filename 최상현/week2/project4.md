
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


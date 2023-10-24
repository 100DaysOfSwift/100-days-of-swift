# javascript injection
- safari extension 개발

- 주황색 선의 의미: constraint와 너의 view가 매칭되지않는다
- 실선은 view가 있는곳, 점선은 코드가 동작하면 view가 위치할 곳이다
- 라벨은 디폴트 크기가 있기때문에 발생하는 차이
- 만약 너무 작게만들면 Resolve Auto Layout Issues > Update Frames로 해결 가능

- <img width="176" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/ca7e4c46-be49-4d38-941c-12af936d70ee">

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
        if let itemProvider = inputItem.attachments?.first {
            itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                // do stuff!
            }
        }
    }
}
```
- extenstion 만들어지면, parent app 과 어떻게 상호작용할지 extensionContext가 소통
- inputItems: parent app 의 data array
- first item만 신경써보기로 한다. 첫번째 attachment를 NSItemProvider 로 wrap
- closure기 때문에 async 동작
- closure내에서 [weak self] 를 통해 강한 참조를 피하고 dict는 애플이 제공하는 많은 데이터를 의미

- info.plist 에 NSExtension key 존재

### info.plist

<img width="660" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/4f5b6a82-9d99-4553-ae32-317569aff94d">
- String -> Dictionary
- NSExtensionActivationSupportsWebPageWithMaxCount : String value 1 을 추가
- 의미: 우리는 오로지 웹페이지만 받겠다
- NSExtensionJavaScriptPreprocessingFile : String value "Action"추가
- extension이 실행되면 Javascript 전처리 파일 Action.js 를 호출한다. 
<img width="466" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/00e6c7c4-0de7-4fb1-a8b9-dbbb2eab3f51">

```javascript
var Action = function() {};

Action.prototype = {

run: function(parameters) {

},

finalize: function(parameters) {

}

};

var ExtensionPreprocessingJS = new Action
```
- 위는 Apple이 지정한 js 양식이므로 수정을 하더라도 두 메서드를 없애지는 말아야 의도대로 동작
<img width="592" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/5bdeb4d0-88a6-447c-a3e0-e69ffba6ae62">

```javascript
run: function(parameters) {
    parameters.completionFunction({"URL": document.URL, "title": document.title });
},
```
- 2개의 데이터를 가져오도록 run() 수정
- 이제 두 데이터를 swift에서 받아볼 수 있을 것이다.

```swift
guard let itemDictionary = dict as? NSDictionary else { return }
guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
print(javaScriptValues)
```

- safari 를 host app 으로 설정한다 (choose an app to run)
- 공유하기 버튼 누른다음에 찾아보면 Extension이 존재
- NSDictionary는 담겨져있는 값의 데이터 타입을 몰라도 되서 좀 지저분
- 장단점이 될 수 있지만, 익스텐션에서는 장점이 된다
- js로부터 가져온 dictionary data 는 NSExtensionJavaScriptPreprocessingResultsKey 라는 이름의 키로 저장된다
- 그 값을 가져오면, NSDictionary 로 형변환한다



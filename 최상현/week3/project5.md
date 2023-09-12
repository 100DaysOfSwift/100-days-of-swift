# capture list

- 클로저의 파라미터 리스트 앞에 나타난다
- environment에서 strong,weak, unowned value를 캡처한다
- 강한 참조 사이클을 피하기 위해 많이 쓴다


## strong capture

```swift
func sing() -> () -> Void {
    let taylor = Singer()

    let singing = {
        taylor.playSong()
        return
    }

    return singing
}
```

- 일반적으로 taylor 는 함수 종료와 함께 사라질 것 같지만 계속 swift는 살아있게 한다.
- closure가 다른곳에 있다면 말이다

## weak capturing

```swift
func sing() -> () -> Void {
    let taylor = Singer()

    let singing = { [weak taylor] in
        taylor?.playSong()
        return
    }

    return singing
}
```
1. closure 내에 계쏙 살아있지 않고 nil이 된다
2. 1의 결과로 언제나 captured value는 optional 이다
3. `[weak taylor]` 가 capture list다

## unowned capturing

```swift
func sing() -> () -> Void {
    let taylor = Singer()

    let singing = { [unowned taylor] in
        taylor.playSong()
        return
    }

    return singing
}
```
- weak의 대체재다. unwrapped optional처럼 행동한다.
- 나중에 어떤 지점에서든 nil이 되게 허용
- 하지만 마치 value가 있는것처럼 우리는 취급할 수 있다
- closure 생명주기 내내 값이 존재할 거라고 확신할 때 쓴다

## 파라미터와 같이 쓰는법

```swift
writeToLog { [weak self] user, message in 
    self?.addToLog("\(user) triggered event: \(message)")
}
```
- capture list 이후 in

## Strong reference cycles
- A가 B를 가지고 있고 B가 A를 가지고 있으면 retain cycle 혹은 제목처럼 얘기한다

```swift
class House {
    var ownerDetails: (() -> Void)?

    func printDetails() {
        print("This is a great house.")
    }

    deinit {
        print("I'm being demolished!")
    }
}

class Owner {
    var houseDetails: (() -> Void)?

    func printDetails() {
        print("I own a house.")
    }

    deinit {
        print("I'm dying!")
    }
}

print("Creating a house and an owner")

do {
    let house = House()
    let owner = Owner()
    house.ownerDetails = owner.printDetails
    owner.houseDetails = house.printDetails
}

print("Done")


print("Creating a house and an owner")

do {
    let house = House()
    let owner = Owner()
    house.ownerDetails = { [weak owner] in owner?.printDetails() }
    owner.houseDetails = { [weak house] in house?.printDetails() }
}

print("Done")
```
- 최소 둘 중 하나는 weak capture 해야한다


## 잘못된 사용법

- `[unowned taylor, adele]` -> `[unowned taylor, unowned adele]` 이어야한다

## closure copy
```swift
var numberOfLinesLogged = 0

let logger1 = {
    numberOfLinesLogged += 1
    print("Lines logged: \(numberOfLinesLogged)")
}

logger1()
let logger2 = logger1
logger2()
logger1()
logger2()
```
- 각 클로저의 변수 numberOfLinesLogged 는 공유된다

## 써야할 때
- unowned : captured value 가 클로저가 호출되는동안 절대 사라지지않는다고 확신할 때
- weak : strong ref cycle 이 존재할 때는 순환 사이클 중 1개는 weak 이어야 한다
- strong : cycle 이 발생하지 않는다고 확신할 때


# project 5.

## ~index path

```swift
import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add
                                                            , target: self, action: #selector(promptForAnswer))
        
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                //                try? : code call. error가 나면 대신 nil을 달라
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
        // ReloadData() : cellForRowAt와 numberOfRowsInSection 를 다시 부름
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    @objc func promptForAnswer() {
        // UIBarButtonItem에서 쓰여야하므로 @objc
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        
        // text input field를 알럿에 추가
        ac.addTextField()

        
        // 버튼에 대한 액션을 등록
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    
                    // indexpath : top of page view
                    // insertRows() 를 하면 reloadData() 를 하지않아도 table에 새로운 row가
                    // 추가되는 것을 애니메이션으로 보여줄 수 있다.
                    tableView.insertRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
    
    func isPossible(word: String) -> Bool {
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return true
    }
    
    func isReal(word: String) -> Bool {
        return true
    }
}

```
## validation 구현

```swift
func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }

        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                // tempWord 에 있다면 tempWord에서 제거함
                tempWord.remove(at: position)
            } else {
                // 없으면 불가능
                return false
            }
        }

        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        // UITextChecker : UIKit에 있는 문법 검사기. 실제 단어인지를 확인 가능
        let checker = UITextChecker()
        // string range를 저장하는 구조체
        let range = NSRange(location: 0, length: word.utf16.count)
        // 1st param: 검사 단어 2nd: 스캔범위, 마지막: 언어
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        // 리턴값도 NSRange 이며, misspelling 의 위치를 가지고 있음
        // 따라서, NSNotFound 는 단어 자체가 valid함을 의미함.
        return misspelledRange.location == NSNotFound
    }
```

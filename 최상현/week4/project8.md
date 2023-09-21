# building a UIkit UI programmatically

- UITextField
- UIView


## code 로 UI 만들기

```swift
var cluesLabel: UILabel!
var answersLabel: UILabel!
var currentAnswer: UITextField!
var scoreLabel: UILabel!
var letterButtons = [UIButton]()
```

- UIView는 레이블, 단추, 진행률 보기 등 UIKit의 모든 보기 유형의 상위 클래스입니다. 이전에는 WK웹뷰 인스턴스를 우리 뷰로 직접 할당했는데, 
- 이는 WK웹뷰 인스턴스가 모든 공간을 자동으로 차지한다는 것을 의미합니다. 하지만 여기서는 child view를 많이 추가하고 손으로 위치를 지정하기 때문에 작업할 크고 빈 캔버스가 필요합니다.


- NSLayoutConstraint.activate(equalTo: []) : 많은 제약조건의 array를 가지고 있음. 한번에 constraint 적용 가능

```swift
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.numberOfLines = 0
        view.addSubview(cluesLabel)
```
- font, numberOfLines 같은 추가 property 를 쓰는걸 볼 수 있다
- numberOfLine 은 test line 몇줄을 가지고 있을지를 설정. 0 = as many lines as it takes를 의미


## 이대로는 아이패드로 화면을 볼 때 깔끔하지가 않다 (Anchor)
- 12.9 인치 아이패드 미니 기준으로, anchor 들을 추가한다
- width: 0.4 -> 40% of screen 크기를 의미

```swift
// pin the top of the clues label to the bottom of the score label
cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),

// pin the leading edge of the clues label to the leading edge of our layout margins, adding 100 for some space
cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),

// make the clues label 60% of the width of our layout margins, minus 100
cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),

// also pin the top of the answers label to the bottom of the score label
answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),

// make the answers label stick to the trailing edge of our layout margins, minus 100
answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),

// make the answers label take up 40% of the available space, minus 100
answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),

// make the answers label match the height of the clues label
answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
```


## UITextField 를 추가
```swift
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "letter를 누르세요"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 48)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
```

- currentAnswer.isUserInteractionEnabled = false를 통해 text field 입력을 방지할 수 있음

## UIButton 2개를 추가

```swift
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("제출", for: .normal)
        view.addSubview(submit)
```

## 20개의 단어 버튼 만들기
- code로 UI를 구성하는건 장황해보이지만 나중에 많은 도움이 된다고 함
- container view 로 감싸내어 이런 복잡한 레이아웃을 처리하자
- 모든 버튼을 가지는 plain UIView 선언

### layout UIKit properties

- Content hugging priority : determines how likely this view is to be made larger than its intrinsic content size. If this priority is high it means Auto Layout prefers not to stretch it; if it’s low, it will be more likely to be stretched.
- Content compression resistance priority : determines how happy we are for this view to be made smaller than its intrinsic content size.
```swift
cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
```

- 버튼 세팅을 위해 CGRect 의 x,y 좌표계를 활용
```swift
let width = 150
let height = 80

// create 20 buttons as a 4x5 grid
for row in 0..<4 {
    for col in 0..<5 {
        // create a new button and give it a big font size
        let letterButton = UIButton(type: .system)
        letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)

        // give the button some temporary text so we can see it on-screen
        letterButton.setTitle("WWW", for: .normal)

        // calculate the frame of this button using its column and row
        let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
        letterButton.frame = frame

        // add it to the buttons view
        buttonsView.addSubview(letterButton)

        // and also to our letterButtons array
        letterButtons.append(letterButton)
    }
}
```


## submit clear button 기능 구현
```swift
    @objc func letterTapped(_ sender: UIButton) {
    }

    @objc func submitTapped(_ sender: UIButton) {
    }

    @objc func clearTapped(_ sender: UIButton) {
    }
    override func loadView() {
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("제출", for: .normal)
        
        // press down button? call submitTapped function on current controller
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
        view.addSubview(submit)
    }
```
## letter button 에 데이터 매핑하는 기능 구현
- level1,2.txt 파일을 가져오고, \n로 라인을 구분
- 라인 별로 enumerated() 를 통해 array index와 value를 가져옴
- replacingOccurrences(of: "|", with: "") 는 of를 with으로 변경하여 srtring 리턴
- components(separatedBy:) 통해 HA|UNT|ED 를 ha,unt,ed 로 분리하여 letterBits에 담는다
```swift
func loadLevel() {
    var clueString = ""
    var solutionString = ""
    var letterBits = [String]()

    if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
        if let levelContents = try? String(contentsOf: levelFileURL) {
            var lines = levelContents.components(separatedBy: "\n")
            lines.shuffle()

            for (index, line) in lines.enumerated() {
                let parts = line.components(separatedBy: ": ")
                let answer = parts[0]
                let clue = parts[1]

                clueString += "\(index + 1). \(clue)\n"

                let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                solutionString += "\(solutionWord.count) letters\n"
                solutions.append(solutionWord)

                let bits = answer.components(separatedBy: "|")
                letterBits += bits
            }
        }
    }

    cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
    answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
    letterBits.shuffle()
        
    if letterBits.count == letterButtons.count {
      for i in 0 ..< letterButtons.count {
             letterButtons[i].setTitle(letterBits[i], for: .normal)
      }
    }
}
```


## firstIndex and joined


## property observer

- `score` 0에서 계속 정답 찾으면 올라가는 변수
- ` scoreLabel.text = "Score: \(score)"`
- props 가 바뀔 떄 실행할 코드를 property observer 라 한다
- `didSet` 과 `willSet`

```swift
var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}
```


## wrap up

### addTarget()
- UIButton UISlider 등에 동작을 매핑. 특정 컨트롤에 의한 타겟 오브젝트와 액션을 지정
- method는 objc 로 지정
```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .system)
        button.setTitle("Tap me", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        view.addSubview(button)

        // Set button constraints or frame here
    }

    @objc func buttonTapped() {
        print("Button tapped!")
        // Handle the button tap event here
    }
}
```

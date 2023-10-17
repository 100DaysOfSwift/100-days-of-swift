# animation
- ios에서 제일 중요한 테크닉
- ios는 멋진 애니메이션을 많이 지원함


# 준비

<img width="784" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/148272c2-bcd4-4a5c-ac4c-093d9184b422">

- auto layout
- Tap 이라 이름지운 Button 을 View에 우클릭드래그 해서 horizontally center in safe area & bottom space to safe area

- 2개 프로퍼티를 IBAction에 필요로한다
- imageView, currentAnimation = 0
- viewDidLoad 에서 UIImage를 만들 계획

```swift
class ViewController: UIViewController {
    
    var imageView: UIImageView!
    var currentAnimation = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
    }
    
    @IBAction func Tapped(_ sender: Any) {
        currentAnimation += 1
        if  currentAnimation > 7 {
            currentAnimation = 0
        }
    }
    
}
```

# animate
- 2개의 클로져가 사용되어 혼란스러웠음
```swift
@IBAction func tapped(_ sender: UIButton) {
    sender.isHidden = true

    UIView.animate(withDuration: 1, delay: 0, options: [],
       animations: {
        switch self.currentAnimation {
        case 0:
            break

        default:
            break
        }
    }) { finished in
        sender.isHidden = false
    }

    currentAnimation += 1

    if currentAnimation > 7 {
        currentAnimation = 0
    }
}
```

- switch/case 는 2개 클로져를 받아들임. 파라미터는 아래와 같음
- duration 은 얼마나 애니메이션이 지속될지, 그다음은 애니메이션시작전 멈출지, option 그다음 어떤 애니메이션을 실행할 지, 그리고 마지막으로 애니메이션이
끝나면 실행할 클로져로 구성
- 아직 스위치문은 하는게 브레이크말곤 없다

# transform

```swift
 case 0:
                self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                break
            case 1:
                self.imageView.transform = .identity
            case 2:
                self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
            case 3:
                self.imageView.transform = .identity
            case 4:
                self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            case 5:
                self.imageView.transform = .identity
                
            case 6:
                self.imageView.alpha = 0.1
                self.imageView.backgroundColor = UIColor.green
                
            case 7:
                self.imageView.alpha = 1
                self.imageView.backgroundColor = UIColor.clear
```

- 2배로 커진다
- case 1 은 리셋: `self.imageView.transform = .identity`
- case 2 는 `self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)` 왼쪽위로 이동
- case 4는 pi 만큼 회전
- 6은 투명도 0.1과 배경색

- 마지막으로 `UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],`
- 스프링처럼 탄성을 더한다

# wrap up
- center property가 view 중앙을 컨트롤
- isHidden과 alpha는 서로 다름. 앞에껀 Boolean. 뒤에껀 CGFloat임
- 360e도 회면을 만들면, view가 완전한 원으로 돌것이다? 아니다. Core animation은 최소의 움직임으로 계산하기때문에 아무일도 안일어남
- X:0.5, Y:0.5는 50%로 스케일을 줄인다
- sender param은 메서드를 trigger한 UIKit 컨트롤이 할당됨
- negative Y 값은 UIKit에서는 스크린 위로 이동시킨다
- trailing closure 문법은 마지막 파라미터에 나타난 클로저에만 적용 기능
- identity transform 은 적용된 view size, 위치, 회전을 default로 리셋시킴

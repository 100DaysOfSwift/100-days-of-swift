## project2 ViewController

```swift
func askQuestion(action: UIAlertAction! = nil) {
		countries.shuffle()

//        UIImage 를 button 에 할당
//        for: .normal button의 standard 상태를 의미..
//        UIControlState 의 struct static property 임
		button1.setImage(UIImage(named: countries[0]), for: .normal)
		button2.setImage(UIImage(named: countries[1]), for: .normal)
		button3.setImage(UIImage(named: countries[2]), for: .normal)

        correctAnswer = Int.random(in: 0...2)
		title = countries[correctAnswer].uppercased()
	}

```

## CALayer

- CALayer, which is a Core Animation data type responsible for managing the way your view looks.
- `button3.layer.borderWidth = 1` CALayer의 border 가 생기게 되어 사진과 배경이 동일한 색이어도 구분가능
- CALayer 는 UIButton 보다 하위 이므로 UIBUtton의 UIColor를 알 수 없음. CGColor 를 써야함
- `button1.layer.borderColor = UIColor.lightGray.cgColor`
- `button3.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor`



## 랜덤 정수
- `Int.random(in: 0..2)`


## Action

- button 우클릭 후 보면 TOuch up inside -> VIewController.buttonTapped 에 매핑되는걸 볼 수 있음
- IBAction function에 연동
<img width="854" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/a32b698e-9a8c-41d9-897a-54f02cc02c0a">

## 새로운 Alert 을 띄우는 법
```swift

		let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
		present(ac, animated: true)
```
- handler: askQuestion 는 클로저
- `func askQuestion()` -> `func askQuestion(action: UIAlertAction!)` 로 변경
- 이러면 `askQuestion()` 이 missing argument 가 뜨기 때문에,`func askQuestion(action: UIAlertAction! = nil)` 로 세팅해야함



## Quiz

1. @2x, @3x 는 ios 가 레티나 디스플레이를 사용하게 되면서, 모든 이미지가 모든 해상도에서 적합하게 예쁘게 출력되도록 정해놓은 포맷이다
2. UIColor 에서 rgb는 1.0 이상 가능하다 (ios 기능이고 매우 딥한 컬러를 보여준다는데 잘 모르겠음 아직)
3. Tag는 정수다
4. 하나의 action에 여러 버튼이 바인딩할 수 있다
5. Auto layout constraint 는 다른 view가 다른 view에 바인딩할 수 있다
6. 스위프트 모든 numeric 타입에는 .random이 있다
7. Tag로 view 를 유니크하게 식별 할 수 있다
8. App thinning 은 필요없는 asset을 앱 설치시 설치안해도 되도록 한다
9. 2 or 3 point = 1 pixel 이다
10. Alpha 는 투명도를 나타낸다
<img width="597" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/6d31a011-37b2-4b75-b706-777aca61585f">

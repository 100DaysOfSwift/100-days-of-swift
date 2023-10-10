# core image
- iOS에서 가장 발전된 프레임워크 중 하나
- Apple's high-speed image manipulation toolkit.



# UISlider

- 프로젝트10의 반대를 구현해 보자

- storyboardview controller선택
- Editor -> embed in -> navigation controller

<img width="855" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/b2ae4833-61c4-4f0a-b4f7-8d98f7c77e9a">

- 이상적인 constraint 를 적용

- constraint를 수정하려면 size inspector의 constraint를 클릭해 조절 가능
<img width="653" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/9d49cacb-f02c-4c2c-b393-0e81b23e9109">


## editing image
- UIImagePickerController 를 쓰려면, 아래처럼 protocol을 추가해야한다
```swift
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
```

- info.plist에서 'ADD ROW' 를 이용해 privacy - photo library addtion 이용 메시지를 추가

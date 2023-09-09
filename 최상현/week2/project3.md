## UIActivityViewController

- UIBarButtonItme 을 생성
- UIActivityViewController 를 생성
- `@objc`에 대해 학습
- Privacy 에 대해 학습

```swift
import UIKit

class DetailViewController: UIViewController {
	@IBOutlet var imageView: UIImageView!
	var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

		title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
        // tap하면 유저가 뭘 할 수 있는지 시그널링
        // target action 은 조합된다. 무슨 메서드가 호출될지
        // action은 클릭 시 shareTapped() 를 호출한다고 말한다
        // target 은 지금의 viecontroller에 action이 속한다고 버튼에게 말해준다
        // #selector : swift compiler 에게 해당 메서드가 존재한다고 알린다
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

		if let imageToLoad = selectedImage {
			imageView.image  = UIImage(named: imageToLoad)
		}
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    // swift에게 해당 메서드가 objective-C 에서 이용된다고 알려줌
    // 상단의 UIBarButtonItem 은 Objective-C 운영체제 안에서 호출되기 떄문
    // @IBAction 도 @objc 를 포함
    
	@objc func shareTapped() {
		let vc = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: [])
		vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		present(vc, animated: true)
	}
}

```


## Privacy

<img width="423" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/0a0e1834-efcb-413c-8467-e6e912cb457d">

- 우측의 save to images 할 경우, 사진 앱에 대한 접근 권한이 부여되지 않으면 버그 발생
- 이를 해결하기 위해 프로젝트 내 Info.plist 에서 설정을 변경할 필요가 있음
- 공백 우클릭시 `Add row` 가능
- `Privacy - Photo Library Additions Usage Description` 을 추가
-  value에는 사진앱 허용 요청에 대한 안내 메시지를 작성




# UICollectionView and UICollectionViewCell

1. cell subview 을 위한 outlet 구현을 위해 custom class 사용
- interface builder 나 코드로 view 만들 때 쓴다
- custom cell class 를 구현해서 (name과 image를 가진 personCell: UICollectionViewCell)
- `@IBOutlet` 을 연결해 Xcode 에게 어떻게 코드와 cell view를 연결시킬지 안내

2. UICollectionView 는 grid cell 표현하기 위해 좋은 클래스

3. `UIImagePickerController` 를 사용해 유저 이미지를 고르고 dict 타입 데이터를 받을 수 있다
4. `URL.path` 는 위치를 표현한 String 타입 prop이다
5. closure 내 Capture list 는 여러개로 표현가능하다
- [weak self, weak ac, weak somethingElse] 등등..

6. 모든 ObjC 클래스는 `NSObject` 를 상속한다.
- 그래서 cocoa custom class 도 위를 상속
- 모든 코코아 터치 클래스의 베이스 클래스
- 이걸 상속해야만 쓸수있는 기능이 있다.

7. UIKit은 collection view cell 을 재활용한다.
8. `fatalError()` 는 앱을 아예 끝내버린다.
9. `Data` 는 어떤 bin data 든 담을 수 있다
- zip, JPED, string
10. 각 앱은 고유의 document directory를 갖는다.
- 여기서는 Filemanager를 통해 읽어온다
```swift
func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    //  userDomainMask ; for current user
        return paths[0]
    }
```

11. Collection view item은 row개념이 없고, section과 item으로 참조된다
12. custom collection view cell 을 deque하면, 우리가 정의한 타입으로 타입캐스팅해야한다
- UIKit은 UICollectionViewCell을 리턴하기 때문에 `as, as?` 를 써서 컨버팅필요


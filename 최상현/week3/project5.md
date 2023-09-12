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

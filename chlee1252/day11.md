# Day11

### Protocols

- Swift에서 프로토콜은 필수 프로퍼티와 메소드가 반드시 가지고 있어야할것을 명시하는 방법.
- 정의를 하고 제시를 할 뿐 스스로 기능 구현 X → 자바 interface..?
- 하나의 타입으로 사용될 수 있음.

```swift
protocol Identifiable {
    var id: String { get set }
}

struct User: Identifiable {
    var id: String
}

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}
```

### Protocol Inheritance

- 자바 interface와 동일하게 다중 상속을 받을 수 있음

```swift
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}
```

```swift
protocol Employee: Payable, NeedsTraining, HasVacation { }
```

### Extensions

- `extension` 키워드를 사용하면 이미 존재하는 타입에 method를 생성할 수 있게 해줌.

```swift
extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number = 8
number.squared()
```

- 프로퍼티는 extension 으로 변경할 수 없지만, 프로퍼티를 사용해서 computed는 가능함.

```swift
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}
```

### Protocol Extensions

- Extension은 하나의 타입에서만 활용가능한데, protocol extension을 사용하면 다중 타입에 extension을 줄 수 있다.
- Array와 Set은 Collection이라는 protocol을 가지고 있는데, Collection 프로토콜에 extension을 적용하면 Collection이라는 프로토콜을 가지고 있는 타입은 모두 extension에 정의된 메소드를 사용할 수 있다.

```swift
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

extension Collection {
    func summarize() {
        print("There are \(count) of us:")

        for name in self {
            print(name)
        }
    }
}

pythons.summarize()
beatles.summarize()
```

### Protocol Oriented Programming

- protocol과 extension을 적절히 활용하면, default 메소드들을 정의할 수 있다.
# Day8

### Creating your own structs

- Struct를 사용해서 Type을 만들 수 있다.

```swift
struct Sport {
    var name: String
}

// Constructor를 사용해서 value를 주입 하는 방식
var tennis = Sport(name: "Tennis")
print(tennis.name) // "Tenis"

// setter를 사용해서 value 주입
tennis.name = "Lawn tennis"

print(tennis.name) // "Lawn tennis"
```

### Computed Properties

- 특정 코드 및 로직을 통해 해당 property에 값을 지정해 준다.

```swift
struct Sport {
    var name: String
    var isOlympicSport: Bool

		// isOlympicSport 필드를 사용해 각각 다른 값을 주입.
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

let chessBoxing = Sport(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)

// Chessboxing is not an Olympic sport
```

### Property Observers

- 특정 프로퍼티가 새로운 값으로 변경될 때마다 로직을 수행해줄 수 있다.
    - 신규 생성될때는 안됨!
- `didSet`: 프로퍼티 값이 변경된 후 실행
- `willSet`: 프로퍼티 값이 변경되기 전 실행

```swift
struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100

// Loading data is now 30% complete
// Loading data is now 80% complete
// Loading data is now 100% complete
```

### Methods

- struct내 특정 로직을 수행할 수 있는 method도 정의 가능

```swift
struct City {
    var population: Int

    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
print(london.collectTaxes()) // 9000000000
```

### Mutating Methods

- Swift는 struct내 메소드가 특정 프로퍼티 값을 변경하는걸 금지하고, 메소드는 default 설정으로 mutating이 붙지 않는다.
- 하지만, `mutating` 키워드를 붙은 메소드에서만 가능하다.

```swift
struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()
print(person.name) // Anonymous
```

### Properties and methods of Strings

- Swift에서 사용하는 String 또한 내부적으로는 struct로 되어 있음.

```swift
let string = "Do or do not, there is no try."
```

- `count` : 프로퍼티

```swift
print(string.count)
```

- `hasPrefix()`

```swift
print(string.hasPrefix("Do")) // true
```

- `uppercased()`

```swift
print(string.uppercased())
```

- `sorted()`

```swift
print(string.sorted())
```

### Properties and methods of Arrays

```swift
var toys = ["Woody"]
```

- `count`: 프로퍼티

```swift
print(toys.count) // 1
```

- `append()`

```swift
toys.append("Buzz")
```

- `firstIndex(of:)` : 가장 처음 발견된 아이템 인덱스

```swift
toys.firstIndex(of: "Buzz")
```

- `sorted()`

```swift
print(toys.sorted())
```

- `remove(at:)`
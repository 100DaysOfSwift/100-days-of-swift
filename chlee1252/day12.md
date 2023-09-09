# Day12

### Handling Missing Data

- 나중에 변수에 데이터를 지정해주기 위해서 Optional type으로 `nil` 을 변수에 할당해주면 된다. 그러기 위해서는  `?` 키워드를 타입에 명시해주어야한다.

```swift
var age: Int? = nil
age = 38
```

### Unwrapping Optionals

- `if let` 을 사용해서 `nil` 타입을 확인하고, value가 변수에 있으면 그 변수를 사용하고 아니면 `else` 로직을 수행

```swift
var name: String? = nil

if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}
```

### Unwrapping with guard

- `if let` 대신 사용할 수 있는 다른 방법은 `guard let` 이다.
- `if let` 과 다른점은 unwrapped optional을 계속 사용할 수 있다.
- 아래와 같이 unwrapped string을 함수가 끝나기 전까지 재사용할 수 있다.

```swift
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return // 함수 종료
    }

    print("Hello, \(unwrapped)!")
}
```

### Force unwrapping

```swift
let str = "5"
let num = Int(str)
```

- 위와 같은 코드를 실행하게 되면 num은 str이 숫자가 아닌 경우를 대비하여 `Int?` 타입으로 옵셔널 타입으로 설정하게 되는데,

```swift
let num = Int(str)!
```

- 이런 식으로 `!` 를 붙이게 되면, num은 optional type이 아닌 `Int` 타입으로 설정되게 된다.
    - 만약 str 이 숫자로 컨버팅 되지 않는 값을 가지고 있으면 코드가 crash 한다.
    - 따라서 Force unwrapping은 항상 안전한 상황에서만 사용해야한다.

### Implicitly unwrapped Optionals

- `!` 를 타입 뒤에 명시해주게 되면, `if let` 과 `guard let` 을 사용하지 않아도 된다.
    - 해당 컨셉이 있는 이유는, age를 사용할때 value가 `nil` 이 아닌걸 알때 사용하게 되는데, 사용할때 마다 `if let` 을 사용하지 않게 하기 위해서 존재한다.

```swift
let age: Int! = nil
```

### Nil coalescing

- 할당되는 값이 `nil` 일때를 위해서 `??` 키워드를 사용해서 기본값을 설정할 수 있게 해준다.

```swift
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

let user = username(for: 15) ?? "Anonymous" // Anonymous
```

### Optional chaining

- `?.` 를 사용해서, 안전하게 함수를 사용할 수 있게 해준다.
- 만약 first가 `nil` 을 return 하게 되면, Swift를 `uppercased()` 를 수행하지 않게 된다.

```swift
let names = ["John", "Paul", "George", "Ringo"]
let beatle = names.first?.uppercased()
```

### Optional try

```swift
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}

try! checkPassword("sekrit")
print("OK!")
```

- `try?` 는 함수가 `nil` 을 리턴하게 되면 `else` 를 실행한다.
- `try!` 는 함수가 절대 `nil` 을 리턴하지 않을때 사용한다. 만약 `nil` 을 리턴되면, code는 crash 된다.

### Failable Initializers

- `struct` 에서 `init` (컨스터럭터) 로직이 실패되면 `nil`을 반환하게 된다.

```swift
struct Person {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
} 
```

### Typecasting

```swift
class Animal { }
class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}

let pets = [Fish(), Dog(), Fish(), Dog()]

for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}
```

- 위 로직을 실행하게 되면, dog 일때만 `makeNoise()` 함수를 실행해야하는데, Fish일때 code는 실패하게 된다.
- 그럴때를 대비해서 typecasting을 하는데 `as?` 를 사용해서 typecasting을 하게 되면 Fish 일때는 `nil` 을 return 하게 되니, 뒷 로직을 실행하지 않고 `Dog` 일때만 함수를 실행하게 된다.
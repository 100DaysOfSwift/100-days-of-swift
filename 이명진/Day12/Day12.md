# Day12

### 옵셔널 데이터

```swift
var age: Int? = nil

age = 38
```

### 옵셔널 언래핑

```swift
var name: String? = nil

if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}
```

### 옵셔널 언래핑(guard)

```swift
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }

    print("Hello, \(unwrapped)!")
}
```

### 강제 언래핑

```swift
let str = "5"
let num = Int(str)

let num = Int(str)!
```

### 암시적 옵셔널 언래핑

```swift
let age: Int! = nil
```

### Nil 병합 연산자

```swift
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

let user = username(for: 15) ?? "Anonymous"
```

### 옵셔널 체이닝

```swift
let names = ["John", "Paul", "George", "Ringo"]

let beatle = names.first?.uppercased()
```

### 옵셔널 try

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

### Failable 이니셜라이저

```swift
let str = "5"
let num = Int(str)

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


### 타입캐스팅

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
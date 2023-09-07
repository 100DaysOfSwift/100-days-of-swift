# Day10

### Creating your own classes

- class는 struct와 다르게 class에 프로퍼티가 있으면 initializer를 꼭 설정해주어야한다.

```swift
class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let poppy = Dog(name: "Poppy", breed: "Poodle")
```

### Class Inheritance

- struct와는 다르게 class는 다른 클래스에 상속할 수 있다.
- Swift에서는 class 상속을 받았을때, initializer에서 `super.init()` 을 꼭 호출해야한다.

```swift
class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}
```

### Override Methods

- 상속받은 class내 method를 `override` 키워드로 재정의할 수 있다.

```swift
class Dog {
    func makeNoise() {
        print("Woof!")
    }
}

class Poodle: Dog {
    override func makeNoise() {
        print("Yip!")
    }
}
```

### Final Classes

- `final` 키워드를 사용해서 class를 생성하게 된다면, 해당 클래스는 다른 클래스에서 상속해서 메소드나 프로퍼티를 재정의할 수 없다.

```swift
final class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
```

### Copying Objects

- struct는 복사를 하면, 해당 struct는 다른 struct로 복사가 된다.
    - 예를 들면, 하나의 struct에서 property를 변경하더라도 복사된 struct는 반영되지 않는다.
    - 하지만, class는 복사를 하더라도 메모리내 동일 class를 바라보고 있기 때문에 동일하게 적용된다.

```swift
class Singer {
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

var singerCopy = singer
singerCopy.name = "Justin Bieber"

print(singer.name) // Justin Bieber
```

### Deinitializers

- struct와 다르게 클래스가 메모리내에서 없어질때, 호출되는 `deinit` 이 존재한다.

```swift
class Person {
    var name = "John Doe"

    init() {
        print("\(name) is alive!")
    }

    func printGreeting() {
        print("Hello, I'm \(name)")
    }

		deinit {
		    print("\(name) is no more!")
		}
}

for _ in 1...3 {
    let person = Person() // alive!
    person.printGreeting() // Hello
    // is no more!
}
```

### Mutability

- struct는 그 자체로 constant이기 때문에 할당된 프로퍼티를 변경할 수 없다.
- 하지만 class는 `let` 으로 클래스를 할당하더라도, 내부에 있는 프로퍼티를 변경할 수 있다.

```swift
class Singer {
    var name = "Taylor Swift"
}

let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)
```

- 만약 변경할 수 없게 만들고 싶다면, class 내부에서 `let` 키워드로 프로퍼티를 생성한다.
# Day10

### 클래스

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

### 클래스 상속

```swift
class Poodle: Dog {

}

class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}
```

### 메서드 오버라이딩

```swift
class Dog {
    func makeNoise() {
        print("Woof!")
    }
}

class Poodle: Dog {
}

let poppy = Poodle()
poppy.makeNoise()

class Poodle: Dog {
    override func makeNoise() {
        print("Yip!")
    }
}
```

### Final 클래스

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

### 객체 복사

```swift
class Singer {
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

var singerCopy = singer
singerCopy.name = "Justin Bieber"

print(singer.name)

struct Singer {
    var name = "Taylor Swift"
}
```

### Deinitializers

```swift
class Person {
    var name = "John Doe"

    init() {
        print("\(name) is alive!")
    }

    func printGreeting() {
        print("Hello, I'm \(name)")
    }
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}

deinit {
    print("\(name) is no more!")
}
```

### mutability

```swift
class Singer {
    var name = "Taylor Swift"
}

let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)

class Singer {
    let name = "Taylor Swift"
}
```
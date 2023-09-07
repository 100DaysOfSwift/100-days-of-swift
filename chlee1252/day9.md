# Day9

### Initializers

- Constructor 처럼 Type을 struct로 만들때 사용함.
    - 모든 프로퍼티에 value를 넣어주어야함.

```swift
struct User {
    var username: String
    var something: String

    init() {
        username = "Anonymous"
				something = "Hello"
        print("Creating a new user!")
    }
}

var user = User()
user.username = "twostraws"
```

### Referring to the current instance

- `self` 키워드를 통해 struct내 프로퍼티에 접근 및 데이터를 할당할 수 있음.

```swift
struct Person {
    var name: String

    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}
```

### Lazy Properties

- `lazy` 키워드를 통해, 해당 프로퍼티가 access 될때 생성되게 할 수 있다.

```swift
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct Person {
    var name: String
    lazy var familyTree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}

var ed = Person(name: "Ed") // NOT PRINTING!
ed.familyTree // Creating family tree!
```

### Static Properties and Methods

- struct내 static 프로퍼티와 메소드를 생성할 수 있다.

```swift
struct Student {
    static var classSize = 0
    var name: String

    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

print(Student.classSize) // 0
```

### Access Control

- property access 설정을 해줄 수 있다.
    - private을 사용하면 struct내에서만 접근할 수 있게 할 수 있다.
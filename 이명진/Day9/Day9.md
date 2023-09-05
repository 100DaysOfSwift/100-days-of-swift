# Day9

### 이니셜라이저

```swift
struct User {
    var username: String
}
var user = User(username: "twostraws")

struct User {
    var username: String

    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}
var user = User()
user.username = "twostraws"
```

### 현재 인스턴스 참조

```swift
struct Person {
    var name: String

    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}
```

### lazy 프로퍼티

```swift
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct Person {
    var name: String
    var familyTree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}

var ed = Person(name: "Ed")

lazy var familyTree = FamilyTree()

ed.familyTree
```

### 정적 프로퍼티와 메서드

```swift
struct Student {
    var name: String

    init(name: String) {
        self.name = name
    }
}

let ed = Student(name: "Ed")
let taylor = Student(name: "Taylor")

struct Student {
    static var classSize = 0
    var name: String

    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

print(Student.classSize)
```

### 접근 제어

```swift
struct Person {
    var id: String

    init(id: String) {
        self.id = id
    }
}

let ed = Person(id: "12345")

struct Person {
    private var id: String

    init(id: String) {
        self.id = id
    }
}

struct Person {
    private var id: String

    init(id: String) {
        self.id = id
    }

    func identify() -> String {
        return "My social security number is \(id)"
    }
}
```
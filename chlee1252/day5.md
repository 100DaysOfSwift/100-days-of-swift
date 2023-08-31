# Day5

### Writing Functions

- func 키워드를 통해 메소드 생성

```swift
func printHelp() {
    let message = """
Welcome to MyApp!

Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""

    print(message)
}
```

### Accepting Parameters

- 파라미터를 받을 때는 변수 이름과 타입을 함께 명시함.
- 파라미터를 넘길때에는, 명시한 변수 이름을 사용함.
- Swift에서 기술적으로 가능한 최대 파라미터 갯수는 20개 - 하지만 파라미터는 최대한 하나로..

```swift
func square(number: Int) {
    print(number * number)
}

square(number: 8)
```

### Returning Values

- 함수에 Return type을 명시. Return Type을 명시 하지 않았을때는, Void 타입

```swift
func square(number: Int) -> Int {
    return number * number
}
```

- 만약 함수에 하나의 연산만 존재한다면 return 키워드를 생략해도 된다. 하지만, if문 또는 다른 연산이 한번더 들어오게 되면, return을 꼭 명시해주어야함.

```swift
// 가능
func square(number: Int) -> Int {
    number * number
}

// 가능
func greet(name: String) -> String {
    name == "Taylor Swift" ? "Oh wow!" : "Hello, \(name)"
}

// 불가능
func greet(name: String) -> String {
    if name == "Taylor Swift" {
        "Oh wow!"
    } else {
        "Hello, \(name)"
    }
}
```

- 2개 이상의 return 값이 필요할때
    - tuple 사용
    
    ```swift
    func getUser() -> (first: String, last: String) {
        (first: "Taylor", last: "Swift")
    }
    ```
    
    - Collection 사용
    
    ```swift
    func getUser() -> [String] {
        ["Taylor", "Swift"]
    }
    
    func getUser() -> [String: String] {
        ["first": "Taylor", "last": "Swift"]
    }
    ```
    

### Parameter labels

- Swift는 파라미터에 라벨을 줄 수 있음

```swift
func sayHello(to name: String) {
    print("Hello, \(name)!")
}

sayHello(to: "Taylor") // Correct
sayHello(name: "Taylor") // Wrong
```

### Omitting parameter labels

- 파라미터 라벨을 없앨수도 있음
- 언제?
    - 함수명만으로 어떤 역할을 할 수 있는지 확인이 될때, 예를들면 greet, buy, find 등..

```swift
func greet(_ person: String) {
    print("Hello, \(person)!")
}

greet("Taylor")
```

### Default Parameters

- Default parameter를 메소드를 만들때 작성함으로써 옵셔널 파라미터로 만들 수 있음

```swift
func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

greet("Taylor") // 가능
greet("Taylor", nicely: false) // 가능
```

### Variadic Functions

- 파라미터를 갯수를 정하지 않고, 몇개의 파라미터도 받을 수 있도록 해줌
- 파라미터 타입은 Array

```swift
func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

square(numbers: 1, 2, 3, 4, 5)
```

### Writing throwing functions

- return type 명시 전에, throws라는 키워드를 주고 Error를 throwing 할 수 있음

```swift
// Exception 생성
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

```

### Running Throwing Functions

- do-catch와 try를 사용해서 throw 되는 예외들을 잡아낼 수 있음

```swift
do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}
```

- Swift에서는 다른 언어와 다르게 세가지의 키워를 모두 사용해야 되는데, 그 이유는 하나의 do block안에 throwing function 들과 non-throwing function들이 같이 있을때, 유용하게 사용됨.

```swift
func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

func checkPasswordWithoutException(_ password: String) {
    print("Hello!")
}

do {
    checkPasswordWithoutException("password")
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

// Hello!
// You cant' use that password. 
```

### inout parameters

- Swift 파라미터는 constant이기 때문에, 파라미터 자체를 수정할 수 없다.
- 하지만, 꼭 파라미터를 수정해야한다면, inout 키워드를 사용하고 메소드를 호출할때는 & 를 사용한다.

```swift
func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10 
doubleInPlace(number: &myNum)

print(myNum) // 20
```

- 가장 많이 사용되는 곳 `+=`
    - 파라미터를 수정할 수 있게 도와줌으로 써 return을 하지 않고 더해줌
    
    ```swift
    func +=(leftNumber: inout Int, rightNumber: Int) {
        // code here
    }
    ```

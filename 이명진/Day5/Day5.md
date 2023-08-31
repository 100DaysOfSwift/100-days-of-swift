# Day 5

### 함수

```swift
func printHelp() {
    let message = """
Welcome to MyApp!

Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""

    print(message)
}

printHelp()
```

### 매개변수 전달

```swift
print("Hello, world!")

func square(number: Int) {
    print(number * number)
}

square(number: 8)
```

### 반환(리턴)

```swift
func square(number: Int) -> Int {
    return number * number
}

let result = square(number: 8)
print(result)
```

### 매개변수 레이블

```swift
func square(number: Int) -> Int {
    return number * number
}

let result = square(number: 8)

func sayHello(to name: String) {
    print("Hello, \(name)!")
}

sayHello(to: "Taylor")
```

### 매개변수 레이블 생략

```swift
func greet(_ person: String) {
    print("Hello, \(person)!")
}

greet("Taylor")
```

### 매개변수 기본값

```swift
func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

greet("Taylor")
greet("Taylor", nicely: false)
```

### 가변 파라미터

```swift
print("Haters", "gonna", "hate")

func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

square(numbers: 1, 2, 3, 4, 5)
```

### 에러 처리(전달)

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
```

### 에러 처리(catch)

```swift
do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}
```

### inout 파라미터

```swift
func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10 
doubleInPlace(number: &myNum)
```
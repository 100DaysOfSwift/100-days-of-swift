# Day7

### Using closures as parameters when they accept parameters

- 파라미터로 closure를 사용할때, 파라미터로 사용된 closure 또한 다른 파라미터를 받을 수 있음

```swift
func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

travel { (place: String) in
    print("I'm going to \(place) in my car")
}
```

### Using closures as parameters when they return values

- 당연히 closure도 함수이기 때문에, 어떠한 데이터를 return할 수 있음. 따라서 파라미터로 사용될 클로져 또한 return type을 가질 수 있음.

```swift
func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
```

### Shorthand parameter names

```swift
travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
```

- 위와  같은 코드를 짧게 만들 수 있음.
- travel 메소드는 이미 클로저가 String 타입의 파라미터를 받고, String 타입의 return 타입을 주는것을 알고 있기 때문에 생략이 가능함.

```swift
travel { place in
    return "I'm going to \(place) in my car"
}
```

- 그리고 메소드에서 한줄만 있는 코드는 `return` 키워드를 생략 가능

```swift
travel { place in
    "I'm going to \(place) in my car"
}
```

- 그리고, `place in` 키워드 또한 생략 가능하고, 파라미터를 `$` 를 사용해서 가지고 올 수 있고, 0부터 시작해서 파라미터 순서대로 가지고 올 수 있음.
    - 해당 코드는 이해가 불편할것 같음..

```swift
travel {
    "I'm going to \($0) in my car"
}
```

### Closures with multiple parameters

- 클로저 또한 메소드처럼 여러개의 파라미터를 받을 수 있다.

```swift
func travel(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}

travel {
    "I'm going to \($0) at \($1) miles per hour."
}
```

### Returning Closures from functions

- 메소드가 클로저를 return 해줄 수 있다.

```swift
func travel() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

// 1번째 방법
let result = travel()
result("London")

// 2번째 방법
let result2 = travel()("London") 
```

### Capturing values

- 클로저는 함수내에 있는 value를 가지고 있을 수 있다.
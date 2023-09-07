# Day6

### Creating basic closures

- 나중에 연산할 코드를 저장해 두는것이라고 생각하면 편함
- 예를들면
    - delay를 주고나서 코드를 실행시켜야할 때
    - animation이 끝나고 코드를 실행시켜야할 때
    - download가 끝나고 코드를 실행해야할 때
    - 유저가 어떤 옵션을 선택한 후 코드를 실행해야할 때

```swift
let driving = {
    print("I'm driving in my car")
}

driving();
```

- 알고보면 named closure 와 unnamed closure가 있는데, 위와 같은 closure 은 unnamed closure 이고 func 를 사용해서 만드는 함수 또한 closure인데, named closure이다.

### Accepting parameters in a closure

- `in` 키워드를 사용해서, 파라미터로 받아낼 수 있음
- 클로저에서는 func 로 만든 method와 다르게 파라미터 라벨을 사용하지 않음

```swift
let driving = { (place: String) in
    print("I'm going to \(place) in my car")
}

driving("London")
```

- 클로저에서 {} 안에 파라미터를 사용하는 이유
    - 만약 `let payment = (user: String, amount: Int)` 이렇게 사용한다면, tuple을 만드는것 같고, 파라미터를 받는것 같지 않아보임
    - 따라서 `{}` 안에 넣고 `in` 키워드를 줌으로써, 차별화를 두었음

### Returning Values from a closure

- `in` 키워드 뒤에 `return` 타입을 명시한다.

```swift
let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

let message = drivingWithReturn("London")
print(message)
```

### Closures as parameters

- Closure를 사용해서 메소드 파라미터로 function을 받아낼 수 있음.

```swift
// Closure
let driving = {
    print("I'm driving in my car")
}

// method
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

// usage
travel(action: driving)
// I'm getting ready to go.
// I'm driving in my car
// I arrived!
```

### Trailing Closure Syntax

- 만약 method의 마지막 파라미터가 closure 일때, 변수에 할당하는 클로저도 사용할 수 있지만, 새로운 method를 생성하는듯한 형태로도 parameter로 사용할 수 있다.

```swift
func travel(data: String, action: () -> Void) {
		print(data)
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel(data: "data!") {
    print("I'm driving in my car")
}

// data!
// I'm getting ready to go
// I'm driving in my car
// I arrived!
```

- 만약 Closure외 다른 파라미터가 없을때에는 `()` 도 생략 가능하다.

```swift
travel {
    print("I'm driving in my car")
}
```

- Trailing Closure Syntax를 만든 이유는, 코드를 더 일기 쉽게 하기 위해서 만들어짐.
    
    ```swift
    func travel(data: String, action: () -> Void) {
    		print(data)
        print("I'm getting ready to go.")
        action()
        print("I arrived!")
    }
    
    travel(data: "data!", action: {
    	print("I'm driving in my car")
    })
    
    // 위와 같이 사용해도 되지만
    
    travel(data: "data!") {
    	print("I'm driving in my car")
    }
    
    // 위와 같이 사용하는게 더 깔끔함.
    ```
    
- 하지만, label 없이 사용하는것이기 때문에, method 이름을 정할때 다른 개발자가 파라미터로 어떤 closure를 받는지 명확해야함.

```swift
func animate(duration: Double, animations: () -> Void) {
    print("Starting a \(duration) second animation…")
    animations()
}

animate(duration: 3) {
    print("Fade out the image")
}
```

- 다른 언어에는 없는 syntax고 Swift에서 많이 사용하기 때문에 많이 사용해야할듯..
# Day 6

###  클로저

```swift
let driving = {
    print("I'm driving in my car")
}

driving()
```

### 클로저 파라미터

```swift
let driving = { (place: String) in
    print("I'm going to \(place) in my car")
}

driving("London")
```

### 클로저 반환(리턴)

```swift
let driving = { (place: String) in
    print("I'm going to \(place) in my car")
}

let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

let message = drivingWithReturn("London")
print(message)
```

### 클로저 파라미터 전달

```swift
let driving = {
    print("I'm driving in my car")
}

func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel(action: driving)
```

### 후행 클로저

```swift
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel() {
    print("I'm driving in my car")
}

travel {
    print("I'm driving in my car")
}
```
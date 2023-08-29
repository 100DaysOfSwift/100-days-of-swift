# Day 2

### Arrays

- 하나가 아닌 값들을 저장할 수 있게 해주는 Data Structure
    - Array는 순서가 보장되는게 특징임.

```swift
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]
```

- Type이 지정된 Array도 정할 수 있음

```swift
[String], [Int], [Double], and [Bool].
```

### Sets

- Set은 순서가 보장되지 않고, 중복된 값이 저장이 안되는게 특징

```swift
let colors = Set(["red", "green", "blue"])
```

### Tuples

- Tuple은 저장 및 삭제가 안되고, 가장 처음 만들어진 size를 그대로 가지고 있음
- Tuple내에서는 type-safe함 → 튜플내에서는 다른 type 데이터들을 가지고 있을 수 있지만, type이 다른 값으로 재설정은 불가능함.
- 아래와 같이 index 및 Key를 통해서 데이터를 가지고 올 수 있음.
- 튜플은 key나 index를 통해서 값을 변경할 수 있으나, 다른 type의 데이터로 변경하면 에러가 남

```swift
var name = (first: "Taylor", last: "Swift", number: 1)
name.0 // "Taylor"
name.first // "Taylor"

name.first = "Marc" // 가능!
name.name = "Marc" // 불가능! TypeError!
```

### Arrays vs Sets vs Tuples

- 각각의 Data Structure를 언제 써야할까?
    - Array: 중복 값이 필요하고, 저장된 순서가 꼭 지켜져야 할 경우에, Array를 사용함.
    - Set: 중복 값이 없어야하고, 저장된 순서가 상관이 없고 빠르게 검색이 필요할때 사용
    - Tuple: 고정된 데이터를 가지고 있고, key를 가지고 값을 불러오는것이 필요할때 Tuple을 사용함.
        - 어떤 데이터와 Type이 확실할때, Tuple을 사용하자!

### Dictionaries

- Array와 비슷하게 복수개의 데이터를 저장할 수 있는데, Index가 아닌 Key를 통해서 데이터를 가지고 옴
- Array와 다르게 Index로 값을 가지고 오지 않기 때문에 빠르게 데이터를 가지고 올 수 있음.
    - Hash 알고리즘을 사용하기 때문에 순서를 보장하지 않음.
- Key 또한 다양한 타입으로 설정할 수 있지만, String으로 진행하는게 보편적.
- let이 아닌 var를 사용하게 되면, 데이터도 추가 가능
- 없는 Key를 사용해서 데이터를 가지고 오면, nil 반환

```swift
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]

var random = [
     "Hello": "hi"
]

random["hi"] = "Hello"
// ["Hello": "hi", "hi": "Hello"]
```

- Dictionary에 타입을 지정해주기 위해서는 아래와 같이 진행

```swift
[String: Double] and [String: String]
```

### Dictionary default values

- 없는 키로 Dictionary에 데이터를 요청하면 nil 값을 반환하게 되는데, 그럴때에 default 값을 줄 수 있다.

```swift
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]

heights["Marc", default: 1.20] // 1.20
```

### Creating Empty Collections

- Empty Collections를 만들기 위해서는 Type을 미리 지정해주어야함.

```swift
var results = [Int]() // Integer Array
var words = Set<String>() // String Set
var scores = Dictionary<String, Int>() // Key = String Value = Integer Dictionary
```

### Enumerations

- 연관있는 값들을 그룹으로 묶어서 지정할 수 있음.
- String을 사용하는것 보다 훨씬 빠르고 안전하다.

```swift
enum Direction {
    case north
    case south
    case east
    case west
}

print(Direction.east) // east
```

- Swift 는 String 보다 enum에 설정된 값들을 더 심플하게 저장을 해주기 때문에, 생성과 저장이 훨씬 빠르다. → 리서치가 필요함..

### Enum Associated Values

- Enum에 타입을 설정해서, 해당 Enum에 데이터를 정할 수 있는 방법

```swift
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "football")
print(talking)
```

### Enum Raw Values

- API server에서 Swift 내에서 저장된 enum을 알 수 있는 방법이 없을때, Raw Value를 사용해서 어떤 Enum인지 확인할 수 있게 해줌
- 예를들면, API 서버가 → this user has mood 0 라고 내려주고 있게 된다면,

```swift
enum Mood: Int {
    case happy
    case sad
    case grumpy
    case sleepy
    case hungry
}
```

- 해당 enum에서 0번째 자리를 가지고 있는 happy 인것을 확인할 수 있다.
- 만약 0부터 시작을 하고 싶지 않다면, 직접 숫자를 정해주게 되면, 알아서 순차적으로 넘버링을 해주게됨. 만약 없는 RawValue를 호출하면, NIL을 반환함.

```swift
enum Mood: Int {
    case happy = 1
    case sad
    case grumpy
    case sleepy
    case hungry
}
```


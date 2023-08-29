# Day 2

### 배열

배열은 값의 모음입니다. 단일 값으로 그룹화할 수 있습니다. `[]` 와 `,` 를 사용하여 정의합니다. 값을 읽기 위해서 `[숫자]` 를 사용합니다. 존재하지 않는 위치의 배열 값에 접근하면 에러가 발생합니다.

```swift
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]

beatles[1]

```

### 집합

집합은 배열과 마찬가지로 값의 모음이지만 순서대로 저장되지 않고, 중복된 값이 존재하지 않습니다. `Set` 과 `[]` 를 사용하여 정의합니다.

```swift
let colors = Set(["red", "green", "blue"])
let colors2 = Set(["red", "green", "blue", "red", "blue"])
```

### 튜플

튜플은 여러 값을 하나의 값에 저장할 수 있습니다. 값을 추가하여 저장할 수 없으며 이름이나 숫자를 사용하여 요소에 접근할 수 있습니다.

```swift
var name = (first: "Taylor", last: "Swift")
name.0
name.first
```

### 딕셔너리

딕셔너리는 키를 사용하여 값의 모음을 저장합니다. `[]` 안에 키와 값을 입력하여 정의합니다.

```swift
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
heights["Taylor Swift"]
```

딕셔너리에 키가 존재하지 않는 경우 값이 없음을 나타내는 `nil` 이 반환됩니다. 그런데 `default` 값을 지정하면 키가 존재하지 않는 경우 디폴트로 설정한 값이 반환됩니다.

```swift
let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]
favoriteIceCream["Paul"]
favoriteIceCream["Charlotte"]
favoriteIceCream["Charlotte", default: "Unknown"]
```

### 빈 컬렉션 만들기

빈 딕셔너리 만들기 및 값 추가

```swift
var teams = [String: String]()
teams["Paul"] = "Red"

var scores = Dictionary<String, Int>()
```

빈 배열 만들기

```swift
var results = [Int]()

var results = Array<Int>()
```

빈 집합 만들기

```swift
var words = Set<String>()
var numbers = Set<Int>()
```

### 열거형

열거형은 관련 값의 그룹을 만드는 타입입니다. `enum` 키워드를 사용하여 정의합니다.

```swift
enum Result {
    case success
    case failure
}
let result4 = Result.failure
```

열거형은 간단한 케이스와 함께 연관된 값을 저장할 수 있습니다.

```swift
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}
let talking = Activity.talking(topic: "football")

enum Weather {
    case sunny
    case windy(speed: Int)
    case rainy(chance: Int, amount: Int)
}
```

열거형은 각 케이스에 관련된 값(원시값)을 할당할 수도 있습니다. 관련된 타입으로 `Int` 를 지정한 경우 자동으로 0 부터 순서대로 할당됩니다.

```swift
enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
}
let earth = Planet(rawValue: 2)

enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}
```
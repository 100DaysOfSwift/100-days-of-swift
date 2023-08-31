# Day 1

Swift 에서의 변수 선언 및 사용

`var` 키워드를 사용하여 변수를 선언합니다. 선언한 변수의 값을 변경할 수 있으며 동일한 이름의 변수를 선언하면 에러가 발생합니다.

```swift
var str = "Hello, playground"
str = "Goodbye"

var favoriteShow = "Orange is New Black"
favoriteShow = "The Good Place"
favoriteShow = "Doctor Who"

// var favoriteShow = "Orange is New Black" ❌
```

Swift 는 타입 안전 언어로 모든 변수가 하나의 특정 타입을 가집니다. 따라서 특정 타입을 가진 변수에 다른 타입 데이터를 저장할 수 없습니다.

```swift
var str = "Hello" // 문자열
var age = 38 // 정수
var population = 8_000_000 // 정수

var meaningOfLife = 42
// meaningOfLife = "Forty two" ❌
```

`"""` 를 사용하여 여러 줄 문자열을 만들 수 있습니다. `\` 문자를 각 문자열의 끝에 입력하면 줄바꿈이 되지 않습니다.

```swift
var str1 = """
This goes
over multiple
lines
"""

var str2 = """
This goes \
over multiple \
lines
"""

var quote = "Change the world by being yourself"

var burns = """
The best laid schemes
O’ mice and men
Gang aft agley
"""
```

Swift 에는 부동소수점 데이터를 나타내는 `Double` 과 참과 거짓을 나타내는 `Bool` 타입을 가지고 있습니다. Swift 는 숫자를 나타내는 다른 타입의 연산을 허용하지 않습니다.

```swift
var pi = 3.141

var awesome = true

var myInt = 1
var myDouble = 1.0

// var total = myInt + myDouble ❌
```

문자열을 직접 입력하여 정의할 수 있지만, 문자열 안에 변수를 포함하여 문자열을 정의(String interpolation, 문자열 보간법)할 수 있습니다. 포함할 변수는 `\(변수)` 형태로 정의합니다. 모든 타입의 변수를 문자열에 포함할 수 있습니다.

```swift
var score = 85 
var str3 = "Your score was \(score)" 
var results = "The test results are here: \(str3)" 

var city = "Cardiff"
var message = "Welcome to \(city)!"
```

`let` 키워드를 사용하여 한번 값을 설정하고 변경하지 않는 값인 상수를 선언할 수 있습니다. 값이 변경되어 발생하는 문제를 피하기 위하여 Swift 에서는 상수 선언을 권장합니다.

```swift
let taylor = "swift"
```

Swift 는 주어진 값에 따라 변수(상수) 의 타입을 결정합니다. 이를 타입 추론이라고 합니다. 타입 추론을 하지 않고 타입을 명시적으로 지정하여 사용할 수도 있습니다.

```swift
let str4 = "Hello, playground"

let album: String = "Reputation"
let year: Int = 1989
let height: Double = 1.78
let taylorRocks: Bool = true

var percentage: Double = 99

var name: String
```
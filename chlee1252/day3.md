# Day3

### Arithmetic Operations

- 스위프트에서의 사칙연산:
    - +, -, *, /, % 를 지원함
    - Double과 Int 사칙연산이 불가능한 이유?
        - Double과 Int는 저장할때 같은 양의 메모리를 차지하지만, 서로 저장하는 데이터가 다름
            - Double은 소숫점 자리까지 저장할 수 있지만, Int는 할 수 없음
            - Double은 아주 큰 숫자가 왔을때, 지정한 값과 다른 정보가 저장이됨. 하지만 Int 타입은 그렇지 않음
                - 이렇게 되는 이유는, Swift는 소숫점 자리를 가지는 데이터들은 예상값으로 상수들을 저장하게 됨 (IEEE 754 standard). 따라서 Double은 아주 큰 숫자를 저장할 수 있지만, 큰 숫자의 1자리 숫자와 같은 아주 작은 부분은 무시해버림.
                
                ```swift
                let value: Double = 90000000000000001
                // warning - 90000000000000001' is not exactly representable as 'Double'; it becomes '90000000000000000
                ```
                
            - 따라서, Double과 Int 타입을 연산하게 된다면, Int타입으로 줄때는, 소숫점 정보가 사라지게 되고, Double 타입으로 주기엔 정확한 정보가 전달될 수 없음.
            - 스위프트는 이러한 문제들 때문에 double과 Int 연산과 같은 다른 타입간 연산을 막아 놓았음.

### Operator Overloading

- 숫자타입 뿐만 아니라 String, List type 또한 operator를 사용할 수 있음.

```swift
let doubleMeaning = 42 + 42;
let action = "Fakers gonna " + "fake" // "Fakers gonna fake"
let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf // ["John", "Paul", "George", "Ringo"]
```

### Compound Assignment Operators

- 자기자신과 연산을 할때 사용할 수 있는 shorthand가 있음

```swift
var quote = "The rain in Spain falls mainly on the "
quote += "Spaniards"
print(quote) // "The rain in Spain falls mainly on the Spaniards"
```

### Comparison Operators

- 비교 연산자

```swift
let firstScore = 6
let secondScore = 4

firstScore == secondScore
firstScore != secondScore

firstScore < secondScore
firstScore >= secondScore

// 아래와 같이 custom object 및 enum도 비교 가능. Comparable를 꼭 포함할것.
enum Sizes: Comparable {
    case small
    case medium
    case large
}

let first = Sizes.small
let second = Sizes.large
print(first < second)
```

### Conditions

- if문으로 비교를 해서 원하는 상황에 맞는 값을 전달 받을 수 있음

```swift
let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 2 {
    print("Aces – lucky!")
} else if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}
```

### Combining Conditions

- OR

```swift
if age1 > 18 || age2 > 18 {
    print("At least one is over 18")
}
```

- AND

```swift
let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}
```

### The Ternary Operator

- 삼항연산자
    - 코드가 간단해진다는 장점이 있지만, if문보다 이해가 어려움
    - SwiftUI를 사용할때 많이 사용함.

```swift
print(firstCard == secondCard ? "Cards are the same" : "Cards are different")
// 위 코드와 아래 코드는 같다.
if firstCard == secondCard {
    print("Cards are the same")
} else {
    print("Cards are different")
}
```

### Switch Statements

- default는 필수 → 정의해놓은 상황이 없을때 사용

```swift
switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
default:
    print("Enjoy your day!")
}
```

- fallthrough: 다른 case로 넘어가게 할 수 있음

```swift
switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}
```

- if문 대신 switch를 사용해야하는 이유
    - switch에서는 개발자가 생각한 케이스들을 모두 정의하기 때문에 (+ default) 개발자가 생각한대로 코드가 동작함. if문은 특별한 케이스가 등장하게 되면, if문을 안탐.
    - switch문을 사용할때, 참조되는 값을 한번만 읽게 되지만, if문은 몇번씩 읽음.
    - switch문은 if문에서 지원하지 않는 advanced pattern을 지원함.

### Range Operators

- 1~5 까지 숫자를 확인해야할때 ..< 키워드를 사용

```swift
let score = 85

switch score {
case 0..<50:
    print("You failed badly.")
case 50..<85:
    print("You did OK.")
default:
    print("You did great!")
}
```


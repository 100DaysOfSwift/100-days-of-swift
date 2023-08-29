# Day1

### Variables

- 데이터를 저장하고, 나중에 다른 데이터로 덮어 씌울 수 있는 하나의 상자
- var 키워드를 사용하여 만들게 되고, 수정을 위해서는 var 키워드를 생략하면 된다.
- 하지만, var 키워드를 사용하게 된다면, 추후에 다른 데이터로 덮어 써질 수 있는 문제가 있어서 항상 조심해서 사용해야 한다.

### String and Integers

- String (String), Integer (Int)
- 큰 숫자를 적기 위해서는 _ (underscore)를 사용해서 숫자를 적용한다.

```swift
var bigNumber = 8_000_000
```

- Swift는 코틀린과 동일하게 type-safe를 지원하고 있는데, type-safe란, 컴파일러가 가장 처음 유추해서 정해진 타입을 바꿀 수 없음.

```swift
var number = 80
number = "hello" // 해당 문법은 적용되지 않음.
```

### Multi-line Strings

- 긴 스트링 값을 적용하기 위한 문법

```swift
var longString = """
hello this is
long 
string
"""
```

- 해당 문법을 사용하게 되면, /n 과 같은 개행을 사용하지 않아도 개행을 자동으로 볼 수 있음
    - 혹시 개행이 필요가 없다면
    
    ```swift
    var longString = """
    hello this is \
    long \
    string
    """
    ```
    
- 코드를 봤을때, 해당 값이 어떻게 개행이 되는지 한눈에 볼 수 있지만.. 혹시 해당 변수에서 에러가 나고, 다른 사람들이 코드를 찾을 때 아주 불편하다는 단점이 존재함.
- 파이썬으로 개발할 때 처럼 실무에서 사용을 최대한 지양할듯.

### Doubles and Booleans

- Double (Double): 소숫점 숫자들이 assign 되었을때 지정되는 type
- Boolean (Bool): true or false
- Double와 Integer의 연산이 안되는 이유
    - Swift는 type-safe 언어이기 때문에, 어떠한 조건이든 type이 섞이는것을 방지하고자 연산을 막아 놓았음.
        - 예를 들면, 1 + 1.0 은 당연하게 2라는 integer 값이 나오지만, 만약 1.0이 1.1과 같은 소숫점이 들어오게 되면 정답은 2.1과 같은 double 값으로 변경되게 됨.
        - 따라서, Swift에서 type을 유추할때 100% 안전한 타입을 지정할 수 없게 됨. 그래서 해당 연산을 안되게 막아버림

### String Interpolation

- String 값에 dynamic하게 값을 변경하거나 정할 수 있게 해주는 문법
- Swift default type이면, 정확한 값으로 string에 지정됨.

```swift
var score = 85
var str = "Score \(score)"
```

- 특이하게 backslash와 괄호를 사용함.
- Swift 5.0부터는 해당 interpolation을 custom하게 구현해서 사용할 수 있게 만들어줌
    - 이렇게 custom하게 사용하면 적용할 수 있는 방법이 다양해지지만, 코드를 보는 입장에서는 혼돈이 올 수 있을것 같음.

```swift
extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Int) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
     
    if let result = formatter.string(from: value as NSNumber) {
            appendLiteral(result)
    }
    }
}

var score = 85
var str = "Score \(score)" // Score eighty-five
```

### Constants

- 다른 최신 언어들과 마찬가지로 불변객체를 만들 수 있음

```swift
let score = 88
score = 99 // 안됨!!
```

- 다른 언어들과 같이 var 보다는 let을 추천하고 있는데,
    - 다른 data로 변경되는 일이 없기에, 해당 변수를 사용하면 다른 데이터가 나오는 것을 방지함.
    - 조금이라도 복잡한 코드를 작성하거나 앱을 개발하게 될 때, 본인 혹은 다른 개발자가 해당 데이터를 변경할 수 있는 가능성을 없애줌.
    - 그래서 var를 꼭 사용해야할 상황을 제외하고는 let 키워드를 사용해서 변수를 관리하는게 좋음

### Type Annotations

- Swift는 컴파일러에서 type을 dynamic하게 설정 해주지만, 개발자가 직접 Type을 먼저 지정해줄 수 있음

```swift
var percentage: Int = 11
```

- 왜 Type Annotation을 사용해야하나요?
    - Swift 자체에서 어떤 타입이 들어오는지 유추가 안될때
        - User Interaction을 통해 API가 호출되고, 어떤 데이터가 API를 통해서 들어올지 Swift가 유추하지 못할때 type을 미리 지정해준다.
    - Swift가 Default타입을 설정된 타입으로 사용하게 할때
        
        ```swift
        var percentage: Double = 99 // 99.0
        ```
        
    - 변수를 설정할 때에 값을 설정하지 않을때
        
        ```swift
        var name: String
        ```
        
- 개인적으로는, (회사 코드스타일을 제일 먼저 따라야겠지만…) Swift Default Type (String, Double, Int, Bool …)과 같은 타입이 아니라면 명시를 해주는것이 좋아보임..
    - 개인적인 경험으로는, Kotlin이나 Java15 이상을 쓸때 type을 명시를 안하고 있는데, 기본적인 Type이 아닌 상황에서는 어떤 객체가 주입이 되는지 확인이 어려워 디버깅이 어려웠던 경험이 많음.

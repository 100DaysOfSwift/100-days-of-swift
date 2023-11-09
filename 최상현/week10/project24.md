# project 24

- string 에 집중. 캐릭터의 배열보다 훨씬 중요함
- 유용한 메서드나 프로퍼티, 포매팅 등을 배움


## string 은 array가 아니다

```swift
let name = "Taylor"

for letter in name {
    print("Give me a \(letter)!"
}

// 아래는 안된다
print(name[3])

```


- 이모지가 되거나, 액센트를 넣는 글자가 될 수도 있다.
- 그래서 name의 4번째 글자 읽으려면 처음부터 시작해 카운팅 해야 한다.

```swift
let letter = name[name.index(name.startIndex, offsetBy: 3)]

```

- apple은 이걸 쉽게 바꿔준다 (?)

```swift
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
```

- subscript는 특수한 메서드


## 유용한 기능들

- hasPrefix(string), hasSuffix(string)
- String 에 extension method 를 아래처럼 구현도 가능
```swift
extension String {
    // remove a prefix if it exists
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }

    // remove a suffix if it exists
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}
```

- uppercased() 는 Character가 아니라 String을 리턴한다. 왜냐? 예로 독일어는 대문자형이 "SS"처럼, 2글자이상인 경우가 있음


```swift
extension String {
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
}
```

- contains() 는 매우 유용하다. 아래처럼 containsAny 구현가능
```swift
extension String {
    func containsAny(of array: [String]) -> Bool {
        for item in array {
            if self.contains(item) {
                return true
            }
        }

        return false
    }
}
```


## NSAttributedString
- 문자열 Plain Text지만 더 많은 기능을 요구할 경우 사용


```swift
let string = "This is a test string"
let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]

let attributedString = NSAttributedString(string: string, attributes: attributes)
```


```swift
let attributedString = NSMutableAttributedString(string: string)
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))

```

Set .underlineStyle to a value from NSUnderlineStyle to strike out characters.
Set .strikethroughStyle to a value from NSUnderlineStyle (no, that’s not a typo) to strike out characters.
Set .paragraphStyle to an instance of NSMutableParagraphStyle to control text alignment and spacing.
Set .link to be a URL to make clickable links in your strings.

# Day 4

### For loops

- Integer range

```swift
let count = 1...10

for number in count {
    print("Number is \(number)")
}
```

- 만약, 룹만 돌아야하고 데이터가 필요가 없다면

```swift
print("Players gonna ")

for _ in 1...5 {
    print("play")
}
```

### While loops

```swift
var number = 1

while number <= 20 {
    print(number)
    number += 1
}
```

### Repeat loops

- do-while과 동일한 형태 → 잘 쓰이지 않음.
- while loop과 다르게, 로직이 한번은 돌게 되어 있음.

```swift
var number = 1

repeat {
    print(number)
    number += 1
} while number <= 20

print("Ready or not, here I come!")
```

### Exiting loops

- break 키워드를 통해 loop 을 종료 시킴

```swift
while countDown >= 0 {
    print(countDown)

    if countDown == 4 {
        print("I'm bored. Let's go now!")
        break
    }

    countDown -= 1
}
```

### Exiting Multiple Loops

- 중첩 중복문일때, loop에 variable과 같이 설정을 주고, break를 줄 수 있음

```swift
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")

        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}
```

### Skipping Items

- continue 키워드를 통해 다음 룹으로 넘어감

```swift
for i in 1...10 {
    if i % 2 == 1 {
        continue
    }

    print(i)
}
```

### Infinite Loops

- while true를 주어서 infinite loop 생성

```swift
var counter = 0

while true {
    print(" ")
    counter += 1

    if counter == 273 {
        break
    }
}
```

import UIKit

func square(number: Int) -> Int {
    return number * number
}

print(square(number: 4))

func sayHello(to name: String) {
    print("Hello, \(name)!")
}
// 내부 파라미터명과 외부 파라미터명을 다르게 줄 수가 있음

sayHello(to: "officer")

func sayHello2(_ name: String = "my default name") {
    print("Hello, \(name)!")
}

sayHello2("no param name")
sayHello2()


func sayHelloToAll(_ name: String...) {
    print(name)
}

sayHelloToAll("hi", "choi", "kim")

// 에러던지기 위해서는 Error 를 타입으로 하면된다


// inout parameter
// 기본적으로 함수 파라미터는 let인데, input을 쓰면 외부 변수를 var로 가져와 수정 가능하다

var num = 15

func doubleInPlace(outNum: inout Int) {
    outNum *= 2
}

doubleInPlace(outNum: &num)


// 이름이 없는 메서드다.
// 주의할 점은, 파라미터 가 parentheses안에 위치해야 한다는 것
let driving = { (place: String) in
    print("I'm going to \(place) in my car")
}

driving("seoul")

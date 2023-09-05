func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

travel { (place: String) in
    print("I'm going to \(place) in my car")
}

func travel1(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel1 { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

func travel2(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel2 { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

travel2 { place -> String in
    return "I'm going to \(place) in my car"
}

travel2 { place in
    return "I'm going to \(place) in my car"
}

travel2 { place in
    "I'm going to \(place) in my car"
}

travel2 {
    "I'm going to \($0) in my car"
}

func travel3(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}

travel3 {
    "I'm going to \($0) at \($1) miles per hour."
}

func travel4() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

let result = travel4()
result("London")

let result2 = travel4()("London")

func travel5() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

let result1 = travel5()
result1("London")

func travel6() -> (String) -> Void {
    var counter = 1

    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}

result1("London")
result1("London")
result1("London")

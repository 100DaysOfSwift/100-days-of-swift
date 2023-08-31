let driving = {
    print("I'm driving in my car")
}

driving()

let driving1 = { (place: String) in
    print("I'm going to \(place) in my car")
}

driving1("London")

let driving2 = { (place: String) in
    print("I'm going to \(place) in my car")
}

let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

let message = drivingWithReturn("London")
print(message)

let driving3 = {
    print("I'm driving in my car")
}

func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel(action: driving3)

func travel1(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel1() {
    print("I'm driving in my car")
}

travel1 {
    print("I'm driving in my car")
}

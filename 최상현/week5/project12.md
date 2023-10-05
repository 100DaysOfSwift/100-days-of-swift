# UserDefaults

- app 이 계속 데이터를 저장할 수 있도록 해줍니다
- basic data type 부터 dict, Date, Data 타입까지 가능함
- 그러나 너무 큰 데이터를 저장하면 안됨

```swift
let defaults = UserDefaults.standard
defaults.set(25, forKey: "Age")
defaults.set(true, forKey: "UseTouchID")
defaults.set(CGFloat.pi, forKey: "Pi")
defaults.set("Paul Hudson", forKey: "Name")
defaults.set(Date(), forKey: "LastRun")
let array = ["Hello", "World"]
defaults.set(array, forKey: "SavedArray")

let dict = ["Name": "Paul", "Country": "UK"]
defaults.set(dict, forKey: "SavedDict")
```

- 유니크한 key와 ref를 매핑합니다
- 값을 읽어오려면?
- 타입에 따라 여러 메서드를 사용해야 함

```
integer(forKey:) returns an integer if the key existed, or 0 if not.
bool(forKey:) returns a boolean if the key existed, or false if not.
float(forKey:) returns a float if the key existed, or 0.0 if not.
double(forKey:) returns a double if the key existed, or 0.0 if not.
object(forKey:) returns Any? so you need to conditionally typecast it to your data type.

```
### 안전하게 타입 캐스팅 해보자
```swift
let array = defaults.object(forKey:"SavedArray") as? [String] ?? [String]()
let dict = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()

```
- 해당 키에 해당하는 오브젝트가 있다면 문자열 배열로 캐스팅하고, 없으면 빈 배열을 생성. Dict도 동일

# NSCoding
- 규칙만 따르면 기본 데이터 타입 외의 모든 데이터를 저장할 수 있다
- NSKeyedArchiver 의 `archivedData()` 를 쓰면된다. 오브젝트 그래프는 Data object로 변환하고 UserDefaults에 써내려간다.
- object graph는 object에 그걸 refer하는 object를 계속 연결 하는것-
- class data type은 NSCoding protocol을 순응해야한다
- apple 의 대부분의 클래스는 NSCoding을 지원하지만, 내가 만드는 클래스들은 별도로 꼭 NSCoding을 순응해야한다

## project10 에서의 물음에 대한 해결
`class Person: NSObject, NSCoding {`
- 프로젝트10에서 두 프로토콜이 사용된 이유가 이제 드러남
- struct로도 충분할텐데 클래스로 만들고 struct를 쓰지 않은 이유? struct면 NSCoding을 쓸 수 없을 것 (object로 캐스팅 못해서?)
- **NSObject 를 상속해야만 NSCoding을 쓸수가 있다. 아니면 앱이 크래쉬난다.**

## NSCoding 을 쓰기 위한 추가 구현
```swift
required init(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
    image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
}

func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(image, forKey: "image")
}
```
- required init 은 상속할 서브클래스들이 필수로 구현해야하는 메서드
- encode는 저장할때, decodeObject는 생성자에서 값 로딩할 때 사용


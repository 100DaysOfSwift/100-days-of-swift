# debugging

## print()
- print(1, 2, 3, 4, 5, separator: "-")
- print("Some message", terminator: "") default는 \n


## assert()

- 조건이 true 가 아니면 앱이 크래쉬
- 중요한 파일등이 없을때, 앱이 진행되면 유저 데이터를 잃든가하는 나쁜 결과가 생길수 있다
- 디버깅할때만 assertion이 크래쉬 된다. 릴리즈 버전에서는 알아서 Xcode 가 disable한다
- 리얼 유저에게 영향없이 엄격한 환경에서 디벨롭이 가능하게 된다

## breakPoint
-Cmd+8 = breakpoint navigator


## view debug

- view 계층구조 확인가능
- 프로그레스바 조절 시 어떻게 view가 쌓여있는지 볼수 있음
- 하단 디버그 메뉴에서 여러 면이 겹쳐진 버튼
<img width="983" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/82af0ed1-2c9d-4f0f-a2a4-1ea6318732ea">


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

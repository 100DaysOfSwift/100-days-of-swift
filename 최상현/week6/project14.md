# 두더지잡기 게임?
- SpriteKit으로 게임만들기 2

# SKCropNode
- 프로젝트 생성 시 ipad 로 기기 제한(?)
- GameScene class 에 X:0,Y:0 W1024H768 로 세팅
- 배경 크기가 기기별로 조금씩 안맞을 수 있음
- 예를 들어 11inch ipad pro 는 1024x768 크기에 맞춘 gamescene에 비해 비율이 좀 독특
- SPriteKit이 비율이 어떻든 이미지를 stretch 시켜줄 수 있음

```swift
scene.scaleMode = .aspectFill
// ->
scene.scaleMode = .fill

```

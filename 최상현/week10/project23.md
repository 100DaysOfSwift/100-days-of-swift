# UIBezierPath, SKSpriteNode, 물리학


### gameScene.swift
```swift
var gameScore: SKLabelNode! 
var score = 0 {
    didSet {
        gameScore.text = "Score: \(score)"
    }
}

var livesImages = [SKSpriteNode]()
var lives = 3


let background = SKSpriteNode(imageNamed: "sliceBackground")
background.position = CGPoint(x: 512, y: 384)
background.blendMode = .replace
background.zPosition = -1
addChild(background)

physicsWorld.gravity = CGVector(dx: 0, dy: -6)
physicsWorld.speed = 0.85

createScore()
createLives()
createSlices()

func createScore() {
    gameScore = SKLabelNode(fontNamed: "Chalkduster")
    gameScore.horizontalAlignmentMode = .left
    gameScore.fontSize = 48
    addChild(gameScore)

    gameScore.position = CGPoint(x: 8, y: 8)
    score = 0 
}

func createLives() {
    for i in 0 ..< 3 {
        let spriteNode = SKSpriteNode(imageNamed: "sliceLife")
        spriteNode.position = CGPoint(x: CGFloat(834 + (i * 70)), y: 720)
        addChild(spriteNode)

        livesImages.append(spriteNode)
    }
}
func createSlices() {
    activeSliceBG = SKShapeNode()
    activeSliceBG.zPosition = 2

    activeSliceFG = SKShapeNode()
    activeSliceFG.zPosition = 3

    activeSliceBG.strokeColor = UIColor(red: 1, green: 0.9, blue: 0, alpha: 1)
    activeSliceBG.lineWidth = 9

    activeSliceFG.strokeColor = UIColor.white
    activeSliceFG.lineWidth = 5

    addChild(activeSliceBG)
    addChild(activeSliceFG)
}
```
- Slices 는 2개. z=3 이 더 앞에 있다. 모양을 그리는 스프라이트킷의 노드타입이 `SKShapeNode` 다.
- score, lives 는 아래와 같이 생성
<img width="350" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/4477f78e-2a26-4e3a-8259-5cea04d5b07e">


## Shaping up for action
- 터치가 시작되고 이동하고 종료되는 위치를 (swipe point) 도형으로 그린다
- CGPoint 배열에 저장한다

```swift
override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    activeSlicePoints.append(location)
    redrawActiveSlice()
}
override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    activeSliceBG.run(SKAction.fadeOut(withDuration: 0.25))
    activeSliceFG.run(SKAction.fadeOut(withDuration: 0.25))
}
```

- touchesEnded 는  터치가 끝나면 호출된다. 1/4초 동안 만들어낸 도형을 사라지게 할 것. 바로 없애면 좀 느낌없기때문
- touchesBegan이 할게 많음
  - 배열을 비워야함
  - 배열에 터치 위치를 추가함
  - redrawActiveSlice() 라는 메서드를 호출함. slice shape를 clear함
  - slice shape 에 붙어있는 어떤 액션이든 제거함. 이건 중요함 왜냐면 fadeOut() action 의 도중이라서
  - 잘 보이도록 alpha = 1 설정
 
```swift
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }

    // 1  
    activeSlicePoints.removeAll(keepingCapacity: true)

    // 2
    let location = touch.location(in: self)
    activeSlicePoints.append(location)

    // 3
    redrawActiveSlice()

    // 4
    activeSliceBG.removeAllActions()
    activeSliceFG.removeAllActions()

    // 5
    activeSliceBG.alpha = 1
    activeSliceFG.alpha = 1
}
```

## UIBezierPath
- swipe 되는 지점들을 하나의 line으로 그리기 위함
- redrawActiveSlice() 를 실행해야함
  - 배열에 2개 점보다 적다면, 데이터가 충분치않아서 종료
  - 12개 보다 많다면 오래된걸 지움
  - 첫번째 위치로부터 라인 그리기 시작하면 각 라인들을 지나감
  - 업데이트되어야한다. slice shape 의 길이.
 - SKShapeNode 는 path prop이 있고, nil이면 아무것도 그리지않는다.
 - 의미있는 값이라면 그림이 그려진다.
 - CGPath 데이터타입을 쓰도록 해야한다. 이 타입은 UIBezierPath로 쉽게 만들웃있다
 - 복잡한 길을 만들기 쉬워진다. move(to:) 메서드를 라인의 시작을 가리키게 한다. 그리고 루프를 만든다 addLine(to:) 를 호출하도록.


```swift
func redrawActiveSlice() {
    // 1
    if activeSlicePoints.count < 2 {
        activeSliceBG.path = nil
        activeSliceFG.path = nil
        return
    }

    // 2
    if activeSlicePoints.count > 12 {
        activeSlicePoints.removeFirst(activeSlicePoints.count - 12)
    }

    // 3
    let path = UIBezierPath()
    path.move(to: activeSlicePoints[0])

    for i in 1 ..< activeSlicePoints.count {
        path.addLine(to: activeSlicePoints[i])
    }

    // 4
    activeSliceBG.path = path.cgPath
    activeSliceFG.path = path.cgPath
}
```

## createEnemy()
아래 세개 기능 필요 
- 펭귄과 폭탄 만들기
- 어디에 이 둘을 생성할지
- 어떤 방향으로 움직일지



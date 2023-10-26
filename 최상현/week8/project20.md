# Timer and follow()

- didMove(to:) 에서 타이머를 만들어 6초마다 불꽃을 만듬
- createFirework() 에서 하나의 불꽃을 각 포지션별로 ㅁ나듬
- launchFirework() 에서 메서드 호출하고 만듬

```swift
var gameTimer: Timer?
var fireworks = [SKNode]()

let leftEdge = -22
let bottomEdge = -22
let rightEdge = 1024 + 22

var score = 0 {
    didSet {
        // your code here
    }
}

override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "background")
    background.position = CGPoint(x: 512, y: 384)
    background.blendMode = .replace
    background.zPosition = -1
    addChild(background)

    gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(launchFireworks), userInfo: nil, repeats: true)
}
```


```swift
func createFirework(xMovement: CGFloat, x: Int, y: Int) {
    // 1
    let node = SKNode()
    node.position = CGPoint(x: x, y: y)

    // 2 sprite 를 동적으로 퍼포먼스 비용없이 색바꿈
    let firework = SKSpriteNode(imageNamed: "rocket")
    firework.colorBlendFactor = 1
    firework.name = "firework"
    node.addChild(firework)

    // 3
    switch Int.random(in: 0...2) {
    case 0:
        firework.color = .cyan

    case 1:
        firework.color = .green

    case 2:
        firework.color = .red

    default:
        break
    }

    // 4
    let path = UIBezierPath()
    path.move(to: .zero)
    path.addLine(to: CGPoint(x: xMovement, y: 1000))

    // 5
    let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
    node.run(move)

    // 6
    if let emitter = SKEmitterNode(fileNamed: "fuse") {
        emitter.position = CGPoint(x: 0, y: -22)
        node.addChild(emitter)
    }

    // 7
    fireworks.append(node)
    addChild(node)
}
```
### SKAction follow()
- CGPath 를 첫번쨰 파라미터로. node가 path를 따라 움직이도록 함. 직선이어야하는건 아님
- 좌표가 상대좌표인지 절대좌표인지, asOffset이 true면 path의 좌표는 노드 위치에 따라 조정됨
- orientToPath 는 노드가 자동으로 회전하게 됨, 항상 경로 아래를 향하게 함


https://www.hackingwithswift.com/read/20/3/swipe-to-select



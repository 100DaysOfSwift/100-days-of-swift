# SpriteKit Timer linearDamping, angularDamping

```swift
var starfield: SKEmitterNode!
var player: SKSpriteNode!

var scoreLabel: SKLabelNode!
var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}

```

- didSet을 통해 score 변화시 scoreLabel.text 를 변화

## 충돌 감지
- SKPhysicsBody
```
    player = SKSpriteNode(imageNamed: "player")
    player.position = CGPoint(x: 100, y: 384)
    player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
    player.physicsBody?.contactTestBitMask = 1
    addChild(player)

    physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    physicsWorld.contactDelegate = self
```

- disable gravity 하는 기능.
- SKPhysicsContactDelegate 프로토콜이 필요

## timer

- timer 로 특정 오브젝트의 메서드를 시간 종료시 트리거할 수 있다
- `gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)`
- 적들을 만들어내는 스케줄러. scheduledTimer() timer 는 생성과 동시에 시작도 한다


```swift
@objc func createEnemy() {
    guard let enemy = possibleEnemies.randomElement() else { return }

    let sprite = SKSpriteNode(imageNamed: enemy)
    sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
    addChild(sprite)

    sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
    sprite.physicsBody?.categoryBitMask = 1
    sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
    sprite.physicsBody?.angularVelocity = 5
    sprite.physicsBody?.linearDamping = 0
    sprite.physicsBody?.angularDamping = 0
}

override func update(_ currentTime: TimeInterval) {
    for node in children {
        if node.position.x < -300 {
            node.removeFromParent()
        }
    }

    if !isGameOver {
        score += 1
    }
}
```
- linearDamping and angularDamping
- 이동과 회전이 느려지지 않게 한다
- update 를 통해 위치가 -300 이하로 가면 장애물을 없애고 점수를 올리자




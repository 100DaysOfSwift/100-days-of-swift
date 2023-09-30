# SpriteKit
- 애플의 고성능 드로잉 도구
- 지금껏 배운 UIKit의 내용은 도움이 안될 듯 함

# SKSpriteNode, SKPhysicsBody

- ipad 게임을 만들건데, ipad 에뮬레이터가 오래걸리므로, 스펙을 낮추는걸 권장
<img width="822" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/71886579-0f8b-41d1-a41e-6dcc4883ed5f">

- GameScene 필요없는 메서드 및 필드 제거
```swift
import SpriteKit


class GameScene: SKScene {

    override func didMove(to view: SKView) {
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

```

- anchor X,Y=0:0 는 bottom left corner 중심 이동

## 물리학 적용
```swift
box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
// in didMove()
physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

```
- box에, box와 똑같은 크기의 사각형 물리학을 적용
- 전체 GameScene에 scene container 처럼 동작하는 physics body적용

<img width="596" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/50e5e65b-1d6c-4b9b-9d7b-b576596bf739">

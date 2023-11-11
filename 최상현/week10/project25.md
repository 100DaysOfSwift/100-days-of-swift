# p2p networking


```swift
navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))

@objc func showConnectionPrompt() {
    let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
    ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(ac, animated: true)
}
```

- view 에 레프트바 버튼 아이템 추가
- 역할은 연결할지 여부를 묻는 alert노출

- MCSession: 멀티피어 매니저
- MCPeerID : 세션 내 각 유저 id
- MCAdvertiserAssistant : 세션 생성 및 초대 기능 등
- MCBrowserViewController : 주변 상대방이나 세션, 들어오게 하기 등
- `import MultipeerConnectivity`가 필요

```swift
var peerID = MCPeerID(displayName: UIDevice.current.name)
var mcSession: MCSession?
var mcAdvertiserAssistant: MCAdvertiserAssistant?
```

- apple multipeer app은 모두 service type이란 이름을 지어야함
- ex) hws-project25

```swift
func startHosting(action: UIAlertAction) {
    guard let mcSession = mcSession else { return }
    mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "hws-project25", discoveryInfo: nil, session: mcSession)
    mcAdvertiserAssistant?.start()
}

func joinSession(action: UIAlertAction) {
    guard let mcSession = mcSession else { return }
    let mcBrowser = MCBrowserViewController(serviceType: "hws-project25", session: mcSession)
    mcBrowser.delegate = self
    present(mcBrowser, animated: true)
}
```

## MCPeerID

- MCSessionDelegate and MCBrowserViewControllerDelegate protocol은 7개 메서드 구현해야
- 여기선 무시해도되는거 몇개는 empty상태로 두어 구현안함
- 메서드들이 매우 긴데, sessiondidchange 라고 치면, didChange field를 지닌 session method가 자동완성됨

- peer간 데이터 전송. 데이터가 전송되면 didReceive 메서드가 호출됨
- main thread 에서만 UI는 수정되어야한다. 그래서 async 호출
```swift
func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    DispatchQueue.main.async { [weak self] in    
        if let image = UIImage(data: data) {
            self?.images.insert(image, at: 0)
            self?.collectionView.reloadData()
        }
    }
}
// 1 액티브 세션 가져오기
guard let mcSession = mcSession else { return }

// 2 연결된 피어가 있다면
if mcSession.connectedPeers.count > 0 {
    // 3 이미지를 Data오브젝트로 변경
    if let imageData = image.pngData() {
        // 4 피어들에게 보낸뒤 다 받도록 보장 (.reliable)
        do {
            try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable)
        } catch {
            // 5
            let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}
```

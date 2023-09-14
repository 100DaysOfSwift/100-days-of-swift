## Auto Layout

- project2 에서의 rotate 를 수정

<img width="423" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/e5bfb8cd-89b5-4f84-9e42-82500eb31f98">

- 화면 회전해도 바텀에 20 간격을 줌.
<img width="457" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/b1790b83-84e0-42c3-b5af-d148405249ca">

- 국기를 잇고 same height 를 하면 세개 다 같은 높이를 유지
- squash도 다같이 될 것
- 스스로에게 드래그해서 Aspect ratio 를 설정하면 비율이 맞게 크기가 줄여짐

# project6b

- `UILabel` : 고유 텍스트와 배경색을 가짐
- view.addSubView() 를 통해 모두 view controller 에 속해있는 view에 추가


## Auto Layout Visual Format Language (VFL)

- 키보드 심볼과 함께 layout 을 그리는 방법
`let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]`

- `H:|[label1]|`
      - H horizontal
      - pipe : edge of my view

```swift
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label1]|", options: [], metrics: nil, views: viewsDictionary))
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label2]|", options: [], metrics: nil, views: viewsDictionary))
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label3]|", options: [], metrics: nil, views: viewsDictionary))
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label4]|", options: [], metrics: nil, views: viewsDictionary))
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label5]|", options: [], metrics: nil, views: viewsDictionary))
// 아래와 똑같음

for label in viewsDictionary.keys {
    view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
}

```

- `V:|[label1]-[label2]- ....`
- Vertical 로 각 라벨이 정렬. `-`는 10pt 스페이스. | 는 end of screen
- `-(>=10)-` 스페이스 크기가 10 이상이게 하라

- `labelHeight@999` : label at 999. priority 999를 의미하고 매우 중요함 그러나 필수는 아님을 의미

## anchor
```
 widthAnchor, heightAnchor, topAnchor, bottomAnchor, leftAnchor, rightAnchor, leadingAnchor, trailingAnchor, centerXAnchor, and centerYAnchor.
```

- left / leading 앵커는 같다

```swift
		var previous: UILabel?

		for label in [label1, label2, label3, label4, label5] {
			label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
			label.heightAnchor.constraint(equalToConstant: 88).isActive = true

			if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
			}

			previous = label
		}
	}
```

- previous 를 optional로 만든뒤 if let을 이용해 이전의 label과 제약조건을 설정하는걸 주목하자

```swift
else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
                    .isActive = true
            }
```
를 추가해, 노치 디스플레이에서 첫번쨰 라벨이 top거리를 둘 수 있다






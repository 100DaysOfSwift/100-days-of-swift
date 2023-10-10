# core image
- iOS에서 가장 발전된 프레임워크 중 하나
- Apple's high-speed image manipulation toolkit.



# UISlider

- 프로젝트10의 반대를 구현해 보자

- storyboardview controller선택
- Editor -> embed in -> navigation controller

<img width="855" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/b2ae4833-61c4-4f0a-b4f7-8d98f7c77e9a">

- 이상적인 constraint 를 적용

- constraint를 수정하려면 size inspector의 constraint를 클릭해 조절 가능
<img width="653" alt="image" src="https://github.com/100DaysOfSwift/100-days-of-swift/assets/40600306/9d49cacb-f02c-4c2c-b393-0e81b23e9109">


## editing image
- UIImagePickerController 를 쓰려면, 아래처럼 protocol을 추가해야한다
```swift
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
```

- info.plist에서 'ADD ROW' 를 이용해 privacy - photo library addtion 이용 메시지를 추가

# CoreImage CIContext&Filter
```swift
import CoreImage

    var context: CIContext!
    var currentFilter: CIFilter!
    
```

1. context: 렌더링 담당하는 컴포넌트
2. filter: user 가 동작시킨 필터를 담고 있다. 다양한 세팅을 제공함

```swift
//
//  ViewController.swift
//  project13
//
//  Created by 최상현 on 2023/10/10.
//

import CoreImage
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var intensity: UISlider!
    @IBOutlet var imageView: UIImageView!
    var currentImage: UIImage!

    var context: CIContext!
    var currentFilter: CIFilter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "YACIFP"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")

    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        dismiss(animated: true)

        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
        
    }

    @IBAction func changeFilter(_ sender: Any) {
        let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    func setFilter(action: UIAlertAction) {
        // make sure we have a valid image before continuing!
        guard currentImage != nil else { return }

        // safely read the alert action's title
        guard let actionTitle = action.title else { return }

        currentFilter = CIFilter(name: actionTitle)

        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

        applyProcessing()
    }
    @IBAction func save(_ sender: Any) {
    }
    
    @IBAction func intensityChanged(_ sender: Any) {
        applyProcessing()
    }
    
    func applyProcessing() {
        
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)

        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey) }
        if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey) }

//
//
//        currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
//
        if let cgImage = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
            let processedImage = UIImage(cgImage: cgImage)
            imageView.image = processedImage
        }
    }
    
}


```


# image 저장
- `UIImageWriteToSavedPhotosAlbum()`
- give it a UIImage and it will write the image to the photo album.


```swift

    @objc
    func image(_ image: UIImage, didFinishSavingWitgError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
            let ac = UIAlertController(title: "save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            
            
        } else {
            let ac = UIAlertController(title: "saved!", message: "your altered image has benn saved to ur photo", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        
    }
    @IBAction func save(_ sender: Any) {
        guard let image = imageView.image else { return }

        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

    }
```
- 3번째 파라미터는 #selector 여야 한다

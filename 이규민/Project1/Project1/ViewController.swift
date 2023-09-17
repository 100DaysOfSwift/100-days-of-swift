//
//  ViewController.swift
//  project1
//
//  Created by 이규민 on 2023/09/16.
//

import UIKit // this file will reference the iOS user interface toolkit.

class ViewController: UIViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture to load!
                pictures.append(item)
            }
        }
        print(pictures)
    }
}

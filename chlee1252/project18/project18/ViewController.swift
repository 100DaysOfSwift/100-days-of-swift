//
//  ViewController.swift
//  project18
//
//  Created by Changhwan Lee on 2023/11/07.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(1, 2, 3, 4, 5, separator: "-")
//        print("Some Message", terminator: "")
//
//        assert(1 == 1, "Math Failure!")
//        assert(1 == 2, "Math Failure!") // 여기서만 Fail.
        
//        assert(myReallySlowMethod() == true, "The slow method returned false, which is a bad thing.")
        
        for i in 1...100 {
            print("Got number \(i).")
        }
    }


}


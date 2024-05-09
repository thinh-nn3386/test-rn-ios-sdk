//
//  ViewController.swift
//  TestRNSDK
//
//  Created by Nguyen Thinh on 07/05/2024.
//


import UIKit
import RNSDK

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.loadView()
    }
    
    @IBAction func startReactNative(_ sender: Any) {
        let controller = UIViewController()
        controller.view = RNSDK.getReactNativeView(text:"hello from native")
        present(controller, animated: true, completion: nil)
    }
}


//
//  ViewController.swift
//  Pastel
//
//  Created by cruz on 05/05/2017.
//  Copyright (c) 2017 cruz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.borderColor = UIColor.white.withAlphaComponent(0.12).cgColor
            loginButton.layer.borderWidth = 1.0
            loginButton.layer.cornerRadius = 4
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pastelView = PastelView(frame: view.bounds)
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


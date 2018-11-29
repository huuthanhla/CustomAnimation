//
//  ViewController.swift
//  ActivityIndicator
//
//  Created by Thành Lã on 11/29/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController {
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        animationView.animationType = .ballScallRippleMultiple
        animationView.startAnimating()
    }

}


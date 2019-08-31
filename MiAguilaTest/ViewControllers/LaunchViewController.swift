//
//  LaunchViewController.swift
//  MiAguilaTest
//
//  Created by Ricardo Grajales Duque on 8/30/19.
//  Copyright © 2019 Ricardo Grajales Duque. All rights reserved.
//

import UIKit
import Lottie

class LaunchViewController: UIViewController {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var lottieView: LOTAnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        starLaunchAnimation()
    }
    
    func starLaunchAnimation() {
        UIView.animate(withDuration: 1.5, animations: {
            self.iconImage.alpha = 0.0
        }) { (finished) in
            self.lottieView.setAnimation(named: "map-location")
            self.lottieView.loopAnimation = true
            self.lottieView.play()
            UIView.animate(withDuration: 0.5, animations: {
                self.titleLabel.alpha = 1.0
            }, completion: { (finished) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.performSegue(withIdentifier: "homeSegue", sender: nil)
                }
            })
        }
    }
}

//
//  SpeedView.swift
//  MiAguilaTest
//
//  Created by Ricardo Grajales Duque on 8/30/19.
//  Copyright © 2019 Ricardo Grajales Duque. All rights reserved.
//

import UIKit

class SpeedView: UIView {
    
    var borderView: UIView!
    var speedLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = self.frame.height / 2.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = .white
        
        borderView = UIView(frame: CGRect(x: 5, y: 5, width: self.frame.width - 10, height: self.frame.height - 10))
        borderView.layer.cornerRadius = borderView.frame.height / 2.0
        borderView.layer.borderWidth = 4.0
        borderView.layer.borderColor = UIColor.red.cgColor
        
        speedLabel = UILabel(frame: CGRect(x: 10, y: 10, width: self.frame.width - 20, height: self.frame.height - 20))
        speedLabel.font = UIFont.init(name: "Helvetica-Bold", size: 20)
        speedLabel.textAlignment = .center
        speedLabel.numberOfLines = 2
        speedLabel.lineBreakMode = .byTruncatingTail
        self.addSubview(borderView)
        self.addSubview(speedLabel)
    }
    
    public func setSpeedText(speedString: String) {
        speedLabel.text = speedString
    }
}

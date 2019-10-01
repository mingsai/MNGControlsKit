//
//  MNGMultiSegmentControl.swift
//  MNGControlsKit
//
//  Created by Tommie Carter on 9/30/19.
//  Copyright © 2019 MING Technology LLC. All rights reserved.
//

import UIKit

@IBDesignable
class MNGMultiSegmentControl: UIControl {
    var buttons = [UIButton]()
    @IBInspectable
    var borderWidth:CGFloat = 0
    {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable
    var borderColor:UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable
    var commaSeparatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }
    //a callable method
    var didFinishTappingButton:((UIButton)->())!
    var selectedSegmentIndex:Int = 0
    private var selector:UIView!
    @IBInspectable
    var selectorTextColor:UIColor = UIColor.clear
    @IBInspectable
    var selectorColor:UIColor = UIColor.darkGray
    @IBInspectable
    var textColor:UIColor = .lightText
    override func draw(_ rect: CGRect) {
        //auto set border curve
        layer.cornerRadius = frame.height / 2.0
    }
    @IBAction func animateSelectorOnButtonTap(_ sender: UIButton){
        
        if let idx = buttons.firstIndex(of: sender){
            selectedSegmentIndex = idx
        }
        UIView.animate(withDuration: 0.6, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            sender.setTitleColor(self.selectorTextColor, for: .normal)
            self.selector.centerXAnchor.constraint(equalTo: sender.centerXAnchor).isActive = true
            self.layoutIfNeeded()
        }) { (finished) in
            
            self.sendActions(for: .valueChanged)
            self.didFinishTappingButton(sender)
        }
    }
    func updateView(){
        //sanity check for required title property
        guard !commaSeparatedButtonTitles.isEmpty else { return }
        //initialize view
        self.buttons.removeAll()
        self.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        //arrange title array from string
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        //create buttons from titles
        buttonTitles.forEach { (title) in
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(animateSelectorOnButtonTap(_:)), for: .touchUpInside)
            buttons.append(button)
        }
        //create default state
        buttons.first?.setTitleColor(selectorTextColor, for: .normal)
        //add buttons
        let hsv = UIStackView(arrangedSubviews: buttons)
        hsv.axis = .horizontal
        hsv.alignment = .fill
        hsv.distribution = .fillProportionally
        self.addSubview(hsv)
        //add constraints
        hsv.translatesAutoresizingMaskIntoConstraints = false
        hsv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        hsv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        hsv.leadingAnchor.constraint(equalTo: self.leadingAnchor   ).isActive = true
        hsv.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        //add selector
        selector = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width / CGFloat(buttonTitles.count), height: self.frame.height))
        selector.layer.cornerRadius = self.frame.height / 2.0
        selector.layer.backgroundColor = selectorColor.cgColor
        self.addSubview(selector)
    }
}

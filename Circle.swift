//
//  Circle.swift
//  CircleMove
//
//  Created by Quasar on 21.03.2024.
//

import UIKit

 class CircleView: UIView {
    var circleRadius: CGFloat = 50.0
    let labelCircle = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    let initialCircleRadius: CGFloat = 50
    let initialFontSize: CGFloat = 14

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: circleRadius * 2, height: circleRadius * 2))
        setupCircleView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     func setupCircleView() {
        self.center = self.superview?.center ?? CGPoint.zero
        self.layer.cornerRadius = circleRadius
        self.backgroundColor = .red
        self.rotate360Degrees(duration: 2.0, completionDelegate: nil)

        labelCircle.text = "Play"
        labelCircle.textAlignment = .center
        labelCircle.textColor = UIColor.black
        self.addSubview(labelCircle)
        labelCircle.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    }

    func changeSize(by delta: CGFloat) {
        circleRadius += delta
        updateCircle()
        updateLabel()
    }

    func updateCircle() {
        self.frame = CGRect(x: 0, y: 0, width: circleRadius * 2, height: circleRadius * 2)
        self.center = self.superview?.center ?? CGPoint.zero
        self.layer.cornerRadius = circleRadius
    }

    func updateLabel() {
        let scaleFactor = circleRadius / initialCircleRadius
        labelCircle.font = labelCircle.font.withSize(initialFontSize * scaleFactor)
        labelCircle.frame = CGRect(x: 0, y: 0, width: 100 * scaleFactor, height: 100 * scaleFactor)
        labelCircle.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    }
}


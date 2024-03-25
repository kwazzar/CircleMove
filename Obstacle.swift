//
//  Obstacle.swift
//  CircleMove
//
//  Created by Quasar on 22.03.2024.
//

import UIKit

 class ObstacleView: UIView {
    var obstacleHeight: CGFloat = 10.0
    var obstacleWidth: CGFloat = UIScreen.main.bounds.width

    init(yPos: CGFloat) {
        super.init(frame: CGRect(x: UIScreen.main.bounds.width, y: yPos, width: obstacleWidth, height: obstacleHeight))
        self.backgroundColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updatePosition() {
        var frame = self.frame
        frame.origin.x -= 1
        if frame.origin.x + frame.width < 0 {
            frame.origin.x = UIScreen.main.bounds.width
        }
        self.frame = frame
    }
}

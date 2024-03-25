//
//  ObstacleView.swift
//  CircleMove
//
//  Created by Quasar on 22.03.2024.
//

import UIKit

 class ObstacleView: UIView {
   private var obstacleHeight: CGFloat = 10.0
   private var obstacleWidth: CGFloat = UIScreen.main.bounds.width

    init(yPos: CGFloat) {
        super.init(frame: CGRect(x: UIScreen.main.bounds.width, y: yPos, width: obstacleWidth, height: obstacleHeight))
        self.backgroundColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

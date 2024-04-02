//
//  MainVC.swift
//  CircleMove
//
//  Created by Quasar on 21.03.2024.
//

import UIKit

class MainVC: UIViewController {
    var circleView = CircleView()
    var obstacleViews: [ObstacleView] = []
    var collisionCount = 0
    var displayLink: CADisplayLink?
    var lastCollisionTime: Date?
    var collisionCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCircleView()
        setupButtons()
        setupObstacles()
        setupCollisionCountLabel()
    }

    // TЦя функція перевіряє, чи зіткнулося коло з будь-якою з перешкод
    func checkCollision() {
        let circleFrame = circleView.frame
        for obstacleView in obstacleViews {
            if circleFrame.intersects(obstacleView.frame) {
                handleCollision()
            }
        }
    }

    //MARK: createObstacles
    func createObstacles() {
        let obstacleHeight: CGFloat = 10.0

        let buttonArea = CGRect(x: 0, y: self.view.frame.height - 100, width: self.view.frame.width, height: 100)

        for _ in 1...2 {
            var randomYPos = CGFloat(arc4random_uniform(UInt32(self.view.frame.height - obstacleHeight)))

            // Перевірка, чи перетинається область перешкоди з областю кнопок
            while buttonArea.intersects(CGRect(x: 0, y: randomYPos, width: self.view.frame.width, height: obstacleHeight)) {
                randomYPos = CGFloat(arc4random_uniform(UInt32(self.view.frame.height - obstacleHeight)))
            }

            let obstacleView = ObstacleView(yPos: randomYPos)
            self.view.addSubview(obstacleView)
            self.obstacleViews.append(obstacleView)
        }
    }

    private func updateCollisionCountLabel() {
        collisionCountLabel.text = "\(collisionCount)"
    }

    private func updateObstaclePositions() {
        obstacleViews.forEach { obstacle in
            var frame = obstacle.frame
            frame.origin.x -= 1
            if frame.origin.x + frame.width < 0 {
                frame.origin.x = self.view.frame.width
                resetScreen()
            }
            obstacle.frame = frame
        }
    }
    //MARK: Count Collision
    private func handleCollision() {
        if let lastCollisionTime = lastCollisionTime, Date().timeIntervalSince(lastCollisionTime) < 3 {
            return
        }

        collisionCount += 1
        print("circle +1")
        didCollide()
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()

        if collisionCount >= 5 {
            showAlertToResetScreen()
        }
        lastCollisionTime = Date()
    }

    //MARK: AlertController
    private func showAlertToResetScreen() {
        let alert = UIAlertController(title: "Попередження", message: "Необхідно перезапустити екран", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.resetScreen()
            self.circleView.circleRadius = 50.0
            self.circleView.updateCircle()
            self.circleView.updateLabel()
            self.collisionCount = 0
            self.collisionCountLabel.text = "0"
        }))
        self.present(alert, animated: true, completion: nil)
        invalidateDisplayLink()
    }

    private func removeAllObstacles() {
        for obstacle in obstacleViews {
            obstacle.removeFromSuperview()
        }
        obstacleViews.removeAll()
    }

    private func invalidateDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }

    private func setupDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .current, forMode: .default)
    }

    func didCollide() {
        updateCollisionCountLabel()
    }

    func createButton(title: String, action: Selector, position: CGPoint) -> UIButton {
        let button = UIButton(frame: CGRect(x: position.x, y: position.y, width: 40, height: 40))
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
}

//MARK: Setup
extension MainVC {

    private func setupCircleView() {
        circleView.center = self.view.center
        self.view.addSubview(circleView)
    }

    private func setupCollisionCountLabel() {
        collisionCountLabel = UILabel(frame: CGRect(x: 40, y: 40, width: 200, height: 20))
        collisionCountLabel.textColor = .black
        collisionCountLabel.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(collisionCountLabel)
    }

    private func setupObstacles() {
        createObstacles()
        setupDisplayLink()
        checkCollision()
    }

    private func setupButtons() {
        let plusButton = createButton(title: "+", action: #selector(increaseCircleSize), position: CGPoint(x: 20, y: self.view.frame.height - 60))
        let minusButton = createButton(title: "-", action: #selector(decreaseCircleSize), position: CGPoint(x: 80, y: self.view.frame.height - 60))
        let resetButton = createButton(title: "R", action: #selector(resetScreen), position: CGPoint(x: self.view.frame.width - 70, y: self.view.frame.height - 70))

        self.view.addSubview(plusButton)
        self.view.addSubview(minusButton)
        self.view.addSubview(resetButton)
    }
}
//MARK: Objc methods
@objc extension MainVC {
    func update() {
        updateObstaclePositions()
        checkCollision()
    }

    func increaseCircleSize() {
        circleView.changeSize(by: 10)
    }

    func decreaseCircleSize() {
        circleView.changeSize(by: -10)
    }

    //MARK: ResetScreen
    func resetScreen() {
        removeAllObstacles()
        circleView.updateCircle()
        didCollide()
        invalidateDisplayLink()
        createObstacles()
        setupDisplayLink()
    }

}

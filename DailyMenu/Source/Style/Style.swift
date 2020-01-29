//
//  Created by Vladimir on 1/14/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class Style {
    
    static func addBlueCorner(_ vc: UIViewController) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 250))
        view.backgroundColor = Colors.blue.color
        view.alpha = 0.08
        vc.view.addSubview(view)
        view.center = CGPoint(x: vc.view.frame.maxX, y: 0)
        view.transform = CGAffineTransform(rotationAngle: 0.45)
    }
    
    static func addBlueGradient(_ view: UIView) {
        if let gradient = view.subviews.first(where: { $0 is GradientView }) {
            gradient.removeFromSuperview()
        }
        view.insertSubview(
            GradientView(parentView: view,
                         colors: [Colors.blue.color.cgColor, Colors.blue2.color.cgColor],
                         direction: .points(CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 0))),
            at: 0)
    }
    
    static func addBlackGradient(_ view: UIView) {
        if let gradient = view.subviews.first(where: { $0 is GradientView }) {
            gradient.removeFromSuperview()
        }
        view.insertSubview(
            GradientView(parentView: view,
                         colors: [Colors.black.color.cgColor, UIColor.clear.cgColor],
                         direction: .custom([-1, 0.8])),
            at: 0)
    }
    
    static func addWhiteGradient(_ view: UIView) {
        if let gradient = view.subviews.first(where: { $0 is GradientView }) {
            gradient.removeFromSuperview()
        }
        view.insertSubview(
            GradientView(parentView: view,
                         colors: [UIColor.clear.cgColor, Colors.white.color.cgColor],
                         direction: .custom([0, 1])),
            at: 0)
    }
    
}
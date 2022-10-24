//
//  Animation.swift
//  Adding childrens
//
//  Created by Антон on 25.10.2022.
//

import Foundation
import UIKit

final class Animations {
	class func shake(text: UILabel, duration: CFTimeInterval) {
		UINotificationFeedbackGenerator().notificationOccurred(.error)
		let animation = CAKeyframeAnimation()
		animation.keyPath = "position.x"
		animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
		animation.values = [-10.0, 10.0, -5.0, 5.0, 0.0 ]
		animation.duration = duration
		animation.isAdditive = true
		text.layer.add(animation, forKey: "shake")
		text.layer.animation(forKey: "shake")
	}
}

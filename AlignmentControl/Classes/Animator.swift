//
//  Animator.swift
//  AlignmentControl
//
//  Created by workmachine on 12/05/2019.
//

import Foundation

public class Animator {

	public static func zoomIn(_ view: UIView) {

		let animation = CABasicAnimation(keyPath: "transform.scale")
		animation.fromValue = 1.0
		animation.toValue = 0.98
		animation.duration = 0.3
		animation.fillMode = .forwards
		animation.isRemovedOnCompletion = false
		animation.autoreverses = false
		view.layer.add(animation, forKey: "zoomIn")
	}

	public static func zoomOut(_ view: UIView) {

		let animation = CABasicAnimation(keyPath: "transform.scale")
		animation.fromValue = 0.98
		animation.toValue = 1.0
		animation.duration = 0.3
		animation.fillMode = .forwards
		animation.isRemovedOnCompletion = false
		animation.autoreverses = false
		view.layer.add(animation, forKey: "zoomOut")
	}

	public static func none(_ frames: [CGRect], views: [UIView]) {

		for (index, view) in views.enumerated() {
			view.layer.frame = frames[index]
		}
	}

	public static func fade(_ frames: [CGRect], views: [UIView]) {

		for (index, view) in views.enumerated() {

			let positionXKeyPath = "position.x"
			let positionYKeyPath = "position.y"
			let fadeInKeyPath = "opacity"
			let fadeOutKeyPath = "opacity"


			let fadeIn = CABasicAnimation(keyPath: fadeInKeyPath)
			fadeIn.fromValue = 1
			fadeIn.toValue = 0
			fadeIn.duration = 0.15
			fadeIn.isRemovedOnCompletion = false
			fadeIn.fillMode = .forwards

			let positionX = CABasicAnimation(keyPath: positionXKeyPath)
			positionX.fromValue = view.frame.midX
			positionX.toValue =  frames[index].midX
			positionX.beginTime = fadeIn.duration
			positionX.duration = 0.15
			positionX.isRemovedOnCompletion = false
			positionX.fillMode = .forwards

			let positionY = CABasicAnimation(keyPath: positionYKeyPath)
			positionY.fromValue = view.frame.midY
			positionY.toValue =  frames[index].midY
			positionY.beginTime = fadeIn.duration
			positionY.duration = 0.15
			positionY.isRemovedOnCompletion = false
			positionY.fillMode = .forwards

			let fadeOut = CABasicAnimation(keyPath: fadeOutKeyPath)
			fadeOut.fromValue = 0
			fadeOut.toValue = 1
			fadeOut.beginTime = positionX.duration + fadeIn.duration
			fadeOut.duration = 0.15
			fadeOut.isRemovedOnCompletion = false
			fadeOut.fillMode = .forwards

			let group = CAAnimationGroup()
			group.animations = [fadeIn, positionX, positionY, fadeOut]
			group.duration = fadeIn.duration + positionX.duration + fadeOut.duration
			group.isRemovedOnCompletion = false
			group.fillMode = .forwards

			view.layer.add(group, forKey: nil)
		}
	}

	public static func translation(_ frames: [CGRect], views: [UIView], direction: AlignmentDirection, revers: Bool = false) {

		switch direction {
		case .Horizontal:
			for (index, view) in views.enumerated() {

				let positionXKeyPath = "position.x"

				let positionX = CABasicAnimation(keyPath: positionXKeyPath)
				positionX.fromValue = view.frame.midX
				positionX.toValue =  frames[index].midX
				positionX.duration = 0.15

				view.layer.add(positionX, forKey: nil)
				view.layer.frame = frames[index]
			}
		case .Vertical:

			for (index, view) in views.enumerated() {

				let positionXKeyPath = "position.x"
				let positionYKeyPath = "position.y"
				let fromValue = revers ? frames[index].midY + (view.frame.height * 3) : frames[index].midY - (view.frame.height * 3)
				let toValue = revers ? view.frame.midY - (view.frame.height * 3) : view.frame.midY + (view.frame.height * 3)

				let hide = CABasicAnimation(keyPath: positionYKeyPath)
				hide.fromValue = view.frame.midY
				hide.toValue = toValue
				hide.duration = 0.15
				hide.isRemovedOnCompletion = false
				hide.fillMode = .forwards

				let positionX = CABasicAnimation(keyPath: positionXKeyPath)
				positionX.fromValue = view.frame.midX
				positionX.toValue =  frames[index].midX
				positionX.beginTime = hide.duration
				positionX.duration = 0.01
				positionX.isRemovedOnCompletion = false
				positionX.fillMode = .forwards

				let show = CABasicAnimation(keyPath: positionYKeyPath)
				show.fromValue = fromValue
				show.toValue =  frames[index].midY
				show.beginTime = positionX.duration + hide.duration
				show.duration = 0.15
				show.isRemovedOnCompletion = false
				show.fillMode = .forwards

				let group = CAAnimationGroup()
				group.animations = [hide, positionX, show]
				group.duration = hide.duration + positionX.duration + show.duration
				group.isRemovedOnCompletion = false
				group.fillMode = .forwards

				view.layer.add(group, forKey: nil)
			}
		}
	}

	public static func bounce(_ frames: [CGRect], views: [UIView], direction: AlignmentDirection, revers: Bool = false) {

		let phases: (first: CGFloat, second: CGFloat, third: CGFloat) = (0.65, 0.28, 0.02)

		switch direction {
		case .Horizontal:

			for (index, view) in views.enumerated() {

				let revers = frames[index].midX > view.frame.midX
				let distance: (first: CGFloat, second: CGFloat, third: CGFloat) = (frames[index].width * phases.first, frames[index].width * phases.second, frames[index].width * phases.third)

				let position = CAKeyframeAnimation(keyPath: "position.x")
				position.values = [view.frame.midX,
											frames[index].midX,
											frames[index].midX + (revers ? -distance.first : distance.first),
											frames[index].midX,
											frames[index].midX + (revers ? -distance.second : distance.second),
											frames[index].midX,
											frames[index].midX + (revers ? -distance.third : distance.third),
											frames[index].midX]
				position.keyTimes = [0, 0.38, 0.55, 0.72, 0.81, 0.90, 0.95, 1]
				position.duration = 1
				position.beginTime = index == 0 ? 0 : CACurrentMediaTime() + 0.1
				position.timingFunctions = timingFunctions()
				position.isRemovedOnCompletion = true
				position.fillMode = .both

				view.layer.add(position, forKey: nil)
				view.layer.frame = frames[index]
			}

		case .Vertical:

			for (index, view) in views.enumerated() {

				let revers = frames[index].midX > view.frame.midX

				let toValue = revers ? frames[index].midY + (view.frame.height * 3) : frames[index].midY - (view.frame.height * 3)
				let fromValue = revers ? view.frame.midY - (view.frame.height * 3) : view.frame.midY + (view.frame.height * 3)


				let distance: (first: CGFloat, second: CGFloat, third: CGFloat) = (frames[index].height * phases.first, frames[index].height * phases.second, frames[index].height * phases.third)

				let positionY = CABasicAnimation(keyPath: "position.y")
				positionY.fromValue = frames[index].midY
				positionY.toValue = toValue
				positionY.duration = 0.25
				positionY.isRemovedOnCompletion = false
				positionY.fillMode = .forwards

				let positionX = CABasicAnimation(keyPath: "position.x")
				positionX.fromValue = view.frame.midX
				positionX.toValue =  frames[index].midX
				positionX.beginTime = positionY.duration
				positionX.duration = 0.01
				positionX.isRemovedOnCompletion = false
				positionX.fillMode = .forwards

				let show = CAKeyframeAnimation(keyPath: "position.y")
				show.values = [fromValue,
								frames[index].midY,
								frames[index].midY + (revers ? -distance.first : distance.first),
								frames[index].midY,
								frames[index].midY + (revers ? -distance.second : distance.second),
								frames[index].midY,
								frames[index].midY + (revers ? -distance.third : distance.third),
								frames[index].midY]
				show.keyTimes = [0, 0.38, 0.55, 0.72, 0.81, 0.90, 0.95, 1]
				show.duration = 1
				show.timingFunctions = timingFunctions()
				show.beginTime = index == 0 ? positionY.duration + positionX.duration : 0.2
				show.isRemovedOnCompletion = false
				show.fillMode = .forwards

				let group = CAAnimationGroup()
				group.animations = [positionY, positionX, show]
				group.duration = show.duration + show.beginTime + positionY.duration + positionX.duration
				group.isRemovedOnCompletion = false
				group.fillMode = .forwards

				view.layer.add(group, forKey: nil)
				view.layer.frame = frames[index]
			}
		}
	}

	public static func timingFunctions() -> [CAMediaTimingFunction]? {

		return [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn),
				CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut),
				CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn),
				CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut),
				CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn),
				CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut),
				CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn),
				CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
	}
}

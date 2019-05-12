//
//  Animator.swift
//  AlignmentControl
//
//  Created by workmachine on 12/05/2019.
//

import Foundation

class Animator {

	static func zoomIn(_ view: UIView) {

		let animation = CABasicAnimation(keyPath: "transform.scale")
		animation.fromValue = 1.0
		animation.toValue = 0.98
		animation.duration = 0.3
		animation.fillMode = .forwards
		animation.isRemovedOnCompletion = false
		animation.autoreverses = false
		view.layer.add(animation, forKey: "zoomIn")
	}

	static func zoomOut(_ view: UIView) {

		let animation = CABasicAnimation(keyPath: "transform.scale")
		animation.fromValue = 0.98
		animation.toValue = 1.0
		animation.duration = 0.3
		animation.fillMode = .forwards
		animation.isRemovedOnCompletion = false
		animation.autoreverses = false
		view.layer.add(animation, forKey: "zoomOut")
	}

	static func none(_ frames: [CGRect], views: [UIView]) {

		for (index, view) in views.enumerated() {
			view.layer.frame = frames[index]
		}
	}

	static func fade(_ frames: [CGRect], views: [UIView]) {

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

	static func translation(_ frames: [CGRect], views: [UIView], direction: AlignmentDirection) {

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

				let hide = CABasicAnimation(keyPath: positionYKeyPath)
				hide.fromValue = view.frame.midY
				hide.toValue =  frames[index].midY + (view.frame.height * 3)
				hide.duration = 0.25
				hide.isRemovedOnCompletion = false
				hide.fillMode = .forwards

				let positionX = CABasicAnimation(keyPath: positionXKeyPath)
				positionX.fromValue = view.frame.midX
				positionX.toValue =  frames[index].midX
				positionX.beginTime = hide.duration
				positionX.duration = 0.1
				positionX.isRemovedOnCompletion = false
				positionX.fillMode = .forwards

				let show = CABasicAnimation(keyPath: positionYKeyPath)
				show.fromValue = view.frame.midY - (view.frame.height * 3)
				show.toValue =  frames[index].midY
				show.beginTime = positionX.duration + hide.duration
				show.duration = 0.25
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

	static func bounce() {

	}
}

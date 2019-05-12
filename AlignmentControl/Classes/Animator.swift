//
//  Animator.swift
//  AlignmentControl
//
//  Created by workmachine on 12/05/2019.
//

import Foundation

class Animator {

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

	static func translation() {

	}

	static func bounce() {

	}
}

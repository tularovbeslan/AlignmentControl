//
//  ViewController.swift
//  AlignmentControl
//
//  Created by tularovbeslan@gmail.com on 04/16/2019.
//  Copyright (c) 2019 tularovbeslan@gmail.com. All rights reserved.
//

import UIKit
import AlignmentControl

class ViewController: UIViewController {

	@IBOutlet weak var alignView: AlingmentView!
	@IBOutlet weak var contentView: UIView!
	@IBOutlet weak var redView: UIView!

	var axisX: CGFloat = 0
	var axisY: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

		alignView.setBackgroundImage(UIImage(named: "Group"))
        alignView.delegate = self
		alignView.dataSource = self
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

 		contentViewSetup()

		redViewSetup()


	}

	fileprivate func contentViewSetup() {

		let lineDash = CAShapeLayer()
		lineDash.strokeColor = UIColor.black.cgColor
		lineDash.lineDashPattern = [3, 3]
		lineDash.frame = contentView.bounds
		lineDash.fillColor = nil
		lineDash.lineWidth = 2
		lineDash.path = UIBezierPath(roundedRect: contentView.bounds, cornerRadius:  30).cgPath

		contentView.layer.cornerRadius = 30
		contentView.clipsToBounds = true
		contentView.layer.addSublayer(lineDash)
	}

	fileprivate func redViewSetup() {

		redView.layer.cornerRadius = 30
		redView.clipsToBounds = true
		redView.frame = CGRect(x: 0,
							   y: 0,
							   width: contentView.frame.width / 3,
							   height: contentView.frame.height / 3)
	}
}

extension ViewController: AlingmentViewDelegate {
    
	func didSelectOptionFor(_ aligment: AlignmentMode) {
		switch aligment {
		case .Left:
			axisX = 0
			UIView.animate(withDuration: 0.3) {
				self.redView.transform = CGAffineTransform(translationX: self.axisX, y: self.axisY)
			}
		case .Center:
			axisX = (self.contentView.frame.width / 2) -  (self.redView.frame.width / 2)
			UIView.animate(withDuration: 0.3) {
				self.redView.transform = CGAffineTransform(translationX: self.axisX, y: self.axisY)
			}
		case .Right:
			axisX = self.contentView.frame.width - self.redView.frame.width
			UIView.animate(withDuration: 0.3) {
				self.redView.transform = CGAffineTransform(translationX: self.axisX, y: self.axisY)
			}
		case .Top:
			axisY = 0
			UIView.animate(withDuration: 0.3) {
				self.redView.transform = CGAffineTransform(translationX: self.axisX, y: self.axisY)
			}
		case .Middle:
			axisY = (self.contentView.frame.height / 2) -  (self.redView.frame.height / 2)

			UIView.animate(withDuration: 0.3) {
				self.redView.transform = CGAffineTransform(translationX: self.axisX, y: self.axisY)
			}
		case .Bottom:
			axisY = self.contentView.frame.height - self.redView.frame.height

			UIView.animate(withDuration: 0.3) {
				self.redView.transform = CGAffineTransform(translationX: self.axisX, y: self.axisY)
			}
		}
	}
}

extension ViewController: AlingmentViewDataSource {

	func optionsForAlignment() -> [AlignmentMode] {
		return [.Left, .Center, .Right, .Top, .Middle, .Bottom]
	}
}

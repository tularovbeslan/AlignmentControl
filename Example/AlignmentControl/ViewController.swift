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

    override func viewDidLoad() {
        super.viewDidLoad()

		alignView.setBackgroundImage(UIImage(named: "Group"))
        alignView.delegate = self
		alignView.dataSource = self
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)



		let lineDash = CAShapeLayer()
		lineDash.strokeColor = UIColor.lightText.cgColor
		lineDash.lineDashPattern = [3, 3]
		lineDash.frame = contentView.bounds
		lineDash.fillColor = nil
		lineDash.lineWidth = 2
		lineDash.path = UIBezierPath(roundedRect: contentView.bounds, cornerRadius:  30).cgPath

		contentView.layer.cornerRadius = 30
		contentView.clipsToBounds = true
		contentView.layer.addSublayer(lineDash)

	}
}

extension ViewController: AlingmentViewDelegate {
    
	func didSelectOptionFor(_ aligment: AlignmentMode) {
		print(String(describing: aligment))
	}
}

extension ViewController: AlingmentViewDataSource {

	func optionsForAlignment() -> [AlignmentMode] {
		return [.Left, .Center, .Right, .Top, .Middle, .Bottom]
	}
}

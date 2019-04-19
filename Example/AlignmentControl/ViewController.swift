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

    override func viewDidLoad() {
        super.viewDidLoad()

		alignView.setBackgroundImage(UIImage(named: "Group"))
        alignView.delegate = self
		alignView.dataSource = self
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

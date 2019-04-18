//
//  AlingmentView.swift
//  AlignmentControl
//
//  Created by workmachine on 16/04/2019.
//

import UIKit

class AlingmentView: UIView {

	var alignmentModes: [AlignmentMode] = [.Left, .Center, .Right, .Top, .Middle, .Bottom]

	override func awakeFromNib() {
		super.awakeFromNib()

		setupItems()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	fileprivate func setupItems() {

		for (index, alignmentMode) in alignmentModes.enumerated() {

			let itemWidth: CGFloat = (frame.width / CGFloat(alignmentModes.count)) * 0.8

			let length: CGFloat = (frame.height > itemWidth ? itemWidth : frame.height) * 0.8

			let padding =  (frame.width - (length * CGFloat(alignmentModes.count))) / CGFloat(alignmentModes.count + 1)
			let offset: CGFloat = ((padding + length) * CGFloat(index)) + padding

			let width: CGFloat = length
			let height: CGFloat = length

			let item = AlingmentItemView(alignmentMode)
			addSubview(item)

			item.translatesAutoresizingMaskIntoConstraints = false
			item.leftAnchor.constraint(equalTo: leftAnchor, constant: offset).isActive = true
			item.widthAnchor.constraint(equalToConstant: width).isActive = true
			item.heightAnchor.constraint(equalToConstant: height).isActive = true
			item.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

			item.backgroundColor = .white
		}
	}
}

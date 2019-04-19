//
//  AlingmentView.swift
//  AlignmentControl
//
//  Created by workmachine on 16/04/2019.
//

import UIKit

open class AlingmentView: UIView {

	open weak var delegate: AlingmentViewDelegate?

	open weak var dataSource: AlingmentViewDataSource? {
		didSet {
			alignmentModes = dataSource?.optionsForAlignment()
			for item in items {
				item.delegate = delegate
			}
		}
	}

	private var alignmentModes: [AlignmentMode]? {
		didSet {
			setupItems()
		}
	}

    private var items: [AlingmentItemView] = []

	fileprivate var backgroundImage: UIImageView = {

		let imageView: UIImageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	open func setBackgroundImage(_ image: UIImage?) {
		backgroundImage.image = image
	}

	override open func awakeFromNib() {
		super.awakeFromNib()

		addSubview(backgroundImage)
		setupBackgroundImageConstraints()
		setupItems()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		addSubview(backgroundImage)
		setupBackgroundImageConstraints()
		setupItems()
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	fileprivate func setupBackgroundImageConstraints() {

		backgroundImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
		backgroundImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		backgroundImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}

	fileprivate func setupItems() {

		guard let modes = alignmentModes else { return }
		let count = CGFloat(modes.count)
		for (index, alignmentMode) in modes.enumerated() {

			let itemWidth: CGFloat = (frame.width / count)

			let length: CGFloat = (frame.height > itemWidth ? itemWidth : frame.height) * 0.80

			let padding =  (frame.width - (length * count)) / count
			let offset: CGFloat = ((padding + length) * CGFloat(index)) + (padding / 2)

			let width: CGFloat = length
			let height: CGFloat = length

			let item = AlingmentItemView(alignmentMode)
			addSubview(item)
			items.append(item)

			item.translatesAutoresizingMaskIntoConstraints = false
			item.leftAnchor.constraint(equalTo: leftAnchor, constant: offset).isActive = true
			item.widthAnchor.constraint(equalToConstant: width).isActive = true
			item.heightAnchor.constraint(equalToConstant: height).isActive = true
			item.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

			item.backgroundColor = .clear
		}
	}
}

public protocol AlingmentViewDelegate: class {
	func didSelectOptionFor(_ aligment: AlignmentMode)
}

public protocol AlingmentViewDataSource: class {
	func optionsForAlignment() -> [AlignmentMode]
}

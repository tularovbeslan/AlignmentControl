//
//  AlingmentView.swift
//  AlignmentControl
//

import UIKit

open class AlingmentView: UIView {

	open weak var delegate: AlingmentViewDelegate?

	open weak var dataSource: AlingmentViewDataSource? {
		didSet {
			alignmentModes = dataSource?.optionsForAlignment()
		}
	}

	private var alignmentModes: [AlignmentMode]? {
		didSet {
			setupItems()
		}
	}

	var activeAligmentView: AlingmentItemView! {
		didSet {

			//			if activeAligmentView == oldValue { return }
			//			if oldValue != nil {
			//				oldValue.hideAnimation()
			//			}
			//			activeAligmentView.presentAnimation()
		}
	}

	private var items: [AlingmentItemView] = []

	public var colorOfWards: UIColor = UIColor(red: 220/255.0, green: 224/255.0, blue: 236/255.0, alpha: 1)

	fileprivate var backgroundImage: UIImageView = {

		let imageView: UIImageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	open func setBackgroundImage(_ image: UIImage?) {
		backgroundImage.image = image
	}

	fileprivate var pulseAnimation: CASpringAnimation?

	override open func awakeFromNib() {
		super.awakeFromNib()

		self.clipsToBounds = true
		addSubview(backgroundImage)
		setupBackgroundImageConstraints()
		setupItems()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.clipsToBounds = true
		addSubview(backgroundImage)
		setupBackgroundImageConstraints()
		setupItems()
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	// MARK: - Private

	func zoomIn() {

		let animation = CABasicAnimation(keyPath: "transform.scale")
		animation.fromValue = 1.0
		animation.toValue = 0.98
		animation.duration = 0.3
		animation.fillMode = .forwards
		animation.isRemovedOnCompletion = false
		animation.autoreverses = false
		layer.add(animation, forKey: "zoomIn")
	}

	func zoomOut() {

		let animation = CABasicAnimation(keyPath: "transform.scale")
		animation.fromValue = 0.98
		animation.toValue = 1.0
		animation.duration = 0.3
		animation.fillMode = .forwards
		animation.isRemovedOnCompletion = false
		animation.autoreverses = false
		layer.add(animation, forKey: "zoomOut")
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
			item.parentView = self
			item.delegate = delegate
			item.colorOfWards = colorOfWards
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

public enum AlignmentMode: Int, CaseIterable {
	case Left, Center, Right, Top, Middle, Bottom
}

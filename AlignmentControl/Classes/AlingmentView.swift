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

	public var activeAligmentModes: [AlignmentMode] = [.Left]
	public var animation: AnimationType = .Bounce
	public var isPulse: Bool = true
	private var horizontalMiddleWard: UIView!
	private var horizontalShortWard: UIView!
	private var verticalMiddleWard: UIView!
	private var verticalShortWard: UIView!
	fileprivate var currentVerticalIndex: Int = 0

	private var items: [AlingmentItemView] = []

	public var colorOfWards: UIColor = UIColor(red: 220/255.0, green: 224/255.0, blue: 236/255.0, alpha: 1)

	fileprivate var backgroundImage: UIImageView = {

		let imageView: UIImageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	fileprivate func frameForWards(_ item: AlingmentItemView) -> (middle: CGRect, short: CGRect)? {

		guard let modes = alignmentModes else { return nil }
		let count = CGFloat(modes.count)

		let itemWidth: CGFloat = (frame.width / count)
		let topPadding: CGFloat =  (frame.height - (frame.height > itemWidth ? itemWidth : frame.height) * 0.80) / 2
		let length: CGFloat = (frame.height > itemWidth ? itemWidth : frame.height) * 0.80
		let padding =  (frame.width - (length * count)) / count
		let offset: CGFloat = ((padding + length) * CGFloat(item.index)) + (padding / 2)

		let middleWardPathFrame = convert(item.middleWardPath.cgPath.boundingBox, to: self)
		let shortWardPathFrame = convert(item.shortWardPath.cgPath.boundingBox, to: self)

		let middleFrame = CGRect(x: middleWardPathFrame.origin.x + offset, y: middleWardPathFrame.origin.y + topPadding, width: middleWardPathFrame.width, height: middleWardPathFrame.height)

		let shortFrame = CGRect(x: shortWardPathFrame.origin.x + offset, y: shortWardPathFrame.origin.y + topPadding, width: shortWardPathFrame.width, height: shortWardPathFrame.height)

		return (middle: middleFrame, short: shortFrame)
	}

	fileprivate func createWardsFor(_ item: AlingmentItemView) -> (middle: UIView, short: UIView)? {

		guard let frame = frameForWards(item) else { return nil }

		let middle = UIView()
		middle.frame = frame.middle
		middle.backgroundColor = UIColor.red
		middle.layer.cornerRadius = item.middleWardRadius
		middle.clipsToBounds = true
		middle.isUserInteractionEnabled = false

		let short = UIView()
		short.frame = frame.short
		short.backgroundColor = UIColor.red
		short.layer.cornerRadius = item.shortWardRadius
		short.clipsToBounds = true
		short.isUserInteractionEnabled = false

		return (middle: middle, short: short)
	}

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

		if !frame.isEmpty {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
				self.createActiveWards()
			}
		}
	}

	public override init(frame: CGRect) {
		super.init(frame: frame)

		self.clipsToBounds = true
		addSubview(backgroundImage)
		setupBackgroundImageConstraints()
		setupItems()

		if !frame.isEmpty {

			DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
				self.createActiveWards()
			}
		}
	}

	convenience init(activeAligmentModes: [AlignmentMode], animation: AnimationType, frame: CGRect) {
		self.init(frame: frame)

		self.activeAligmentModes = activeAligmentModes
		self.animation = animation
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}


	// MARK: - Private

	func zoomIn() {
		Animator.zoomIn(self)
	}

	func zoomOut() {
		Animator.zoomOut(self)
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
		for (index, mode) in modes.enumerated() {

			let itemWidth: CGFloat = (frame.width / count)

			let length: CGFloat = (frame.height > itemWidth ? itemWidth : frame.height) * 0.80

			let padding =  (frame.width - (length * count)) / count
			let offset: CGFloat = ((padding + length) * CGFloat(index)) + (padding / 2)

			let width: CGFloat = length
			let height: CGFloat = length

			let item = AlingmentItemView()
			item.mode = mode
			item.index = index
			item.delegate = self
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

	/// Create UIView for all active modes
	fileprivate func createActiveWards() {

		activeAligmentModes.forEach { (mode) in

			items.forEach({ (item) in

				if item.mode == mode {

					guard let wards: (middle: UIView, short: UIView) = createWardsFor(item) else { return }

					switch item.direction {
					case .Horizontal:
						horizontalMiddleWard = wards.middle
						horizontalShortWard = wards.short
						addSubview(horizontalMiddleWard)
						addSubview(horizontalShortWard)

					case .Vertical:
						verticalMiddleWard = wards.middle
						verticalShortWard = wards.short
						addSubview(verticalMiddleWard)
						addSubview(verticalShortWard)
					}
				}
			})
		}
	}
}

extension AlingmentView: AlingmentItemViewDelegate {

	public func touchesBegan() {
		if isPulse { zoomIn() }
	}

	public func touchesEnded() {
		if isPulse { zoomOut() }
	}

	public func didSelectOptionFor(_ alingmentItemView: AlingmentItemView, mode: AlignmentMode) {
		delegate?.didSelectOptionFor(mode)

		guard let frame = frameForWards(alingmentItemView) else { return }

		switch animation {
		case .None: noneAnimation(frame, view: alingmentItemView)
		case .Fade: fadeAnimation(frame, view: alingmentItemView)
		case .Translation: transitionAnimation(frame, view: alingmentItemView)
		case .Bounce: bounceAnimation(frame, view: alingmentItemView)
		}
	}

	// MARK: - None Animation
	fileprivate func noneAnimation(_ frame: (middle: CGRect, short: CGRect), view: AlingmentItemView) {

		guard let frame = frameForWards(view) else { return }

		switch view.direction {
		case .Horizontal:
			Animator.none([frame.middle, frame.short],
						  views: [horizontalMiddleWard, horizontalShortWard])
		case .Vertical:
			Animator.none([frame.middle, frame.short],
						  views: [verticalMiddleWard, verticalShortWard])
		}
	}

	// MARK: - Fade Animation
	fileprivate func fadeAnimation(_ frame: (middle: CGRect, short: CGRect), view: AlingmentItemView) {

		guard let frame = frameForWards(view) else { return }

		switch view.direction {
		case .Horizontal:
			Animator.fade([frame.middle, frame.short],
						  views: [horizontalMiddleWard, horizontalShortWard])
		case .Vertical:
			Animator.fade([frame.middle, frame.short],
						  views: [verticalMiddleWard, verticalShortWard])
		}
	}

	// MARK: - Transition Animation
	fileprivate func transitionAnimation(_ frame: (middle: CGRect, short: CGRect), view: AlingmentItemView) {
		switch view.direction {
		case .Horizontal:
			Animator.translation([frame.middle, frame.short],
								 views: [horizontalMiddleWard, horizontalShortWard], direction: .Horizontal, contentView: self)
		case .Vertical:

			let revers = view.index < currentVerticalIndex
			Animator.translation([frame.middle, frame.short],
								 views: [verticalMiddleWard, verticalShortWard], direction: .Vertical, revers:  revers, contentView: self)
			currentVerticalIndex = view.index
		}
	}

	// MARK: - Bounce Animation
	fileprivate func bounceAnimation(_ frame: (middle: CGRect, short: CGRect), view: AlingmentItemView) {

		let revers = view.index > currentVerticalIndex

		switch view.direction {
		case .Horizontal:
			Animator.bounce([frame.middle, frame.short],
							views: [horizontalMiddleWard, horizontalShortWard],
							direction: .Horizontal, contentView: self)
		case .Vertical:

			Animator.bounce([frame.middle, frame.short],
							views: [verticalMiddleWard, verticalShortWard],
							direction: .Vertical, revers:  revers, contentView: self)
			currentVerticalIndex = view.index
		}
	}
}


public protocol AlingmentViewDelegate: class {
	func didSelectOptionFor(_ mode: AlignmentMode)
}

public protocol AlingmentViewDataSource: class {
	func optionsForAlignment() -> [AlignmentMode]
}

public enum AlignmentMode: Int, CaseIterable {
	case Left, Center, Right, Top, Middle, Bottom
}

public 	enum AnimationType {
	case Fade, Translation, Bounce, None
}

public enum AlignmentDirection: Int, CaseIterable {
	case Horizontal, Vertical
}

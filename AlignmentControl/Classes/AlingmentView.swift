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

   var activeAligmentX: AlingmentItemView? {
        
        didSet {
            guard let oldValue = oldValue else { return }
            
            if oldValue.alignment == .Left
                && activeAligmentX?.alignment == .Center {
                oldValue.leftToCenter()
                activeAligmentX?.leftToCenter()
            }
            if oldValue.alignment == .Center
                && activeAligmentX?.alignment == .Left {
                oldValue.centerToLeft()
                activeAligmentX?.centerToLeft()
            }
            if oldValue.alignment == .Center
                && activeAligmentX?.alignment == .Right {
                oldValue.centerToRight()
                activeAligmentX?.centerToRight()
            }
            if oldValue.alignment == .Right
                && activeAligmentX?.alignment == .Center {
                oldValue.rightToCenter()
                activeAligmentX?.rightToCenter()
            }
            if oldValue.alignment == .Right
                && activeAligmentX?.alignment == .Left {
                oldValue.rightToLeft()
                if let center = aligmentItems.first(where: { $0.alignment == .Center }) {
                    center.rightToLeft()
                }
                activeAligmentX?.rightToLeft()
            }
            if oldValue.alignment == .Left
                && activeAligmentX?.alignment == .Right {
                oldValue.leftToRight()
                if let center = aligmentItems.first(where: { $0.alignment == .Center }) {
                    center.leftToRight()
                }
                activeAligmentX?.leftToRight()
            }
        }
    }
    
    var activeAligmentY: AlingmentItemView? {
        
        didSet {
            guard let oldValue = oldValue else { return }
            
            if oldValue.alignment == .Top
                && activeAligmentY?.alignment == .Middle {
                oldValue.topToMiddle()
                activeAligmentY?.topToMiddle()
            }
            if oldValue.alignment == .Middle
                && activeAligmentY?.alignment == .Top {
                oldValue.middleToTop()
                activeAligmentY?.middleToTop()
            }
            if oldValue.alignment == .Middle
                && activeAligmentY?.alignment == .Bottom {
                oldValue.middleToBottom()
                activeAligmentY?.middleToBottom()
            }
            if oldValue.alignment == .Bottom
                && activeAligmentY?.alignment == .Middle {
                oldValue.bottomToMiddle()
                activeAligmentY?.bottomToMiddle()
            }
            if oldValue.alignment == .Bottom
                && activeAligmentY?.alignment == .Top {
                oldValue.bottomToTop()
                if let center = aligmentItems.first(where: { $0.alignment == .Middle }) {
                    center.bottomToTop()
                }
                activeAligmentY?.bottomToTop()
            }
            if oldValue.alignment == .Top
                && activeAligmentY?.alignment == .Bottom {
                oldValue.topToBottom()
                if let center = aligmentItems.first(where: { $0.alignment == .Middle }) {
                    center.topToBottom()
                }
                activeAligmentY?.topToBottom()
            }
        }
    }

	private var aligmentItems: [AlingmentItemView] = []

	public var colorOfWards: UIColor = UIColor(red: 220/255.0, green: 224/255.0, blue: 236/255.0, alpha: 1)
    
    public var activeColorOfWards: UIColor = UIColor(red: 255/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)

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
    
    // MARK: - Animation
    
    private enum ZoomAnimation {
        static let duration = 0.3
        static let normalValue = 1.0
        static let inValue = 0.98
    }
    
	func zoomIn() {

		let animation = CABasicAnimation(keyPath: "transform.scale")
		animation.fromValue = ZoomAnimation.normalValue
		animation.toValue = ZoomAnimation.inValue
		animation.duration = ZoomAnimation.duration
		animation.fillMode = .forwards
		animation.isRemovedOnCompletion = false
		animation.autoreverses = false
		layer.add(animation, forKey: "zoomIn")
	}

	func zoomOut() {

		let animation = CABasicAnimation(keyPath: "transform.scale")
		animation.fromValue = ZoomAnimation.inValue
		animation.toValue = ZoomAnimation.normalValue
		animation.duration = ZoomAnimation.duration
		animation.fillMode = .forwards
		animation.isRemovedOnCompletion = false
		animation.autoreverses = false
		layer.add(animation, forKey: "zoomOut")
	}

    // MARK: - Setup
    
	fileprivate func setupBackgroundImageConstraints() {

		backgroundImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
		backgroundImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		backgroundImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}

	fileprivate func setupItems() {

		guard let modes = alignmentModes else { return }
		let count = CGFloat(modes.count)
        
        let itemWidth: CGFloat = (frame.width / count)
        let length: CGFloat = (frame.height > itemWidth ? itemWidth : frame.height) * 0.80
        let padding =  (frame.width - (length * count)) / count
        let width: CGFloat = length
        let height: CGFloat = length
        
		for (index, mode) in modes.enumerated() {

           let item = makeAligmentItem(mode)
			addSubview(item)
			aligmentItems.append(item)

            setupDefaultActiveItem(item)
          
            let offset: CGFloat = ((padding + length) * CGFloat(index)) + (padding / 2)
            item.translatesAutoresizingMaskIntoConstraints = false
            item.leftAnchor.constraint(equalTo: leftAnchor, constant: offset).isActive = true
            item.widthAnchor.constraint(equalToConstant: width).isActive = true
            item.heightAnchor.constraint(equalToConstant: height).isActive = true
            item.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

			item.backgroundColor = .clear
		}
	}
    
    fileprivate func makeAligmentItem(_ mode: AlignmentMode) -> AlingmentItemView {
        
        let item = AlingmentItemView(mode)
        item.parentView = self
        item.delegate = delegate
        item.colorOfWards = colorOfWards
        item.activeColorOfWards = activeColorOfWards
        return item
    }
    
    fileprivate func setupDefaultActiveItem(_ item: AlingmentItemView) {
        
        switch item.alignment {
        case .Left:
            activeAligmentX = item
        case .Top:
            activeAligmentY = item
        default:
            break
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

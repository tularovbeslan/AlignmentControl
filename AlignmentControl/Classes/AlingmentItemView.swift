//
//  AlingmentItemView.swift
//  AlignmentControl
//
//  Created by workmachine on 16/04/2019.
//

import UIKit

@IBDesignable
class AlingmentItemView: UIView {

	weak var delegate: AlingmentViewDelegate?

	unowned var parentView: AlingmentView!

	public var colorOfWards: UIColor!

    public var activeColorOfWards: UIColor!
    
	var alignment: AlignmentMode = .Left

	fileprivate var activeMiddleWard: CAShapeLayer!
    fileprivate var activeShortWard: CAShapeLayer!
    
    fileprivate var animator: Animationable!
    
	fileprivate var longWardPath: UIBezierPath!
	private var middleWardPath: UIBezierPath!
	fileprivate var shortWardPath: UIBezierPath!

	private var longWardWidth: CGFloat {

		switch alignment {
		case .Left, .Center, .Right: return frame.width * 0.10
		case .Top, .Middle, .Bottom: return frame.width
		}
	}

	private var longWardHeight: CGFloat {

		switch alignment {
		case .Left, .Center, .Right: return frame.height
		case .Top, .Middle, .Bottom: return frame.height * 0.10
		}
	}

	private var longWardRadius: CGFloat { return longWardWidth * 0.3 }

	private var middleWardWidth: CGFloat {

		switch alignment {
		case .Left, .Center, .Right: return frame.width * 0.60
		case .Top, .Middle, .Bottom: return frame.height / 5
		}
	}

	private var middleWardHeight: CGFloat {

		switch alignment {
		case .Left, .Center, .Right: return frame.height / 5
		case .Top, .Middle, .Bottom: return frame.height * 0.60
		}
	}

	private var middleWardRadius: CGFloat { return (frame.height / 5) * 0.3 }

	private var shortWardWidth: CGFloat {

		switch alignment {
		case .Left, .Center, .Right: return frame.width * 0.40
		case .Top, .Middle, .Bottom: return frame.height / 5
		}
	}

	private var shortWardHeight: CGFloat {

		switch alignment {
		case .Left, .Center, .Right: return frame.height / 5
		case .Top, .Middle, .Bottom: return frame.height * 0.40
		}
	}

	private var shortWardRadius: CGFloat { return (frame.height / 5) * 0.3 }

	override init(frame: CGRect) {
		super.init(frame: frame)

	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

	}

	convenience init(_ alignment: AlignmentMode) {
		self.init()

		self.alignment = alignment
        switch alignment {
        case .Left, .Center, .Right:
            self.clipsToBounds = true
            
        default:
            break
        }
        
	}

	// MARK: - Private

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		parentView.zoomIn()
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

		parentView.zoomOut()
        setActiveAligment()
		if let delegate = delegate {
			delegate.didSelectOptionFor(alignment)
		}
	}
    
	override func draw(_ rect: CGRect) {
		super.draw(rect)

		switch alignment {
		case .Left: drawLeft(frame: rect)
		case .Center: drawCenter(frame: rect)
		case .Right: drawRight(frame: rect)
		case .Top: drawTop(frame: rect)
		case .Middle: drawMiddle(frame: rect)
		case .Bottom: drawBottom(frame: rect)
		}
        
        makeActiveWard(middle: middleWardPath, short: shortWardPath)
        makeAnimator()
	}

	func drawLeft(frame: CGRect = CGRect(x: 0, y: 0, width: 48, height: 48)) {

		longWardPath = UIBezierPath(roundedRect: CGRect(x: frame.width * 0.10,
														y: 0,
														width: longWardWidth,
														height: longWardHeight),
									cornerRadius: longWardRadius)
		colorOfWards.setFill()
		longWardPath.fill()

		middleWardPath = UIBezierPath(roundedRect: CGRect(x: frame.width * 0.3,
														  y: (frame.height / 6) * 1.4,
														  width: middleWardWidth,
														  height: middleWardHeight),
									  cornerRadius: middleWardRadius)
		colorOfWards.setFill()
		middleWardPath.fill()

		shortWardPath = UIBezierPath(roundedRect: CGRect(x: frame.width * 0.3,
														 y: (frame.height / 6) * 3.4,
														 width: shortWardWidth,
														 height: shortWardHeight),
									 cornerRadius: shortWardRadius)
		colorOfWards.setFill()
		shortWardPath.fill()
	}

	func drawCenter(frame: CGRect = CGRect(x: 0, y: 0, width: 48, height: 48)) {

		longWardPath = UIBezierPath(roundedRect: CGRect(x: frame.width * 0.45,
														y: 0,
														width: longWardWidth,
														height: longWardHeight),
									cornerRadius: longWardRadius)
		colorOfWards.setFill()
		longWardPath.fill()

		middleWardPath = UIBezierPath(roundedRect: CGRect(x: (frame.width - middleWardWidth) / 2,
														  y: (frame.height / 6) * 1.4,
														  width: middleWardWidth,
														  height: middleWardHeight),
									  cornerRadius: middleWardRadius)
		colorOfWards.setFill()
		middleWardPath.fill()

		shortWardPath = UIBezierPath(roundedRect: CGRect(x: (frame.width - shortWardWidth) / 2,
														 y: (frame.height / 6) * 3.4,
														 width: shortWardWidth,
														 height: shortWardHeight),
									 cornerRadius: shortWardRadius)
		colorOfWards.setFill()
		shortWardPath.fill()
	}


	func drawRight(frame: CGRect = CGRect(x: 0, y: 0, width: 48, height: 48)) {

		longWardPath = UIBezierPath(roundedRect: CGRect(x: frame.width * 0.80,
														y: 0,
														width: longWardWidth,
														height: longWardHeight),
									cornerRadius: longWardRadius)
		colorOfWards.setFill()
		longWardPath.fill()

		middleWardPath = UIBezierPath(roundedRect: CGRect(x: frame.width * 0.10,
														  y: (frame.height / 6) * 1.4,
														  width: middleWardWidth,
														  height: middleWardHeight),
									  cornerRadius: middleWardRadius)
		colorOfWards.setFill()
		middleWardPath.fill()

		shortWardPath = UIBezierPath(roundedRect: CGRect(x: frame.width * 0.30,
														 y: (frame.height / 6) * 3.4,
														 width: shortWardWidth,
														 height: shortWardHeight),
									 cornerRadius: shortWardRadius)
		colorOfWards.setFill()
		shortWardPath.fill()
	}


	func drawTop(frame: CGRect = CGRect(x: 0, y: 0, width: 48, height: 48)) {

		longWardPath = UIBezierPath(roundedRect: CGRect(x: 0,
														y: frame.height * 0.10,
														width: longWardWidth,
														height: longWardHeight),
									cornerRadius: longWardRadius)
		colorOfWards.setFill()
		longWardPath.fill()

		middleWardPath = UIBezierPath(roundedRect: CGRect(x: (frame.width / 6) * 1.4,
														  y: frame.height * 0.30,
														  width: middleWardWidth,
														  height: middleWardHeight),
									  cornerRadius: middleWardRadius)
		colorOfWards.setFill()
		middleWardPath.fill()

		shortWardPath = UIBezierPath(roundedRect: CGRect(x: (frame.width / 6) * 3.4,
														 y: frame.height * 0.30,
														 width: shortWardWidth,
														 height: shortWardHeight),
									 cornerRadius: shortWardRadius)
		colorOfWards.setFill()
		shortWardPath.fill()
	}

	func drawMiddle(frame: CGRect = CGRect(x: 0, y: 0, width: 48, height: 48)) {

		longWardPath = UIBezierPath(roundedRect: CGRect(x: 0,
														y: frame.height * 0.45,
														width: longWardWidth,
														height: longWardHeight),
									cornerRadius: longWardRadius)
		colorOfWards.setFill()
		longWardPath.fill()

		middleWardPath = UIBezierPath(roundedRect: CGRect(x: (frame.width / 6) * 1.4,
														  y: (frame.height - middleWardHeight) / 2,
														  width: middleWardWidth,
														  height: middleWardHeight),
									  cornerRadius: middleWardRadius)
		colorOfWards.setFill()
		middleWardPath.fill()

		shortWardPath = UIBezierPath(roundedRect: CGRect(x: (frame.width / 6) * 3.4,
														 y: (frame.height - shortWardHeight) / 2,
														 width: shortWardWidth,
														 height: shortWardHeight),
									 cornerRadius: shortWardRadius)
		colorOfWards.setFill()
		shortWardPath.fill()
	}

	func drawBottom(frame: CGRect = CGRect(x: 0, y: 0, width: 48, height: 48)) {

		longWardPath = UIBezierPath(roundedRect: CGRect(x: 0,
														y: frame.height * 0.80,
														width: longWardWidth,
														height: longWardHeight),
									cornerRadius: longWardRadius)
		colorOfWards.setFill()
		longWardPath.fill()

		middleWardPath = UIBezierPath(roundedRect: CGRect(x: (frame.width / 6) * 1.4,
														  y: (frame.height * 0.40) - (frame.height * 0.30),
														  width: middleWardWidth,
														  height: middleWardHeight),
									  cornerRadius: middleWardRadius)
		colorOfWards.setFill()
		middleWardPath.fill()

		shortWardPath = UIBezierPath(roundedRect: CGRect(x: (frame.width / 6) * 3.4,
														 y: (frame.height * 0.60) - (frame.height * 0.30),
														 width: shortWardWidth,
														 height: shortWardHeight),
									 cornerRadius: shortWardRadius)
		colorOfWards.setFill()
		shortWardPath.fill()
	}
    
    fileprivate func setActiveAligment() {
        
        switch alignment {
        case .Left, .Center, .Right:
            parentView.activeAligmentX = self
            
        default:
            parentView.activeAligmentY = self
        }
    }
}

extension AlingmentItemView {

    // MARK: - Create active ward
    
    fileprivate func makeActiveWard(middle: UIBezierPath,
                                    short: UIBezierPath) {
        
        activeMiddleWard = makeShapeLayer(middle)
        activeShortWard = makeShapeLayer(short)
    }
    
    private func makeShapeLayer(_ ward: UIBezierPath) -> CAShapeLayer {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = ward.cgPath
        shapeLayer.fillColor = activeColorOfWards.cgColor
        switch alignment {
        case .Center,
            .Right:
            shapeLayer.position.x -= self.bounds.size.width
            
        case .Middle,
             .Bottom:
            shapeLayer.position.y -= superview?.bounds.size.height ?? bounds.size.height + 10
            
        default:
            break
        }
        self.layer.addSublayer(shapeLayer)
        return shapeLayer
    }
    
    // MARK: - Create animator
    
    private func makeAnimator() {
        
        let offsetY = superview?.bounds.size.height ?? bounds.size.height + 10
        animator = Animator(alignment: alignment,
                            offsetX: bounds.size.width,
                            offsetY: offsetY,
                            activeMiddleWard: activeMiddleWard,
                            activeShortWard: activeShortWard)
    }
}

extension AlingmentItemView {
    
    // MARK: - Animation by axe X
    
    func leftToCenter() {
        animator.leftToCenter()
    }
    
     func leftToRight() {
        animator.leftToRight()
    }
    
    func rightToLeft() {
        animator.rightToLeft()
    }
    
    func centerToRight() {
        animator.centerToRight()
    }
    
    func rightToCenter() {
        animator.rightToCenter()
    }
    
    func centerToLeft() {
        animator.centerToLeft()
    }
 
    // MARK: - Animation by axe Y
    
    func topToMiddle() {
        animator.topToMiddle()
    }
    
    func topToBottom() {
        animator.topToBottom()
    }
    
    func bottomToTop() {
        animator.bottomToTop()
    }
    
    func middleToBottom() {
        animator.middleToBottom()
    }
    
    func bottomToMiddle() {
        animator.bottomToMiddle()
    }
    
    func middleToTop() {
        animator.middleToTop()
    }
    
}

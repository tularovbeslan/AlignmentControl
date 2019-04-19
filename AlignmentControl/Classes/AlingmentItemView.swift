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
    
	@IBInspectable var colorOfWards: UIColor = UIColor.init(red: 220/255.0, green: 224/255.0, blue: 236/255.0, alpha: 1)

	var alignment: AlignmentMode = .Left

	private var longWardPath: UIBezierPath!
	private var middleWardPath: UIBezierPath!
	private var shortWardPath: UIBezierPath!

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
        
         addTapGesture()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
        
         addTapGesture()
	}

    convenience init(_ alignment: AlignmentMode) {
		self.init()
        
		self.alignment = alignment
        addTapGesture()
	}

    // MARK: - Private
    
    private func addTapGesture() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAligment))
        self.addGestureRecognizer(tap)
    }
    
     @objc private func tapAligment() {

        parentView.applyAnimation()
        if let delegate = delegate {
            delegate.didSelectOptionFor(alignment)
        }
    }
    
	override func draw(_ rect: CGRect) {

		switch alignment {
		case .Left: drawLeft(frame: rect)
		case .Center: drawCenter(frame: rect)
		case .Right: drawRight(frame: rect)
		case .Top: drawTop(frame: rect)
		case .Middle: drawMiddle(frame: rect)
		case .Bottom: drawBottom(frame: rect)
		}
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
}

//
//  AlingmentItemView.swift
//  AlignmentControl
//
//  Created by workmachine on 16/04/2019.
//

import UIKit

public protocol AlingmentItemViewDelegate: class {
	func didSelectOptionFor(_ alingmentItemView: AlingmentItemView, mode: AlignmentMode)
	func touchesBegan()
	func touchesEnded()
}

open class AlingmentItemView: UIView {

	weak var delegate: AlingmentItemViewDelegate?

	public var colorOfWards: UIColor!

	var mode: AlignmentMode = .Left  {
		didSet {
			switch mode {
			case .Left, .Center, .Right:
				direction = .Horizontal
			case .Top, .Middle, .Bottom:
				direction = .Vertical
			}
		}
	}

	var direction: AlignmentDirection = .Horizontal

	public var longWardPath: UIBezierPath!
	public var middleWardPath: UIBezierPath!
	public var shortWardPath: UIBezierPath!

	private var longWardWidth: CGFloat {

		switch direction {
		case .Horizontal: return frame.width * 0.10
		case .Vertical: return frame.width
		}
	}

	private var longWardHeight: CGFloat {

		switch direction {
		case .Horizontal: return frame.height
		case .Vertical: return frame.height * 0.10
		}
	}

	private var longWardRadius: CGFloat { return longWardWidth * 0.3 }

	private var middleWardWidth: CGFloat {

		switch direction {
		case .Horizontal: return frame.width * 0.60
		case .Vertical: return frame.height / 5
		}
	}

	private var middleWardHeight: CGFloat {

		switch direction {
		case .Horizontal: return frame.height / 5
		case .Vertical: return frame.height * 0.60
		}
	}

	public var middleWardRadius: CGFloat { return (frame.height / 5) * 0.3 }

	private var shortWardWidth: CGFloat {

		switch direction {
		case .Horizontal: return frame.width * 0.40
		case .Vertical: return frame.height / 5
		}
	}

	private var shortWardHeight: CGFloat {

		switch direction {
		case .Horizontal: return frame.height / 5
		case .Vertical: return frame.height * 0.40
		}
	}

	public var index: Int = 0
	public var shortWardRadius: CGFloat { return (frame.height / 5) * 0.3 }

	// MARK: - Private

	override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		delegate?.touchesBegan()
	}

	override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

		delegate?.touchesEnded()
		delegate?.didSelectOptionFor(self, mode: mode)
	}


	override open func draw(_ rect: CGRect) {
		super.draw(rect)

		switch mode {
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

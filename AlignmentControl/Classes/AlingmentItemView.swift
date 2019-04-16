//
//  AlingmentItemView.swift
//  AlignmentControl
//
//  Created by workmachine on 16/04/2019.
//

import UIKit

@objc enum AlignmentMode: Int {

	case Left
	case Center
	case Right
	case Top
	case Middle
	case Bottom
}

@IBDesignable
class AlingmentItemView: UIView {

	@IBInspectable var colorOfWards: UIColor = UIColor.init(red: 220/255.0, green: 224/255.0, blue: 236/255.0, alpha: 1)

	var alignmentMode: AlignmentMode = .Left

	var longWardPath: UIBezierPath!
	var middleWardPath: UIBezierPath!
	var shortWardPath: UIBezierPath!

	override init(frame: CGRect) {
		super.init(frame: frame)

	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	convenience init(_ alignmentMode: AlignmentMode) {
		self.init()
		self.alignmentMode = alignmentMode
	}

	override func draw(_ rect: CGRect) {

		switch alignmentMode {
		case .Left: drawLeft(frame: rect)
		case .Center: drawCenter(frame: rect)
		case .Right: drawRight(frame: rect)
		case .Top: drawTop(frame: rect)
		case .Middle: drawMiddle(frame: rect)
		case .Bottom: drawBottom(frame: rect)
		}
	}

	func fastFloor(_ x: CGFloat) -> CGFloat { return floor(x) }

	func drawLeft(frame: CGRect = CGRect(x: 0, y: 0, width: 48, height: 48)) {

		longWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.10417 + 0.5), y: frame.minY + fastFloor(frame.height * 0.00000 + 0.5), width: fastFloor(frame.width * 0.18750 + 0.5) - fastFloor(frame.width * 0.10417 + 0.5), height: fastFloor(frame.height * 1.00000 + 0.5) - fastFloor(frame.height * 0.00000 + 0.5)), cornerRadius: (fastFloor(frame.width * 0.18750 + 0.5) - fastFloor(frame.width * 0.10417 + 0.5) * 0.5))
		colorOfWards.setFill()
		longWardPath.fill()

		middleWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.29167 + 0.5), y: frame.minY + fastFloor(frame.height * 0.25000 + 0.5), width: fastFloor(frame.width * 0.89583 + 0.5) - fastFloor(frame.width * 0.29167 + 0.5), height: fastFloor(frame.height * 0.41667 + 0.5) - fastFloor(frame.height * 0.25000 + 0.5)), cornerRadius: (fastFloor(frame.height * 0.41667 + 0.5) - fastFloor(frame.height * 0.25000 + 0.5)) * 0.3)
		colorOfWards.setFill()
		middleWardPath.fill()

		shortWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.29167 + 0.5), y: frame.minY + fastFloor(frame.height * 0.58333 + 0.5), width: fastFloor(frame.width * 0.72917 + 0.5) - fastFloor(frame.width * 0.29167 + 0.5), height: fastFloor(frame.height * 0.75000 + 0.5) - fastFloor(frame.height * 0.58333 + 0.5)), cornerRadius: (fastFloor(frame.height * 0.75000 + 0.5) - fastFloor(frame.height * 0.58333 + 0.5)) * 0.3)
		colorOfWards.setFill()
		shortWardPath.fill()
	}

	func drawCenter(frame: CGRect = CGRect(x: 0, y: 0, width: 48, height: 48)) {

		longWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.45833 + 0.5), y: frame.minY + fastFloor(frame.height * 0.00000 + 0.5), width: fastFloor(frame.width * 0.54167 + 0.5) - fastFloor(frame.width * 0.45833 + 0.5), height: fastFloor(frame.height * 1.00000 + 0.5) - fastFloor(frame.height * 0.00000 + 0.5)), cornerRadius: 1)
		colorOfWards.setFill()
		longWardPath.fill()

		middleWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.20833 + 0.5), y: frame.minY + fastFloor(frame.height * 0.25000 + 0.5), width: fastFloor(frame.width * 0.81250 + 0.5) - fastFloor(frame.width * 0.20833 + 0.5), height: fastFloor(frame.height * 0.41667 + 0.5) - fastFloor(frame.height * 0.25000 + 0.5)), cornerRadius: 1)
		colorOfWards.setFill()
		middleWardPath.fill()

		shortWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.29167 + 0.5), y: frame.minY + fastFloor(frame.height * 0.58333 + 0.5), width: fastFloor(frame.width * 0.72917 + 0.5) - fastFloor(frame.width * 0.29167 + 0.5), height: fastFloor(frame.height * 0.75000 + 0.5) - fastFloor(frame.height * 0.58333 + 0.5)), cornerRadius: 1)
		colorOfWards.setFill()
		shortWardPath.fill()
	}


	func drawRight(frame: CGRect = CGRect(x: 0, y: 0, width: 48, height: 48)) {

		longWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.83333 + 0.5), y: frame.minY + fastFloor(frame.height * 0.00000 + 0.5), width: fastFloor(frame.width * 0.91667 + 0.5) - fastFloor(frame.width * 0.83333 + 0.5), height: fastFloor(frame.height * 1.00000 + 0.5) - fastFloor(frame.height * 0.00000 + 0.5)), cornerRadius: 1)
		colorOfWards.setFill()
		longWardPath.fill()

		middleWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.10417 + 0.5), y: frame.minY + fastFloor(frame.height * 0.25000 + 0.5), width: fastFloor(frame.width * 0.70833 + 0.5) - fastFloor(frame.width * 0.10417 + 0.5), height: fastFloor(frame.height * 0.41667 + 0.5) - fastFloor(frame.height * 0.25000 + 0.5)), cornerRadius: 1)
		colorOfWards.setFill()
		middleWardPath.fill()

		shortWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.27083 + 0.5), y: frame.minY + fastFloor(frame.height * 0.58333 + 0.5), width: fastFloor(frame.width * 0.70833 + 0.5) - fastFloor(frame.width * 0.27083 + 0.5), height: fastFloor(frame.height * 0.75000 + 0.5) - fastFloor(frame.height * 0.58333 + 0.5)), cornerRadius: 1)
		colorOfWards.setFill()
		shortWardPath.fill()
	}


	func drawTop(frame: CGRect = CGRect(x: 0, y: 0, width: 48, height: 48)) {

		longWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.00000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.10417 + 0.5), width: fastFloor(frame.width * 1.00000 + 0.5) - fastFloor(frame.width * 0.00000 + 0.5), height: fastFloor(frame.height * 0.20833 + 0.5) - fastFloor(frame.height * 0.10417 + 0.5)), cornerRadius: 1)
		colorOfWards.setFill()
		longWardPath.fill()

		middleWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.25000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.33333 + 0.5), width: fastFloor(frame.width * 0.41667 + 0.5) - fastFloor(frame.width * 0.25000 + 0.5), height: fastFloor(frame.height * 0.91667 + 0.5) - fastFloor(frame.height * 0.33333 + 0.5)), cornerRadius: 1)
		colorOfWards.setFill()
		middleWardPath.fill()

		shortWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.58333 + 0.5), y: frame.minY + fastFloor(frame.height * 0.33333 + 0.5), width: fastFloor(frame.width * 0.75000 + 0.5) - fastFloor(frame.width * 0.58333 + 0.5), height: fastFloor(frame.height * 0.75000 + 0.5) - fastFloor(frame.height * 0.33333 + 0.5)), cornerRadius: 1)
		colorOfWards.setFill()
		shortWardPath.fill()
	}

	func drawMiddle(frame: CGRect = CGRect(x: 0, y: 0, width: 48, height: 48)) {

		longWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.00000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.47917 + 0.5), width: fastFloor(frame.width * 1.00000 + 0.5) - fastFloor(frame.width * 0.00000 + 0.5), height: fastFloor(frame.height * 0.58333 + 0.5) - fastFloor(frame.height * 0.47917 + 0.5)), cornerRadius: 1)
		colorOfWards.setFill()
		longWardPath.fill()

		middleWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.25000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.25000 + 0.5), width: fastFloor(frame.width * 0.41667 + 0.5) - fastFloor(frame.width * 0.25000 + 0.5), height: fastFloor(frame.height * 0.83333 + 0.5) - fastFloor(frame.height * 0.25000 + 0.5)), cornerRadius: 1)
		colorOfWards.setFill()
		middleWardPath.fill()

		shortWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.58333 + 0.5), y: frame.minY + fastFloor(frame.height * 0.33333 + 0.5), width: fastFloor(frame.width * 0.75000 + 0.5) - fastFloor(frame.width * 0.58333 + 0.5), height: fastFloor(frame.height * 0.75000 + 0.5) - fastFloor(frame.height * 0.33333 + 0.5)), cornerRadius: 1)
		colorOfWards.setFill()
		shortWardPath.fill()
	}

	func drawBottom(frame: CGRect = CGRect(x: 0, y: 0, width: 48, height: 48)) {

		longWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.00000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.79167 + 0.5), width: fastFloor(frame.width * 1.00000 + 0.5) - fastFloor(frame.width * 0.00000 + 0.5), height: fastFloor(frame.height * 0.89583 + 0.5) - fastFloor(frame.height * 0.79167 + 0.5)), cornerRadius: 1)
		colorOfWards.setFill()
		longWardPath.fill()

		middleWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.25000 + 0.5), y: frame.minY + fastFloor(frame.height * 0.10417 + 0.5), width: fastFloor(frame.width * 0.41667 + 0.5) - fastFloor(frame.width * 0.25000 + 0.5), height: fastFloor(frame.height * 0.68750 + 0.5) - fastFloor(frame.height * 0.10417 + 0.5)), cornerRadius: 1)
		colorOfWards.setFill()
		middleWardPath.fill()

		shortWardPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor(frame.width * 0.58333 + 0.5), y: frame.minY + fastFloor(frame.height * 0.27083 + 0.5), width: fastFloor(frame.width * 0.75000 + 0.5) - fastFloor(frame.width * 0.58333 + 0.5), height: fastFloor(frame.height * 0.68750 + 0.5) - fastFloor(frame.height * 0.27083 + 0.5)), cornerRadius: 1)
		colorOfWards.setFill()
		shortWardPath.fill()
	}

}

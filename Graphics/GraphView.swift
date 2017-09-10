//
//  GraphView.swift
//  Graphics
//
//  Created by Danya on 05.09.17.
//  Copyright © 2017 Danya. All rights reserved.
//

import UIKit

class GraphView: UIView {
	
	fileprivate var currentState: FuncType = .sin
	fileprivate var arrayOfYAxisValues: [CGFloat] = []
	fileprivate var arrayOfXAxisValues: [CGFloat] = []
	
	init(frame: CGRect, funcType: FuncType) {
		super.init(frame: frame)
		self.currentState = funcType
		self.backgroundColor = .white
		self.prepareForDraw()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	private func prepareForDraw() {
		let interval = 0.1
		for f in stride(from: -10, to: 10, by: interval) {
			arrayOfXAxisValues.append(CGFloat(f))
			switch self.currentState {
			case .cos:
				arrayOfYAxisValues.append(CGFloat(cos(f)))
			case .pow:
				arrayOfYAxisValues.append(CGFloat(pow(f, 2)))
			case .sin:
				arrayOfYAxisValues.append(CGFloat(sin(f)))
			}
		}
		self.drawAxis()
		self.tryToDrawOther()
	}
	
	
	func drawAxis() {
		let aPath = UIBezierPath()
		aPath.move(to: CGPoint(x: self.center.x, y:0))
		aPath.addLine(to: CGPoint(x: self.center.x, y: self.frame.height))
		aPath.move(to: CGPoint(x: 0, y: self.center.y))
		aPath.addLine(to: CGPoint(x: self.frame.width, y: self.center.y))
		let shapeLayer = CAShapeLayer()
		shapeLayer.path = aPath.cgPath
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.strokeColor = UIColor.black.cgColor
		shapeLayer.lineWidth = 2.0
		self.layer.addSublayer(shapeLayer)
	}
	
	func tryToDrawOther() {
		let maximumY = arrayOfYAxisValues.max()
		let minimumY = arrayOfYAxisValues.min()
		let interval = 0.1
		let path = UIBezierPath()
		var index = -1
		for _ in stride(from: -10, to: 10, by: interval) {
			index += 1
			let resettedY = resetY(y: arrayOfYAxisValues[index],
			                       max: maximumY!,
			                       min: minimumY!)
			let resettedX = resetX(x: index)
			if index == 0 {
				path.move(to: CGPoint(x: resettedX,
				                      y: resettedY))
			} else {
				path.addLine(to: CGPoint(x: resettedX,
				                         y: resettedY))
			}
		}
		let shapeLayer = CAShapeLayer()
		shapeLayer.path = path.cgPath
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.strokeColor = UIColor.red.cgColor
		shapeLayer.lineWidth = 2.0
		self.layer.addSublayer(shapeLayer)
	}
	
	func resetY(y: CGFloat, max: CGFloat, min: CGFloat) -> CGFloat {
		if y > 0 {
			let coordinate = y * (self.center.y) / max
			let readyCoordinate: CGFloat = self.center.y - coordinate
			print("ready coordinate x =  ", readyCoordinate, " y = \(y)  , max = \(max)")
			return readyCoordinate
		} else if y < 0 {
			let coordinate = y * (self.center.y) / min
			let readyCoordinate = self.center.y + coordinate
			return readyCoordinate
		} else {
			return self.center.y
		}
	}
	
	func resetX(x: Int) -> CGFloat {
		let interval = self.frame.width / CGFloat(arrayOfXAxisValues.count)
		return CGFloat(x) * interval
	}
}

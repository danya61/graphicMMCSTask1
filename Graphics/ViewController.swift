//
//  ViewController.swift
//  Graphics
//
//  Created by Danya on 05.09.17.
//  Copyright © 2017 Danya. All rights reserved.
//

import UIKit

enum FuncType {
	case sin
	case cos
	case pow
}

class ViewController: UIViewController {
	
	@IBOutlet weak var input: UITextField!
	@IBOutlet weak var inputNextButton: UIButton! {
		didSet {
			self.inputNextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
		}
	}
	
	fileprivate var currentState: FuncType = .sin
	fileprivate var graphView: GraphView!

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
	}
	
	@IBAction func cosPressed(_ sender: Any) {
		currentState = .cos
		self.nextPressed()
	}
	
	@IBAction func sinPressed(_ sender: Any) {
		currentState = .sin
		self.nextPressed()
	}
	
	@IBAction func x2Pressed(_ sender: Any) {
		currentState = .pow
		self.nextPressed()
	}
	
	func nextPressed() {
		graphView = GraphView(frame: CGRect.init(x: 0,
		                                         y: 30,
		                                         width: UIScreen.main.bounds.width,
		                                         height: 450), funcType: self.currentState)
		self.view.addSubview(self.graphView)
	}

}


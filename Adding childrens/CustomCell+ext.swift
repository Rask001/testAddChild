//
//  CustomCell+ext.swift
//  Adding childrens
//
//  Created by Антон on 24.10.2022.
//

import Foundation
import UIKit

fileprivate enum Constant{
	static var buttonBorderColor: CGColor { UIColor(named: "BorderColor")?.cgColor ?? UIColor.red.cgColor }
}
extension CustomCell {
	internal func makeButton() -> UIButton {
		let button = UIButton()
		button.setTitle("Удалить", for: .normal)
		button.setTitleColor(.red, for: .normal)
		button.layer.borderColor = Constant.buttonBorderColor
		button.layer.borderWidth = 1
		button.layer.cornerRadius = 6
		return button
	}
	
	internal func makeTextFieldName() -> UITextField {
		let tf = UITextField()
		tf.backgroundColor = .green
		return tf
	}
	
	internal func makeTextFieldAge() -> UITextField {
		let tf = UITextField()
		tf.backgroundColor = .yellow
		return tf
	}
	
	
	//MARK: - addSubviewAndConfigure
	internal func addSubviewAndConfigure() {
		self.addSubview(self.button)
		self.addSubview(self.textFieldName)
		self.addSubview(self.textFieldAge)
	}
	
	//MARK: - layout
	internal func layout() {
		self.textFieldName.translatesAutoresizingMaskIntoConstraints = false
	  self.textFieldName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
	  self.textFieldName.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
		self.textFieldName.widthAnchor.constraint(equalToConstant: self.frame.size.width/2 + 20).isActive = true
		self.textFieldName.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		self.textFieldAge.translatesAutoresizingMaskIntoConstraints = false
		self.textFieldAge.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
		self.textFieldAge.topAnchor.constraint(equalTo: self.textFieldName.bottomAnchor, constant: 20).isActive = true
		self.textFieldAge.widthAnchor.constraint(equalToConstant: self.frame.size.width/2 + 20).isActive = true
		self.textFieldAge.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		self.button.translatesAutoresizingMaskIntoConstraints = false
		self.button.leadingAnchor.constraint(equalTo: self.textFieldName.trailingAnchor, constant: 20).isActive = true
		self.button.centerYAnchor.constraint(equalTo: self.textFieldName.centerYAnchor).isActive = true
		self.button.widthAnchor.constraint(equalToConstant: 80).isActive = true
	}
}

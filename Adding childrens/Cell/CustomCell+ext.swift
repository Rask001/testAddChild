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
	static var tFBorderColor: CGColor { UIColor(named: "BorderColor")?.cgColor ?? UIColor.lightGray.cgColor }
}

extension CustomCell {
	internal func makeButton() -> UIButton {
		let button = UIButton(type: .system)
		button.setTitle("Удалить", for: .normal)
		button.setTitleColor(.red, for: .normal)
		button.addTarget(self, action: #selector(deleteCell(sender:)), for: .touchUpInside)
		button.tag = 0
		return button
	}
	
	@objc func deleteCell(sender: UIButton) {
		print(sender.tag)
		CoreDataMethods.shared.deleteCell(tag: sender.tag)
	}
	
	@objc func dismissKeyb() {
		
	}
	
	@objc func okAction() {
		self.endEditing(true)
	}
	
	internal func setupTextFieldToolBar() {
		numberToolbar.barStyle = .default
		numberToolbar.items=[
			UIBarButtonItem(title: "Отмена", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissKeyb)),
			UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
			UIBarButtonItem(title: "Продолжить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(okAction))
		]
		numberToolbar.sizeToFit()
	}
	
	internal func makeTextFieldName() -> UITextField {
		let tf = UITextField()
		tf.delegate = self
		tf.backgroundColor = .white
		tf.placeholder = " Имя"
		tf.layer.borderWidth = 1
		tf.keyboardType = .numberPad
		tf.layer.borderColor = Constant.tFBorderColor
		tf.layer.cornerRadius = 8
		return tf
	}
	
	internal func makeTextFieldAge() -> UITextField {
		let tf = UITextField()
		tf.inputAccessoryView = numberToolbar
		tf.delegate = self
		tf.backgroundColor = .white
		tf.placeholder = " Возраст"
		tf.layer.borderWidth = 1
		tf.keyboardType = .numberPad
		tf.layer.borderColor = Constant.tFBorderColor
		tf.layer.cornerRadius = 8
		return tf
	}
	
	
	//MARK: - addSubviewAndConfigure
	internal func addSubviewAndConfigure() {
		self.contentView.addSubview(self.button)
		self.contentView.addSubview(self.textFieldName)
		self.contentView.addSubview(self.textFieldAge)
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


extension CustomCell: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
			return textFieldAge.becomeFirstResponder()
	}
}

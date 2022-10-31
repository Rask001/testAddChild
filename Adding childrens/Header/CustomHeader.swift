//
//  CustomHeader.swift
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

fileprivate enum Title{
	static var namePlaceholder = "Имя"
	static var agePlaceholder = "Возраст"
	static var bottomLabelText = "Дети (макс. 5)"
	static var topLabelText = "Персональные данные"
	static var leftNumToolBar = "Отмена"
	static var rightNumToolBar = "Продолжить"
	static var addChildBtn = "+ Добавить ребенка"
}


protocol CustomHeaderProtocol {
	func upDownHeader()
}

final class CustomHeader: UIView {
	var addChildButton = UIButton()
	var textFieldName = UITextField()
	var textFieldAge = UITextField()
	private var topLabel = UILabel()
	private let numberToolbar = UIToolbar()
	var bottomLabel = UILabel()
	var childModel = ChildModel()
	weak var mainView: MainView?
	var delegate: MainView?
	
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		addSubview()
		layout()
		setupTextFieldToolBar()
		setupTextFieldName()
		setupTextFieldAge()
		setupTopLabel()
		setupBottomLabel()
		setupAddChildButton()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupTextFieldName() {
		textFieldName.delegate = self
		textFieldName.backgroundColor = .white
		textFieldName.placeholder = Title.namePlaceholder
		textFieldName.indent(size: 10)
		textFieldName.layer.borderWidth = 1
		textFieldName.layer.borderColor = Constant.tFBorderColor
		textFieldName.layer.cornerRadius = 8
	}
	
	private func setupTextFieldToolBar() {
		numberToolbar.barStyle = .default
		numberToolbar.items=[
			UIBarButtonItem(title: Title.leftNumToolBar, style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissKeyb)),
			UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
			UIBarButtonItem(title: Title.rightNumToolBar, style: UIBarButtonItem.Style.plain, target: self, action: #selector(okAction))
		]
		numberToolbar.sizeToFit()
	}
	
	private func setupTopLabel() {
		topLabel.text = Title.topLabelText
	}
	
	private func setupBottomLabel() {
		bottomLabel.text = Title.bottomLabelText
	}
	
	private func setupTextFieldAge() {
		textFieldAge.inputAccessoryView = numberToolbar
		textFieldAge.delegate = self
		textFieldAge.backgroundColor = .white
		textFieldAge.placeholder = Title.agePlaceholder
		textFieldAge.indent(size: 10)
		textFieldAge.layer.borderWidth = 1
		textFieldAge.keyboardType = .numberPad
		textFieldAge.layer.borderColor = Constant.tFBorderColor
		textFieldAge.layer.cornerRadius = 8
		textFieldAge.isHidden = true
	}
	
	@objc func dismissKeyb() {
		endEditing(true)
	}
	
	@objc func okAction() {
		guard textFieldAge.text != "" else { Animations.shake(text: topLabel, duration: 0.4); return }
		guard let age = textFieldAge.text else { return }
		childModel.name = textFieldName.text ?? ""
		childModel.age = Int(age) ?? 0
		CoreDataMethods.shared.saveChild(name: childModel.name, age: childModel.age)
		
		textFieldName.text = ""
		textFieldAge.text = ""
		endEditing(true)
	}
	
	private func setupAddChildButton() {
		addChildButton.setTitle(Title.addChildBtn, for: .normal)
		addChildButton.setTitleColor(.blue, for: .normal)
		addChildButton.layer.borderColor = UIColor(ciColor: .blue).cgColor
		addChildButton.layer.borderWidth = 1
		addChildButton.layer.cornerRadius = 22
		addChildButton.addTarget(self, action: #selector(addChildAction), for: .touchUpInside)
	}
	
	@objc func addChildAction() {
		delegate?.upDownHeader()
	}
}


//MARK: - Layout
extension CustomHeader {
	
	private func addSubview() {
		addSubview(topLabel)
		addSubview(textFieldName)
		addSubview(textFieldAge)
		addSubview(bottomLabel)
		addSubview(addChildButton)
	}
	
	func layout() {
		topLabel.translatesAutoresizingMaskIntoConstraints = false
		topLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
		topLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
		topLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
		topLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		textFieldName.translatesAutoresizingMaskIntoConstraints = false
		textFieldName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
		textFieldName.topAnchor.constraint(equalTo: topLabel.bottomAnchor).isActive = true
		textFieldName.trailingAnchor.constraint(equalTo: topLabel.trailingAnchor).isActive = true
		textFieldName.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		textFieldAge.translatesAutoresizingMaskIntoConstraints = false
		textFieldAge.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
		textFieldAge.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 10).isActive = true
		textFieldAge.trailingAnchor.constraint(equalTo: topLabel.trailingAnchor).isActive = true
		textFieldAge.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		bottomLabel.translatesAutoresizingMaskIntoConstraints = false
		bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
		bottomLabel.topAnchor.constraint(equalTo: textFieldAge.bottomAnchor, constant: 10).isActive = true
		bottomLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -40).isActive = true
		bottomLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		addChildButton.translatesAutoresizingMaskIntoConstraints = false
		addChildButton.leadingAnchor.constraint(equalTo: bottomLabel.trailingAnchor, constant: 20).isActive = true
		addChildButton.topAnchor.constraint(equalTo: textFieldAge.bottomAnchor, constant: 10).isActive = true
		addChildButton.trailingAnchor.constraint(equalTo: topLabel.trailingAnchor).isActive = true
		addChildButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
	}
}

//MARK: - extension
extension CustomHeader: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard textFieldName.text != "" else { Animations.shake(text: topLabel, duration: 0.4); return false }
			return textFieldAge.becomeFirstResponder()
	}
}

//MARK: - extension UITextField
extension UITextField {
		func indent(size:CGFloat) {
				leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
				leftViewMode = .always
		}
}

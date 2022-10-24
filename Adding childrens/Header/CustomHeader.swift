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
		self.textFieldName.delegate = self
		self.textFieldName.backgroundColor = .white
		self.textFieldName.placeholder = "Имя"
		self.textFieldName.indent(size: 10)
		self.textFieldName.layer.borderWidth = 1
		self.textFieldName.layer.borderColor = Constant.tFBorderColor
		self.textFieldName.layer.cornerRadius = 8
	}
	
	private func setupTextFieldToolBar() {
		numberToolbar.barStyle = .default
		numberToolbar.items=[
			UIBarButtonItem(title: "Отмена", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissKeyb)),
			UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
			UIBarButtonItem(title: "Продолжить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(okAction))
		]
		numberToolbar.sizeToFit()
	}
	
	private func setupTopLabel() {
		self.topLabel.text = "Персональные данные"
	}
	
	private func setupBottomLabel() {
		self.bottomLabel.text = "Дети (макс. 5)"
	}
	
	private func setupTextFieldAge() {
		self.textFieldAge.inputAccessoryView = numberToolbar
		self.textFieldAge.delegate = self
		self.textFieldAge.backgroundColor = .white
		self.textFieldAge.placeholder = "Возраст"
		self.textFieldAge.indent(size: 10)
		self.textFieldAge.layer.borderWidth = 1
		self.textFieldAge.keyboardType = .numberPad
		self.textFieldAge.layer.borderColor = Constant.tFBorderColor
		self.textFieldAge.layer.cornerRadius = 8
		self.textFieldAge.isHidden = true
	}
	
	@objc func dismissKeyb() {
		endEditing(true)
	}
	
	@objc func okAction() {
		guard let age = textFieldAge.text else { return }
		self.childModel.name = textFieldName.text ?? ""
		self.childModel.age = Int(age) ?? 0
		CoreDataMethods.shared.saveChild(name: childModel.name, age: childModel.age)
		
		self.textFieldName.text = ""
		self.textFieldAge.text = ""
		self.endEditing(true)
	}
	
	private func setupAddChildButton() {
		self.addChildButton.setTitle("+ Добавить ребенка", for: .normal)
		self.addChildButton.setTitleColor(.blue, for: .normal)
		self.addChildButton.layer.borderColor = UIColor(ciColor: .blue).cgColor
		self.addChildButton.layer.borderWidth = 1
		self.addChildButton.layer.cornerRadius = 22
		self.addChildButton.addTarget(self, action: #selector(addChildAction), for: .touchUpInside)
	}
	
	@objc func addChildAction() {
		self.delegate?.upDownHeader()
	}
	
	//MARK: - AddSubViews
	private func addSubview() {
			self.addSubview(topLabel)
			self.addSubview(textFieldName)
			self.addSubview(textFieldAge)
			self.addSubview(bottomLabel)
			self.addSubview(addChildButton)
		}
	
	//MARK: - Layout
	func layout() {
		self.topLabel.translatesAutoresizingMaskIntoConstraints = false
		self.topLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
		self.topLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		self.topLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
		self.topLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		self.textFieldName.translatesAutoresizingMaskIntoConstraints = false
		self.textFieldName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
		self.textFieldName.topAnchor.constraint(equalTo: self.topLabel.bottomAnchor).isActive = true
		self.textFieldName.trailingAnchor.constraint(equalTo: self.topLabel.trailingAnchor).isActive = true
		self.textFieldName.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		self.textFieldAge.translatesAutoresizingMaskIntoConstraints = false
		self.textFieldAge.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
		self.textFieldAge.topAnchor.constraint(equalTo: self.textFieldName.bottomAnchor, constant: 10).isActive = true
		self.textFieldAge.trailingAnchor.constraint(equalTo: self.topLabel.trailingAnchor).isActive = true
		self.textFieldAge.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		self.bottomLabel.translatesAutoresizingMaskIntoConstraints = false
		self.bottomLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
		self.bottomLabel.topAnchor.constraint(equalTo: self.textFieldAge.bottomAnchor, constant: 10).isActive = true
		self.bottomLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -40).isActive = true
		self.bottomLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		self.addChildButton.translatesAutoresizingMaskIntoConstraints = false
		self.addChildButton.leadingAnchor.constraint(equalTo: self.bottomLabel.trailingAnchor, constant: 20).isActive = true
		self.addChildButton.topAnchor.constraint(equalTo: self.textFieldAge.bottomAnchor, constant: 10).isActive = true
		self.addChildButton.trailingAnchor.constraint(equalTo: self.topLabel.trailingAnchor).isActive = true
		self.addChildButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
	}
}

//MARK: - extension
extension CustomHeader: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
			return textFieldAge.becomeFirstResponder()
	}
}

//MARK: - extension UITextField
extension UITextField {
		func indent(size:CGFloat) {
				self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
				self.leftViewMode = .always
		}
}

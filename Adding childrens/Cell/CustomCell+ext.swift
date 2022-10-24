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
	static var lblHideColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
	static var lblAgeFont = UIFont(name: "Helvetica Neue", size: 14)!
	static var lblAgeDownFont = UIFont(name: "Helvetica Neue", size: 20)!
}

extension CustomCell {
	
	//MARK: - SETUP
	internal func makeButton() -> UIButton {
		let button = UIButton(type: .system)
		button.setTitle("Удалить", for: .normal)
		button.setTitleColor(.red, for: .normal)
		button.addTarget(self, action: #selector(deleteCell(sender:)), for: .touchUpInside)
		return button
	}
	
	internal func makeLabel(text: String, subView: UILabel) -> UILabel {
		let lbl = UILabel()
		let lblAge = UILabel()
		lblAge.textColor = .lightGray
		lblAge.text = text
		lblAge.font = Constant.lblAgeFont
		lblAge.frame = CGRect(x: 12, y: 0, width: 70, height: 16)
		lbl.layer.borderWidth = 1
		lbl.layer.cornerRadius = 8
		lbl.layer.borderColor = Constant.tFBorderColor
		lbl.addSubview(lblAge)
		lbl.addSubview(subView)
		return lbl
	}
	
	internal func makeInsideLblName() -> UILabel {
		let lblAgeDown = UILabel()
		lblAgeDown.font = Constant.lblAgeDownFont
		lblAgeDown.frame = CGRect(x: 12, y: 16, width: 200, height: 28)
		return lblAgeDown
	}
	
	//MARK: - ACTIONS
	@objc func deleteCell(sender: UIButton) {
		print(sender.tag)
		CoreDataMethods.shared.deleteCell(tag: sender.tag)
	}
	
	//MARK: - addSubviewAndConfigure
	internal func addSubviewAndConfigure() {
		self.contentView.addSubview(self.button)
		self.contentView.addSubview(self.labelName)
		self.contentView.addSubview(self.labelAge)
	}
	
	//MARK: - layout
	internal func layout() {
		self.labelName.translatesAutoresizingMaskIntoConstraints = false
	  self.labelName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
	  self.labelName.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
		self.labelName.widthAnchor.constraint(equalToConstant: self.frame.size.width/2 + 20).isActive = true
		self.labelName.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		self.labelAge.translatesAutoresizingMaskIntoConstraints = false
		self.labelAge.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
		self.labelAge.topAnchor.constraint(equalTo: self.labelName.bottomAnchor, constant: 20).isActive = true
		self.labelAge.widthAnchor.constraint(equalToConstant: self.frame.size.width/2 + 20).isActive = true
		self.labelAge.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		self.button.translatesAutoresizingMaskIntoConstraints = false
		self.button.leadingAnchor.constraint(equalTo: self.labelName.trailingAnchor, constant: 20).isActive = true
		self.button.centerYAnchor.constraint(equalTo: self.labelName.centerYAnchor).isActive = true
		self.button.widthAnchor.constraint(equalToConstant: 80).isActive = true
	}
}

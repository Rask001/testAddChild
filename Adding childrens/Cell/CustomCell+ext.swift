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
	static var delBtnTitle = "Удалить"
	static var lblAgeFrame = CGRect(x: 12, y: 0, width: 70, height: 16)
	static var lblAgeDown = CGRect(x: 12, y: 16, width: 200, height: 28)
}

extension CustomCell {
	
	//MARK: - SETUP
	internal func makeButton() -> UIButton {
		let button = UIButton(type: .system)
		button.setTitle(Constant.delBtnTitle, for: .normal)
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
		lblAge.frame = Constant.lblAgeFrame
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
		lblAgeDown.frame = Constant.lblAgeDown
		return lblAgeDown
	}
	
	//MARK: - ACTIONS
	@objc func deleteCell(sender: UIButton) {
		print(sender.tag)
		CoreDataMethods.shared.deleteCell(tag: sender.tag)
	}
	
	//MARK: - addSubviewAndConfigure
	internal func addSubviewAndConfigure() {
		contentView.addSubview(button)
		contentView.addSubview(labelName)
		contentView.addSubview(labelAge)
	}
	
	//MARK: - layout
	internal func layout() {
		labelName.translatesAutoresizingMaskIntoConstraints = false
	  labelName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
	  labelName.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
		labelName.widthAnchor.constraint(equalToConstant: frame.size.width/2 + 20).isActive = true
		labelName.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		labelAge.translatesAutoresizingMaskIntoConstraints = false
		labelAge.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
		labelAge.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 20).isActive = true
		labelAge.widthAnchor.constraint(equalToConstant: frame.size.width/2 + 20).isActive = true
		labelAge.heightAnchor.constraint(equalToConstant: 44).isActive = true
		
		button.translatesAutoresizingMaskIntoConstraints = false
		button.leadingAnchor.constraint(equalTo: labelName.trailingAnchor, constant: 20).isActive = true
		button.centerYAnchor.constraint(equalTo: labelName.centerYAnchor).isActive = true
		button.widthAnchor.constraint(equalToConstant: 80).isActive = true
	}
}

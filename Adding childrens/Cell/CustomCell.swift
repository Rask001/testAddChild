//
//  CustomCell.swift
//  Adding childrens
//
//  Created by Антон on 24.10.2022.
//

import Foundation
import UIKit

final class TableFooter: UITableViewHeaderFooterView {
	static let identifier = "TableFooter"
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		addSubviewAndConfigure()
		layout()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	private let buttonClear: UIButton = {
		let button = UIButton()
		button.setTitle("Очистить", for: .normal)
		button.setTitleColor(.red, for: .normal)
		button.layer.borderColor = UIColor(ciColor: .red).cgColor
		button.layer.borderWidth = 1
		button.layer.cornerRadius = 22
		button.addTarget(TableFooter.self, action: #selector(clearAction), for: .touchUpInside)
		return button
	}()
	
	
	@objc func clearAction() {
	print(#function)
	}
	
	
	//MARK: - addSubviewAndConfigure
	internal func addSubviewAndConfigure() {
		self.backgroundColor = .orange
		self.contentView.addSubview(self.buttonClear)
	}
	
	//MARK: - layout
	internal func layout() {
		self.buttonClear.translatesAutoresizingMaskIntoConstraints = false
		self.buttonClear.widthAnchor.constraint(equalToConstant: 150).isActive = true
		self.buttonClear.heightAnchor.constraint(equalToConstant: 44).isActive = true
		self.buttonClear.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
	}
}




final class CustomCell: UITableViewCell {
	static let identifier = "CustomCell"
	
	lazy var button = makeButton()
	lazy var textFieldName = makeTextFieldName()
	lazy var textFieldAge = makeTextFieldAge()
	internal let numberToolbar = UIToolbar()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupTextFieldToolBar()
		addSubviewAndConfigure()
		layout()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

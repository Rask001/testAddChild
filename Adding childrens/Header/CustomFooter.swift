//
//  CustomFooter.swift
//  Adding childrens
//
//  Created by Антон on 24.10.2022.
//

import UIKit

final class CustomFooter: UITableViewHeaderFooterView {
	static let identifier = "TableFooter"
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		addSubviewAndConfigure()
		layout()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	let buttonClear: UIButton = {
		let button = UIButton()
		button.setTitle("Очистить", for: .normal)
		button.setTitleColor(.red, for: .normal)
		button.layer.borderColor = UIColor(ciColor: .red).cgColor
		button.layer.borderWidth = 1
		button.layer.cornerRadius = 22
		button.addTarget(self, action: #selector(clearAction), for: .touchUpInside)
		return button
	}()
	
	
	@objc func clearAction() {
		NotificationCenter.default.post(name: Notification.Name("clearAction"), object: .none)
	}
	
	
	//MARK: - addSubviewAndConfigure
	internal func addSubviewAndConfigure() {
		self.backgroundColor = .orange
		self.contentView.addSubview(self.buttonClear)
	}
	
	//MARK: - layout
	internal func layout() {
		self.buttonClear.translatesAutoresizingMaskIntoConstraints = false
		self.buttonClear.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
		self.buttonClear.widthAnchor.constraint(equalToConstant: 150).isActive = true
		self.buttonClear.heightAnchor.constraint(equalToConstant: 44).isActive = true
		self.buttonClear.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
	}
}

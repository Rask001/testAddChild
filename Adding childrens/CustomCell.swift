//
//  CustomCell.swift
//  Adding childrens
//
//  Created by Антон on 24.10.2022.
//

import Foundation
import UIKit


final class CustomCell: UITableViewCell {
	static let identifier = "CustomCell"
	
	lazy var button = makeButton()
	lazy var textFieldName = makeTextFieldName()
	lazy var textFieldAge = makeTextFieldAge()
	
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubviewAndConfigure()
		layout()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

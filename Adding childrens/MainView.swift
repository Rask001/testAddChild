//
//  ViewController.swift
//  Adding childrens
//
//  Created by Антон on 24.10.2022.
//

import UIKit

//MARK: - VIEW
class MainView: UIViewController {
	
	//MARK: - PROPERTY
	
	private let tableView = UITableView()
	let headerView = CustomHeader()
	var headerViewTopConstraint: NSLayoutConstraint?
	
	//MARK: - LIVECYCLE
	override func viewDidLoad() {
		super.viewDidLoad()
		headerView.delegate = self
		setupTableView()
		addSubview()
		layout()
	}
	
	//MARK: - SETUP
	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.backgroundColor = .red
		tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
		tableView.rowHeight = 148
		tableView.allowsSelection = false
	}
	
	//MARK: - LAYOUT
	private func addSubview() {
		self.view.backgroundColor = .white
		self.view.addSubview(headerView)
		self.view.addSubview(tableView)
	}
	
	private func layout() {
		self.headerView.translatesAutoresizingMaskIntoConstraints = false
		self.headerViewTopConstraint = self.headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -142)
		self.headerViewTopConstraint?.isActive = true
		//self.headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
		self.headerView.bottomAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
		self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		self.headerView.heightAnchor.constraint(equalToConstant: 196).isActive = true
		
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		self.tableView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor).isActive = true
		self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
		self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
	}
}

//MARK: - EXTENSION
extension MainView: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		5
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
		return cell
	}
}

extension MainView: CustomHeaderProtocol {
	func upDownHeader() {
		print(#function)
		UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0) { [weak self] in
			guard let self else { return }
			self.headerViewTopConstraint?.constant = 0
			self.headerView.textFieldAge.isHidden = false
			self.headerView.textFieldName.becomeFirstResponder()
			self.view.layoutIfNeeded()
		}
	}
}

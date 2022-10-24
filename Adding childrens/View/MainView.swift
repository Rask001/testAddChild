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
	var countChild = 0
	//MARK: - LIVECYCLE
	override func viewDidLoad() {
		super.viewDidLoad()
		headerView.delegate = self
		setupNotification()
		setupTableView()
		addSubview()
		layout()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(false)
		CoreDataMethods.shared.fetchRequest()
		self.countChild = CoreDataMethods.shared.coreDataModel.count
	}
	
	//MARK: - SETUP
	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.backgroundColor = .white
		tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
		tableView.register(TableFooter.self, forHeaderFooterViewReuseIdentifier: TableFooter.identifier)
		tableView.rowHeight = 148
		tableView.allowsSelection = false
	}
	
	func setupNotification() {
		NotificationCenter.default.addObserver(self, selector: #selector(tableViewReloadData), name: Notification.Name("TableViewReloadData"), object: .none)
	}
	
	@objc func tableViewReloadData() {
		CoreDataMethods.shared.fetchRequest()
		self.tableView.reloadData()
		showHideHeader()
	}
	
	func showHideHeader() {
		UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0) { [weak self] in
			guard let self else { return }
			if CoreDataMethods.shared.coreDataModel.count > 4 {
				self.headerViewTopConstraint?.constant = -186
				self.headerView.addChildButton.isHidden = true
				self.headerView.bottomLabel.isHidden = true
				self.headerView.textFieldAge.isHidden = false
			} else {
				self.headerViewTopConstraint?.constant = 0
				self.headerView.addChildButton.isHidden = false
				self.headerView.bottomLabel.isHidden = false
				self.headerView.textFieldAge.isHidden = false
			}
			self.view.layoutIfNeeded()
		}
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
		self.headerView.bottomAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
		self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		self.headerView.heightAnchor.constraint(equalToConstant: 206).isActive = true
		
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
		CoreDataMethods.shared.coreDataModel.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
		let items = CoreDataMethods.shared.coreDataModel[indexPath.row]
		cell.button.tag = indexPath.row
		cell.textFieldName.text = items.name
		cell.textFieldAge.text = String(items.age)
		return cell
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		1
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let foooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableFooter.identifier) as? TableFooter
		return foooter
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 64
	}
	
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

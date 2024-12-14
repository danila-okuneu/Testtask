//
//  UsersView.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit
import SnapKit

protocol UsersViewProtocol: AnyObject {
	
	var presenter: UsersPresenterProtocol? { get set }
}

protocol UsersViewInputs: AnyObject {
	
	// Define input methods
}

protocol UsersViewOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - View
final class UsersViewController: UIViewController, UsersViewProtocol {
	
	var presenter: UsersPresenterProtocol?
	
	// MARK: - UI Components
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifire)
		tableView.showsVerticalScrollIndicator = false
		tableView.separatorInset = UIEdgeInsets(top: 0, left: 66, bottom: 0, right: 0)
		tableView.allowsSelection = false
		return tableView
	}()
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}
	
	// MARK: - Layout
	private func setupViews() {
		
		view.addSubview(tableView)
		tableView.delegate = self
		tableView.dataSource = self
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		
		tableView.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(90)
			make.bottom.equalToSuperview()
			make.horizontalEdges.equalToSuperview().inset(16)
		}
		
		
	}
	
	
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		6
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		TableViewCell()
	}
	
}


// MARK: - Input & Output
extension UsersViewController: UsersViewInputs, UsersViewOutputs {
	
	// Extend functionality
}


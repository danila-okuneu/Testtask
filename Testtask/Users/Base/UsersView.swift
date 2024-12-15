//
//  UsersView.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit
import SnapKit

protocol UsersViewProtocol: AnyObject {
	
	var presenter: UsersPresenter? { get set }
}

protocol UsersViewInputs: AnyObject {
	
	func updateUsers(_ users: [User], count: Int)
}

protocol UsersViewOutputs: AnyObject {
	
	func userDidScrollToEnd() async
}

// MARK: - View
final class UsersViewController: UIViewController, UsersViewProtocol {
	
	
	var presenter: UsersPresenter?
	
	var users: [User] = [ ]
	var totalUsers: Int = 0
	var isLoading = true
	
	// MARK: - UI Components
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.register(UserViewCell.self, forCellReuseIdentifier: UserViewCell.identifire)
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

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter?.viewWillAppear()
	}
	
	// MARK: - Layout
	private func setupViews() {
		
		navigationItem.title = "Working with GET request"
		view.addSubview(tableView)
		tableView.delegate = self
		tableView.dataSource = self
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		
		tableView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.bottom.equalToSuperview()
			make.horizontalEdges.equalToSuperview().inset(16)
		}
		
		
	}
	
	
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		isLoading ? 6 : totalUsers
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UserViewCell()
		
		if isLoading {
			return cell
		} else {
			guard indexPath.row < users.count else {
				if !isLoading && !users.isEmpty {
					Task {
						await presenter?.userDidScrollToEnd()
					}
				}
				return cell
			}
			cell.update(with: users[indexPath.row])
			return cell
		}
	}
}


// MARK: - Input & Output
extension UsersViewController: UsersViewInputs {
	
	func updateUsers(_ users: [User], count: Int) {
		isLoading = false
		totalUsers = count
		
		DispatchQueue.main.sync {
		
			tableView.reloadData()
			
			for (index, user) in users.enumerated() {
				if let cell = tableView.cellForRow(at: IndexPath(row: self.users.count - 1 + index, section: 0)) as? UserViewCell {
					cell.update(with: user)
				}
			}
		}
		
		self.users += users
		
		
		
	}
	
	
	// Extend functionality
}


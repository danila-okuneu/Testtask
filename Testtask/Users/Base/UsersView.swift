//
//  UsersView.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit
import SnapKit

protocol UsersViewProtocol: AnyObject {
	
	var presenter: UsersViewOutputs? { get set }
}

protocol UsersViewInputs: AnyObject {
	
	func loadUsers(_ users: [User])
	func showsActivity(_ bool: Bool)
	func didLoadAllPages()
	
}

protocol UsersViewOutputs: AnyObject {
	
	func viewWillAppear()
	func didScrollToEnd() async
	func didRefreshTable() async
	
}

// MARK: - View
final class UsersViewController: UIViewController, UsersViewProtocol {
	
	
	var presenter: UsersViewOutputs?
	
	var users: [User] = [ ]
	var isLoading = true
	
	// MARK: - UI Components
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.register(UserViewCell.self, forCellReuseIdentifier: UserViewCell.identifire)
		tableView.showsVerticalScrollIndicator = false
		tableView.separatorInset.left = C.UsersTable.separatorInset
		tableView.allowsSelection = false
		tableView.backgroundColor = .white
		let spinner = UIActivityIndicatorView(style: .medium)
		spinner.color = .gray
		spinner.startAnimating()
		spinner.frame = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: C.UsersTable.spinnerHeight)

		tableView.tableFooterView = spinner
		
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
		
		view.backgroundColor = .white
		navigationItem.title = "Working with GET request"
		view.addSubview(tableView)
		
		setupTableView()
		setupConstraints()
	}
	
	private func setupConstraints() {
		
		tableView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.bottom.equalToSuperview()
			make.horizontalEdges.equalToSuperview().inset(C.padding)
		}
	}
	
	// MARK: - Methods
	private func setupTableView() {
		
		tableView.delegate = self
		tableView.dataSource = self
		
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(refreshUsers), for: .valueChanged)
		refreshControl.tintColor = .gray
		tableView.refreshControl = refreshControl
		
	}
	
	// MARK: - Selectors
	@objc private func refreshUsers() {
		Task {
			users = [ ]
			tableView.reloadData()
			await presenter?.didRefreshTable()
			tableView.refreshControl?.endRefreshing()
		}
		
	}
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		users.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: UserViewCell.identifire, for: indexPath) as! UserViewCell
		
		if indexPath.row < users.count {
			cell.update(with: users[indexPath.row])
		}
		
		if indexPath.row == users.count - 1 && !isLoading {
			isLoading = true
			Task {
				await presenter?.didScrollToEnd()
			}
		}
		return cell
	}
}


// MARK: - Input & Output
extension UsersViewController: UsersViewInputs {
	
	func showsActivity(_ bool: Bool) {
		DispatchQueue.main.sync {
			self.tableView.tableFooterView?.isHidden = bool			
		}
	}
	
	func loadUsers(_ newUsers: [User]) {
		let startIndex = users.count
		let endIndex = startIndex + newUsers.count
		let indexPaths = (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
		
		users += newUsers
		isLoading = false
		
		DispatchQueue.main.sync {
			self.tableView.performBatchUpdates {
				self.tableView.insertRows(at: indexPaths, with: .automatic)
			}
		}
	}
	
	func didLoadAllPages() {
		showsActivity(true)
	}
}


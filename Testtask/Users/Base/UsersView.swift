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

protocol UsersViewInput: AnyObject {
	
	func loadUsers(_ users: [User])

	func showsActivity(_ bool: Bool)
	func didLoadAllPages()
	
}

protocol UsersViewOutputs: AnyObject {
	
	func userDidScrollToEnd() async
	
}

// MARK: - View
final class UsersViewController: UIViewController, UsersViewProtocol {
	
	
	var presenter: UsersPresenter?
	
	var users: [User] = [ ]
	var isLoading = true
	
	// MARK: - UI Components
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.register(UserViewCell.self, forCellReuseIdentifier: UserViewCell.identifire)
		tableView.showsVerticalScrollIndicator = false
		tableView.separatorInset.left = 72
		tableView.allowsSelection = false
		
		let spinner = UIActivityIndicatorView(style: .medium)
		spinner.startAnimating()
		spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

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
		users = [ ]
		isLoading = true
		tableView.reloadData()
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
				await presenter?.userDidScrollToEnd()
				
			}
		}
		return cell
	}
}


// MARK: - Input & Output
extension UsersViewController: UsersViewInput {
	
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


//
//  TabView.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit
import SnapKit

protocol TabViewProtocol: AnyObject {
	
	var presenter: TabPresenterProtocol? { get set }
}

protocol TabViewInputs: AnyObject {
	
	func addTab(
		_ viewController: UIViewController,
		title: String,
		image: UIImage?,
		selectedImage: UIImage?
	)
}

protocol TabViewOutputs: AnyObject {

	// Define output methods
}

// MARK: - View
final class TabViewController: UITabBarController, TabViewProtocol {
	
	var presenter: TabPresenterProtocol?

	private let buttonsStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.alignment = .center
		stack.distribution = .fillEqually
		return stack
	}()

	private var customTabItems: [TabBarItemView] = []

	init() {
		super.init(nibName: nil, bundle: nil)
		
		// Спрячем стандартный UITabBarItem текст и картинки, чтобы они не мешали
		tabBar.backgroundImage = UIImage()
		tabBar.shadowImage = UIImage()
		
		// Добавляем свой stackView
		tabBar.addSubview(buttonsStack)
		buttonsStack.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		tabBar.isTranslucent = false
		tabBar.backgroundColor = .tabBarBackground
		tabBar.barTintColor = .tabBarBackground
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter?.viewWillAppear()
	}
}

// MARK: - Input & Output
extension TabViewController: TabViewInputs, TabViewOutputs {
	
	func addTab(
		_ viewController: UIViewController,
		title: String,
		image: UIImage?,
		selectedImage: UIImage? = nil
	) {
		
		if let vcs = viewControllers {
			viewControllers = vcs + [viewController]
		} else {
			viewControllers = [viewController]
		}
		
		
		let tabItemView = TabBarItemView()
		tabItemView.configure(title: title, image: image, selectedImage: selectedImage)
		
		
		let index = (viewControllers?.count ?? 1) - 1
		tabItemView.button.tag = index
		tabItemView.button.addTarget(self, action: #selector(handleTabTap(_:)), for: .touchUpInside)
		
		
		buttonsStack.addArrangedSubview(tabItemView)
		customTabItems.append(tabItemView)
	}
	
	@objc private func handleTabTap(_ sender: UIButton) {
		let index = sender.tag
		selectedIndex = index
		
		
		for (i, item) in customTabItems.enumerated() {
			item.setSelected(i == index)
		}
	}
}

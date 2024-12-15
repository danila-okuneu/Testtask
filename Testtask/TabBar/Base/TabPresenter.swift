//
//  Untitled.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit

// MARK: - Presenter Protocol
protocol TabPresenterProtocol: AnyObject {
	
	var view: TabViewInputs? { get set }
	var interactor: TabInteractorProtocol? {get set }
	
}

// MARK: - Presenter
final class TabPresenter: TabPresenterProtocol {
	
	weak var view: TabViewInputs?
	var interactor: TabInteractorProtocol?
}


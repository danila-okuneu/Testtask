//
//  RadioButton.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit
import SnapKit

final class RadioButton: UIButton {
	
	// MARK: - UI Components
	// Changing the .cornerRadius of self may cause usability issues:
	// the user interaction area could become too small.
	let circleView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = C.RadioButton.size / 2
		view.backgroundColor = .white
		view.layer.borderWidth = C.RadioButton.borderWidht
		view.layer.borderColor = UIColor.fieldBorderNormal.cgColor
		view.isUserInteractionEnabled = false
		view.layer.cornerRadius = C.RadioButton.size / 2
		view.backgroundColor = .white
		return view
	}()
	
	let innerCircleView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = C.RadioButton.innerCircleSize / 2
		view.isUserInteractionEnabled = false
		view.backgroundColor = .white
		return view	}()
	
	// MARK: - Initializers
	init() {
		super.init(frame: .zero)
		setupViews()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Layout
	private func setupViews() {
		addSubview(circleView)
		circleView.addSubview(innerCircleView)
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		
		circleView.snp.makeConstraints { make in
			make.width.height.equalTo(C.RadioButton.size)
			make.center.equalToSuperview()
		}
		
		innerCircleView.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.size.equalTo(C.RadioButton.innerCircleSize)
		}
	}
	
	// MARK: - Methods
	func selectedAppearance() {
		
		circleView.layer.borderColor = UIColor.appCyan.cgColor
		circleView.backgroundColor = .appCyan
	}
	
	func resetAppearance() {
		
		UIView.transition(with: circleView, duration: 0.1, options: [.transitionCrossDissolve, .curveEaseOut]) {
			self.circleView.layer.borderColor = UIColor.fieldBorderNormal.cgColor
			self.circleView.backgroundColor = .white
		}
	}
}

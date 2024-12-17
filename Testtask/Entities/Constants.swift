//
//  Constants.swift
//  Testtask
//
//  Created by Danila Okuneu on 18.12.24.
//

import UIKit


typealias C = Constants

/// A centralized structure to store app-wide constants, such as spacing, fonts, colors, and other UI-related values.
/// The `Constants` struct helps to avoid magic numbers and hardcoded values throughout the codebase,
/// ensuring better maintainability, consistency, and readability.
///
/// Usage:
/// - Use `Constants` to access predefined values for layout, fonts, and reusable components.
/// - Organize constants into nested structures to group related values logically (e.g., `Font`, `Button`, `UserCell`).
/// - For convenience, you can use a typealias, such as `C`, to shorten access to constants.
///
/// Example:
/// ```
/// let padding = Constants.padding
/// button.layer.cornerRadius = Constants.Button.cornerRadius
/// titleLabel.font = Constants.Font.heading
/// ```
/// Use `C` as a shorthand for accessing constants throughout the project.
/// This helps to shorten your code and improve readability.
///
///Example:
/// ```
/// let padding = C.padding
/// button.layer.cornerRadius = C.Button.cornerRadius
/// titleLabel.font = C.Font.heading
/// ```
struct Constants {
	
	private static let ratio = CGFloat.ratio
	
	static let padding = 16 * ratio
	static let spacing = 24 * ratio
	
	static let semispacing = spacing / 2
	static let semipadding = padding / 2
	
	
	
	// MARK: - Fonts
	struct Font {
		static let heading = UIFont.nunitoSans(ofSize: 20)
		static let bodyLarge = UIFont.nunitoSans(ofSize: 18)
		static let bodyMedium = UIFont.nunitoSans(ofSize: 16)
		static let bodySmall = UIFont.nunitoSans(ofSize: 14)
		static let supporting = UIFont.nunitoSans(ofSize: 12)
	}
	
	struct MainButton {
		
		static let height = 48 * ratio
		static let width = 140 * ratio
		
		static let font = UIFont.nunitoSans(ofSize: 18, weight: .semibold)
	}
	
	struct SecondaryButton {
		
		static let height = 40 * ratio
		static let width = 91 * ratio
		
		static let font = UIFont.nunitoSans(ofSize: 16, weight: .semibold)
	}

	struct SupportedView {
		
		static let cornerRadius = 4 * ratio
		static let primaryHeight = 56 * ratio
		static let supportingHeight = 20 * ratio
	}
	
	struct UserCell {
		
		static let photoSize = 50 * ratio
		static let photoCornerRadius = photoSize / 2
	}
	
	struct UsersTable {
		static let separatorInset = UserCell.photoSize + padding
		static let spinnerHeight = 44 * ratio
	}
	
	struct RadioButton {
		
		static let size = 13 * ratio // without border
		static let borderWidht = 1 * ratio
		
		static let innerCircleSize = 6 * ratio
	}
	
	struct Connection {
		static let imageHeight = 200 * ratio
	}
	
	struct Result {
		static let imageHeight = 200 * ratio
	}
}

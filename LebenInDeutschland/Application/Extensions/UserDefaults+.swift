//
//  UserDefaults.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 17.02.24.
//

import Foundation

extension UserDefaults {
	// https://stackoverflow.com/questions/545091/clearing-nsuserdefaults
	/// Clear contents of the app stored in the shared preferences
	func clear() {
		guard let domainName = Bundle.main.bundleIdentifier else {
			return
		}
		removePersistentDomain(forName: domainName)
		synchronize()
	}
}

//
//  AdView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 03.06.23.
//

import SwiftUI
import GoogleMobileAds

struct Adview: UIViewRepresentable {
	var adUnitID: String
	
	init(adUnitID: String = "ca-app-pub-3940256099942544/2934735716") { // TODO: Replace default value with actual value from environment
		self.adUnitID = adUnitID
	}
	
	typealias UIViewType = GADBannerView
	
	func makeUIView(context: Context) -> GADBannerView {
		let banner = GADBannerView(adSize: GADAdSizeFluid)
		banner.adUnitID = self.adUnitID
		banner.rootViewController = UIApplication.shared.windows.first?.rootViewController!
		banner.load(GADRequest())
		return banner
	}
	
	func updateUIView(_ uiView: GADBannerView, context: Context) {
		// TODO: Implement
	}
}

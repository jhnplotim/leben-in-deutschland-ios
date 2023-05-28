//
//  SettingsViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 25.05.23.
//

import Foundation
import Combine

typealias ShareObject = (String, String, URL)

final class SettingsViewModel: ObservableObject {
    
    @Published var vibrateOnWrongAnswer = false
    
    @Published var selectedState: FederalState
    
    let shareObject: ShareObject = ("Share", "Hey, I am using Leben In Deutschland to prepare for the German Einbürgerungstest. I think you will like it too. ",
                                    URL(string: "https://github.com/jhnplotim/leben-in-deutschland-ios")!) // TODO: Use app store link later
    
    private var _settingsStore: SettingsStore
    
    private var reviewService: ReviewService
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(_ settingsStore: some SettingsStore, _ reviewService: some ReviewService) {
        self.reviewService = reviewService
        self._settingsStore = settingsStore
        self.vibrateOnWrongAnswer = self._settingsStore.vibrateOnFalseAnswer
        self.selectedState = self._settingsStore.stateOfResidence
        
        $vibrateOnWrongAnswer.sink(receiveValue: { newValue in
            if self._settingsStore.vibrateOnFalseAnswer != newValue {
                self._settingsStore.vibrateOnFalseAnswer = newValue
            }
        }).store(in: &cancellables)
        
        $selectedState.sink(receiveValue: { newValue in
                if self._settingsStore.stateOfResidence != newValue {
                    self._settingsStore.stateOfResidence = newValue
                }
        }).store(in: &cancellables)
    }
    
    func rateApp(_ appStoreId: String = BuildConfig.shared.appStoreId) {
        reviewService.requestReviewManually(appStoreId: appStoreId)
    }
    
}

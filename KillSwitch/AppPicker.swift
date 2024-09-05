//
//  AppPicker.swift
//  KillSwitch
//
//  Created by GooseMooz on 2024-08-29.
//
import FamilyControls
import SwiftUI
import ManagedSettings
import Foundation

class AppPicker: ObservableObject {
    static let shared = AppPicker();
    private let store = ManagedSettingsStore()
    @Published var isEmpty: Bool = false
    let encoder = PropertyListEncoder()
    let decoder = PropertyListDecoder()
    
    private init() {}
    
    var selectionToDiscourage = FamilyActivitySelection() {
        willSet {
            UserDefaults.standard.set(try? self.encoder.encode(newValue), forKey: "Selection to Discourage")
            checkEmpty()
        }
    }
    
    func updateSelection() {
        guard let data = UserDefaults.standard.data(forKey: "Selection to Discourage") else {
            print("No data saved")
            return
        }
        
        selectionToDiscourage = try! decoder.decode(FamilyActivitySelection.self, from: data)
        checkEmpty()
    }
    
    func auth() async throws {
        try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
    }
    
    func initiateKill() {
        guard let data = UserDefaults.standard.data(forKey: "Selection to Discourage") else {
            print("No data saved")
            return
        }
        
        if let selections = try? decoder.decode(FamilyActivitySelection.self, from: data) {
            store.shield.applications = selections.applicationTokens.isEmpty ? nil : selections.applicationTokens
            store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(selections.categoryTokens)
            store.shield.webDomains = selections.webDomainTokens
            store.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.specific(selections.categoryTokens)
        }
        
        store.media.denyExplicitContent = true
    }
    
    func initiateRevive() {
        store.shield.applications = []
        
        store.shield.applicationCategories = ShieldSettings
                    .ActivityCategoryPolicy
                    .specific([])
        
        store.shield.webDomainCategories = ShieldSettings
                    .ActivityCategoryPolicy
                    .specific([])
        
        store.media.denyExplicitContent = false
    }
    
    func checkEmpty() {
        if (!selectionToDiscourage.applicationTokens.isEmpty || !selectionToDiscourage.categoryTokens.isEmpty || !selectionToDiscourage.webDomainTokens.isEmpty) {
            isEmpty = false
        } else if (selectionToDiscourage.applicationTokens.isEmpty && selectionToDiscourage.categoryTokens.isEmpty && selectionToDiscourage.webDomainTokens.isEmpty) {
            isEmpty = true
        }
    }
}

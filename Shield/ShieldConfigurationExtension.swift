//
//  ShieldConfigurationExtension.swift
//  Shield
//
//  Created by GooseMooz on 2024-10-14.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit

// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    
    let title = "KillSwitch"
    let body = "Your flow will be interrupted, this is a distraction."
    
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        // Customize the shield as needed for applications.
        return ShieldConfiguration(
            backgroundBlurStyle: UIBlurEffect.Style.dark,
            backgroundColor: UIColor.clear,
            icon: UIImage(named: "Vector_Glow.png"),
            title: ShieldConfiguration.Label(text: title, color: .white),
            subtitle: ShieldConfiguration.Label(text: body, color: .white),
            primaryButtonLabel: ShieldConfiguration.Label(text: "Get Back To Work", color: UIColor.black),
            primaryButtonBackgroundColor: .white,
            secondaryButtonLabel: nil)
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for applications shielded because of their category.
        return ShieldConfiguration(
            backgroundBlurStyle: UIBlurEffect.Style.dark,
            backgroundColor: UIColor.clear,
            icon: UIImage(named: "Vector_Glow.png"),
                    title: ShieldConfiguration.Label(text: title, color: .white),
                    subtitle: ShieldConfiguration.Label(text: body, color: .white),
                    primaryButtonLabel: ShieldConfiguration.Label(text: "Get Back To Work", color: UIColor.black),
                    primaryButtonBackgroundColor: .white,
                    secondaryButtonLabel: nil)
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        return ShieldConfiguration(
            backgroundBlurStyle: UIBlurEffect.Style.dark,
            backgroundColor: UIColor.clear,
            icon: UIImage(named: "Vector_Glow.png"),
                    title: ShieldConfiguration.Label(text: title, color: .white),
                    subtitle: ShieldConfiguration.Label(text: body, color: .white),
                    primaryButtonLabel: ShieldConfiguration.Label(text: "Get Back To Work", color: UIColor.black),
                    primaryButtonBackgroundColor: .white,
                    secondaryButtonLabel: nil)
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for web domains shielded because of their category.
        return ShieldConfiguration(
            backgroundBlurStyle: UIBlurEffect.Style.dark,
            backgroundColor: UIColor.gray,
            icon: UIImage(named: "Vector_Glow.png"),
                    title: ShieldConfiguration.Label(text: title, color: .white),
                    subtitle: ShieldConfiguration.Label(text: body, color: .white),
                    primaryButtonLabel: ShieldConfiguration.Label(text: "Get Back To Work", color: UIColor.black),
                    primaryButtonBackgroundColor: .white,
                    secondaryButtonLabel: nil)
    }
}

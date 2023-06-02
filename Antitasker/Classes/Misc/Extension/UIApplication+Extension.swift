//
//  UIApplication+Extension.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 02.06.2023.
//

import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
}

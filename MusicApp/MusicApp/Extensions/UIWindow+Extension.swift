//
//  UIWindow+Extension.swift
//  MusicApp
//
//  Created by Lauv Edward on 04/09/2021.
//

import UIKit
extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

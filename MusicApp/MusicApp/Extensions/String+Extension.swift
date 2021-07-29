//
//  String+Extension.swift
//  MusicApp
//
//  Created by Lauv Edward on 26/07/2021.
//

import UIKit

extension String {
    var localized: String {
        return LocalizeManager.shared.stringForKey(key: self)
    }
}

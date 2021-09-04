//
//  NSObject+Extension.swift
//  MusicApp
//
//  Created by Lauv Edward on 04/09/2021.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}


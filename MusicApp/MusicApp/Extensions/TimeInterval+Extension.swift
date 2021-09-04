//
//  TimeInterval+Extension.swift
//  MusicApp
//
//  Created by Lauv Edward on 28/08/2021.
//

import Foundation

extension TimeInterval {
    func convertToMinnuteAndSecond() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
//        formatter.unitsStyle = .brief
        formatter.zeroFormattingBehavior = .pad
        guard let time = formatter.string(from: self) else {
            return "Error"
        }
        return time
    }
}

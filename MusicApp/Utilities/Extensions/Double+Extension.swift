//
//  Double+Extension.swift
//  MusicApp
//
//  Created by Praful Mahajan on 29/05/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import Foundation

extension Double {
    //**************************************************
    // MARK: - Methods
    //**************************************************
    func toString()->String{
        return String(format: "%.2f", self)
    }

    func toInt() -> Int {
        return Int(self)
    }

    func toLocationString()->String {
        return String(format: "%.7f", self)
    }

    private var formatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }

    func secondsToString() -> String {
        return formatter.string(from: self) ?? ""
    }
}

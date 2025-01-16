//
//  Numeric+Ext.swift
//  Lyronel
//
//  Created by Gaurang on 22/12/22.
//

import Foundation

extension Double {
    
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func toCurrencyString(
        _ symbol: String = ClientService.shared.currencySymbol
    ) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        //currencyFormatter.locale = Locale(identifier: "en_KE")
        if symbol.isNotEmpty {
            currencyFormatter.currencySymbol = symbol
        }
        currencyFormatter.minimumFractionDigits = 0
        currencyFormatter.maximumFractionDigits = 2
        let priceString = currencyFormatter.string(from: NSNumber(value: self))!
        return priceString
    }
}

extension Double {
    func getAspectHeight() -> CGFloat {
        Helper.screenSize.height * CGFloat(self) // 932: Standard
    }
    
    func getAspectWidth() -> CGFloat {
        Helper.screenSize.width * CGFloat(self) // 430: Standard
    }
}

extension Double {
    
    func responsiveVertical() -> CGFloat {
        let ratio = Helper.screenSize.height / 932
        return self * ratio
    }
    
    func responsiveHorizonal() -> CGFloat {
        let ratio = Helper.screenSize.width / 430
        return self * ratio
    }
}

extension Numeric {
    func toString() -> String {
        return String(describing: self)
    }
}

extension Int {
    func toString(leadingZero: Bool = false) -> String {
        if leadingZero {
            return String(format: "%02d", self)
        } else {
            return String(self)
        }
    }
}

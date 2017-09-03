//
//  MenuController.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import UIKit

class MenuController: NSObject {
    
    private var isShown = false
    
    private enum Animation {
        case on, off(BitcoinConversion)
    }
    
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var euroButton: CurrencyButton! { didSet { euroButton.setup(for: .euro) }}
    @IBOutlet private weak var dollarButton: CurrencyButton! { didSet { dollarButton.setup(for: .dollar) }}
    @IBOutlet private weak var poundButton: CurrencyButton! { didSet { poundButton.setup(for: .pound) }}
    
    @IBAction private func currencyButtonPressed(_ button: CurrencyButton) {
        let animation: Animation

        if isShown {
            button.conversion.save()
            animation = .off(button.conversion)
        } else {
            animation = .on
        }
        
        isShown = !isShown

        UIView.animate(withDuration: 0.2, animations: {
            self.animation(animation)
        }) { _ in
            self.stackView.insertArrangedSubview(button, at: self.stackView.subviews.count)
        }
    }

    func set(for conversion: BitcoinConversion) {
        animation(.off(conversion))
    }

    private func animation(_ animation: Animation) {
        switch animation {
        case .on: stackView.alpha = 1
        default: stackView.alpha = 0.5
        }
        
        [euroButton, dollarButton, poundButton].forEach { button in
            let isHidden: Bool

            switch animation {
            case .on: isHidden = false
            case let .off(conversion): isHidden = button?.conversion != conversion
            }

            button?.isHidden = isHidden
        }
    }
}

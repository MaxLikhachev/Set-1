//
//  SetCardButton.swift
//  Set
//
//  Created by Татьяна Пятыхина on 19/12/2018.
//  Copyright © 2018 Татьяна Пятыхина. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class SetCardButton: BorderButton {
    
    var colors = [ #colorLiteral(red: 0.9058823529, green: 0.1718198397, blue: 0.1607316637, alpha: 1), #colorLiteral(red: 0.001422109781, green: 0.6123144031, blue: 0.156824559, alpha: 1), #colorLiteral(red: 0.1598622501, green: 0.688119173, blue: 0.7642399073, alpha: 1) ]
    var alphas: [CGFloat] = [1.00, 0.40, 0.15]
    var symbols = ["▲", "•", "■"]
    var strokeWidths: [CGFloat] = [ -8, 8, -8]
    
    var setCard: SetCard? {
        didSet { updateButton() }
    }
    
    private func updateButton() {
        if let card = setCard { // карта в игре
            let attributedString  = setAttributedString(card: card)
            setAttributedTitle(attributedString, for: .normal)
            backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            isEnabled = true // возможность взаимодействия с кнопкой
        } else { // удаленная карта
            setAttributedTitle(nil, for: .normal)
            setTitle(nil, for: .normal)
            backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
            borderColor =   #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            isEnabled = false
        }
    }
    
    private func setAttributedString (card: SetCard) -> NSAttributedString {
        let symbol = symbols [card.symbol.idx]
        let separator = verticalSizeClass == .regular ? "\n" : " "
        let symbolsString = symbol.join(n: card.number.rawValue, with: separator)
        let attributes:[NSAttributedStringKey : Any] = [
            .strokeColor: colors[card.color.idx],
            .strokeWidth: strokeWidths[card.fill.idx],
            .foregroundColor: colors[card.color.idx].withAlphaComponent(alphas[card.fill.idx])
        ]
        return NSAttributedString(string: symbolsString, attributes: attributes)
    }
    
    // для определения портретного или ландшафтного режима
    var verticalSizeClass: UIUserInterfaceSizeClass {
        return UIScreen.main.traitCollection.verticalSizeClass
    }
    
    // изменение кнопки при повороте устройства
    override func layoutSubviews() {
        super.layoutSubviews()
        updateButton()
    }
}


// Для удобства формирования строки String из произвольного числа заданных символов с разделителем separator
extension String {
    func join(n: Int, with separator:String )-> String{
        guard n > 1 else {return self}
        var symbols = [String] ()
        for _ in 0..<n {
            symbols += [self]
        }
        return symbols.joined(separator: separator)
    }
}

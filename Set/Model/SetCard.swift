//
//  SetCard.swift
//  Set
//
//  Created by Татьяна Пятыхина on 09/12/2018.
//  Copyright © 2018 Татьяна Пятыхина. All rights reserved.
//

import Foundation

struct SetCard: CustomStringConvertible {
    var description: String {return "\(number)-\(color)-\(symbol)-\(fill)"}
    
    // характеристики карты в игре Set
    let number: Variant
    let color: Variant
    let symbol: Variant
    let fill: Variant
    
    enum Variant: Int, CustomStringConvertible {
        case v1 = 1
        case v2
        case v3
        
        static var all: [Variant]{return [.v1, .v2, .v3]}
        var description: String {return String(self.rawValue)}
        var idx: Int {return (self.rawValue - 1)} // для доступа к элементу массива (вместо card.symbol.rawValue — 1)
    }
    
    // составляют ли три карты Set
    static func isSet(cards: [SetCard]) -> Bool {
        guard cards.count == 3 else {return false}  // guard проверяет условие, и если оно не выполнилось — требует выйти из текущего блока
        let sum = [
            cards.reduce(0, { $0 + $1.number.rawValue}),
            cards.reduce(0, { $0 + $1.color.rawValue}),
            cards.reduce(0, { $0 + $1.symbol.rawValue}),
            cards.reduce(0, { $0 + $1.fill.rawValue})
        ]
        return sum.reduce(true, { $0 && ($1 % 3 == 0) })
    }
}


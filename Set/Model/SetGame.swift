//
//  SetGame.swift
//  Set
//
//  Created by Татьяна Пятыхина on 09/12/2018.
//  Copyright © 2018 Татьяна Пятыхина. All rights reserved.
//

import Foundation

private struct Score {
    static let cardsIsSet = 10
    static let cardsIsNotSet = -5
}

struct SetGame {
    
    var playerIndex = 0
    
    private(set) var flipCount = [0,0]
    private(set) var score = [0,0]
    private(set) var numberSets = [0,0]

    private var deck = SetCardDeck()
    
    var activeCards = [SetCard]() // карты в игре (на столе)
    var selectedCards = [SetCard]() // выбранные карты
    var matchedCards = [SetCard]() // карты, проверяемые на Set
    var removedCards = [SetCard]() // удаленные карты
    
    // получение трех случайных карт из колоды
    private mutating func takeThreeCardsFromDeck() -> [SetCard]? {
        var threeCards = [SetCard]()
        for _ in 0...2 {
            if let card = deck.draw() {
                threeCards += [card]
            } else {
                return nil
            }
        }
        return threeCards
    }
    
    // сдача еще 3 карт из колоды
    mutating func dealThreeMoreCards() {
        if let dealThreeCards = takeThreeCardsFromDeck() {
            activeCards += dealThreeCards
        }
    }
    
    // замена удаленных карт на новые из колоды
    private mutating func replaceOrRemove3Cards(){
        if let take3Cards =  takeThreeCardsFromDeck() {
            activeCards.replace(elements: matchedCards, with: take3Cards)
        } else {
            activeCards.remove(elements: matchedCards)
        }
        removedCards += matchedCards
        matchedCards.removeAll()
    }
    
    var isSet: Bool? {
        get {
            guard matchedCards.count == 3 else {return nil} // guard проверяет условие, и если оно не выполнилось — требует выйти из текущего блока
            return SetCard.isSet(cards: matchedCards)
        }
        set {
            if newValue != nil {
                if newValue! {
                    score [playerIndex] += Score.cardsIsSet
                    numberSets [playerIndex] += 1
                } else {
                    score [playerIndex] += Score.cardsIsNotSet
                }
                matchedCards = selectedCards
                selectedCards.removeAll()
            } else {
                matchedCards.removeAll()
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        let card = activeCards[index]
        if !removedCards.contains(card){
            if  isSet != nil{
                if isSet! { replaceOrRemove3Cards()}  // ! - развертывание
                isSet = nil
            }
            if selectedCards.count == 2, !selectedCards.contains(card) {
                selectedCards += [card]
                isSet = SetCard.isSet(cards: selectedCards)
            } else {  // карта переворачивается
                if(!selectedCards.contains(card)) {
                    selectedCards += [card]
                } else {
                    selectedCards.remove(at: selectedCards.index(of:card))
                }
            }
        }
    }
}


extension Array where Element : Equatable {
    
    mutating func remove(elements: [Element]){
        self = self.filter { !elements.contains($0) }
    }
    
    mutating func replace(elements: [Element], with new: [Element] ){
        guard elements.count == new.count else {return}
        for idx in 0..<new.count {
            if let indexMatched = self.index(of: elements[idx]){
                self [indexMatched ] = new[idx]
            }
        }
    }
    
}

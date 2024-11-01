//
//  MainDatabaseLoader.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 10/7/2024.
//

import Foundation
import SwiftUI
class ExamElevateModel: ObservableObject {
    
    var Globaldatabaseinstance: [SubjectDeck]
    var databasemanager: Deckmanager
    var randomlist: [Card] = []
//    @State var OnlineHelpPopup: Bool = false
    init(){
        databasemanager = Deckmanager()
        Globaldatabaseinstance = Deckmanager().Getsylibus()
        randomlist = randomList()
    }
    func Activelist() -> [Card] {
        let Preculled = self.Globaldatabaseinstance
        var postculled: [Card] = []
        for Subject in Preculled {
            if Subject.activated {
                for cards in Subject.deck {
                    if cards.activated {
                        postculled.append(cards)
                    }
                }
            }
        }
        if postculled == []{
            postculled.append(Preculled[0].deck[0])// this is for the specific case where all cards are deactivated, to prevent errors detected in testing, the active list must have at least 1 element
        }
        return postculled
    }
    func randomList() -> [Card]{
        return self.Activelist().shuffled()
    }
    func stubfunction() {
        
    }
    func AppendACard(Card: Card, index: Int) {
        Globaldatabaseinstance[index].deck.append(Card)
        databasemanager.SaveSomething(Deck: Globaldatabaseinstance)
    }
    func savedatabaase() {
        databasemanager.SaveSomething(Deck: Globaldatabaseinstance)
        randomlist = randomList()
    }
}

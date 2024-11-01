//
//  SylibusStruct.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 8/12/2023.
//

import Foundation
import SwiftUI
import Combine

class SubjectDeck: Identifiable, Codable {
    var id: UUID = UUID()
    var subject: String
    var activated: Bool
    var deck: [Card]

}

class Card: Identifiable, Codable, Equatable {
    // general info
    var id: UUID = UUID()
    var dotpoint: String
    var activated: Bool
    var custom: Bool

    // flashcard
    var flashcardfront: String
    var flashcardback: String

    // multichoice
    var question: String
    var answer1: String
    var answer2: String
    var answer3: String
    var answer4: String
    var answerpos: Int

    // notes
    var dotpointnotes: String
    
    
    init(dotpoint: String, activated: Bool, custom: Bool, flashcardfront: String, flashcardback: String, question: String, answer1: String, answer2: String, answer3: String, answer4: String, answerpos: Int, dotpointnotes: String) {
        self.id = UUID()
        self.dotpoint = dotpoint
        self.activated = activated
        self.custom = custom
        self.flashcardfront = flashcardfront
        self.flashcardback = flashcardback
        self.question = question
        self.answer1 = answer1
        self.answer2 = answer2
        self.answer3 = answer3
        self.answer4 = answer4
        self.answerpos = answerpos
        self.dotpointnotes = dotpointnotes
    }

    static func == (lhs: Card, rhs: Card) -> Bool {
        var similarity = 0
        if lhs.dotpoint == rhs.dotpoint { similarity += 1 }
        if lhs.flashcardback == rhs.flashcardback { similarity += 1 }
        if lhs.flashcardfront == rhs.flashcardfront { similarity += 1 }
        if lhs.question == rhs.question { similarity += 1 }
        // the cards dont need to be identical they just need to be majorly similar
        return similarity >= 3
    }
}


//
//  SaveChangesFuction.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 11/1/2024.
//


// this is now invalid and unused code cause it was dumb and stupid and dumb, delete this
import Foundation

// this really shouldnt be a standalone function but its my first idea and i will not vary from it till it bites me
// literally just saves the settings,
func SaveAllOverAgain(sylibi:Card, index:Int) {
    // looking at this now this seems dumb (refering to the getsylibus function taking a filename)
    var biteme = Deckmanager().Activelist()
    biteme[index] = sylibi
//    Deckmanager().SaveSomething(sylibus: biteme)
}

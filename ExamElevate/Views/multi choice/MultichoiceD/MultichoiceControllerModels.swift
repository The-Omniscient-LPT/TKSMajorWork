//
//  MultichoiceControllerModels.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 24/7/2024.
//

import Foundation
import SwiftUI
import Combine

class MultiChoice_VM : ObservableObject {
    //this is the hackiest solution ive ever seen but it works, not super efficient but its apple it will be fine
    var First = true
    @Published var flashcard: [Card]
    @Published var isFront: Bool = false
    @Published var index: Int = -1 //tap is the first operation on it and requires the index to go up by one. therefore on page load index = 0
    @Published var selectedAnswer: Int = 5
    @Published var offset: Int = 2
    // the reason why Average is an int instead of a float is so I can display this as a clean percentage as I do not need high precision, yes i could round but i dont really like that idea, this does however mean that once the user answers 200 questions the percentage becomes non functional, as 100/>200 rounds to 0 as an int at all points
    @Published var percentage: Int = 0
    // double check everything before/after changing this variable
    var percentageindex: Int = 1
    var count: Int {
        flashcard.count
    }
    init() {
        self.flashcard = Deckmanager().Activelist().shuffled()
    }
}

class MultiChoice_VC: ObservableObject {
    @Published var VM: MultiChoice_VM
    @Published var BVM: [QuestionBox_VM]
    @ObservedObject var Model: ExamElevateModel
    init(Model: ExamElevateModel) {
        self.Model = Model
        self.VM = MultiChoice_VM()
        self.BVM = []
        for i in 0..<4 {
            // yeah this does include recursive referencing, but.....
            let bVM = QuestionBox_VM(VC: self, BoxPos: i)
            self.BVM.append(bVM)
        }
        self.VM.isFront = false
        self.Tap()
    }

    func IncrementIndex() {
        if VM.index == VM.count - 1 {
            VM.index = 0
        } else {
            VM.index += 1
        }
    }
    func Tap() {
        VM.offset = 0 //Int.random(in: 0...3)// feature depricated due to time constraints
        if VM.isFront {
            if VM.flashcard[VM.index].answerpos + VM.offset == VM.selectedAnswer {
                updatepercentage(correct: true)
            }
            else{
                updatepercentage(correct: false)
            }
        }
        else {
            IncrementIndex()
            VM.offset = Int.random(in: 1..<5)
        }
        for i in BVM {
            i.updatecard(answerpos: VM.flashcard[VM.index].answerpos, Tappedpos: VM.selectedAnswer, isfront: VM.isFront, offset: VM.offset, flashcards: VM.flashcard, index: VM.index)
        }
        VM.isFront.toggle()
        self.objectWillChange.send()
    }
    func updatepercentage(correct: Bool){
        // recalculates the percentage of multiple choice questions answered correctly or incorrectly
        // be carefull messing with this function, was a pain in the ass to write.
        // i am proud of this
        if VM.First {
            if correct {
                VM.percentage = 100
            }
            VM.First = false
        }
        else {
            VM.percentageindex += 1
            if correct {
                VM.percentage = (VM.percentage*(VM.percentageindex-1)+100)/VM.percentageindex
            }
            else {
                VM.percentage = (VM.percentage*(VM.percentageindex-1))/VM.percentageindex
            }
        }
        
    }
}

// This should really have its own model attached and have its own controller
class QuestionBox_VM: ObservableObject {
    @ObservedObject var VC: MultiChoice_VC
    let BoxPos: Int
    @Published var Boxcolor: Color = .gray // Changed to @Published to ensure observation
    @Published var potentialanswer: String
    init(VC: MultiChoice_VC, BoxPos: Int) {
        self.VC = VC
        self.BoxPos = BoxPos
        //TODO: this needs to be fixed
        self.potentialanswer = ""
    }
    func updatecard(answerpos: Int, Tappedpos: Int, isfront: Bool, offset: Int, flashcards: [Card], index: Int) {
        if isfront {
            
            // handles the color of the box
            
            if (answerpos - offset+4)%4 == BoxPos {
                Boxcolor = .green
            }
            else {
                if Tappedpos ==  BoxPos {
                    Boxcolor = .red
                }
            }
        }
        else {
            
            // if the card is flipping to front
            Boxcolor = .gray
            switch (BoxPos + offset)%4 {
            case 0:
                potentialanswer = flashcards[index].answer1
            case 1:
                potentialanswer = flashcards[index].answer2
            case 2:
                potentialanswer = flashcards[index].answer3
            case 3:
                potentialanswer = flashcards[index].answer4
            default:
                potentialanswer = "error"
            }
        }
    }
     // this is my attempt to update the color, it in no way works and that pisses me off to hell, if you can fix this youve removed the biggest burden i have of my chest.
    // function is deprecated
    /*
    func updateColor(Colour: Binding<Color>) {
        if VC.VM.isFront {
            Colour.wrappedValue = Color.gray
        } else {
            if (VC.VM.selectedAnswer+VC.VM.offset)%4 == BoxPos {
                if BoxPos == (VC.VM.flashcard[VC.VM.index].answerpos+VC.VM.offset)%4 {
                    Colour.wrappedValue = Color.green
                } else {
                    Colour.wrappedValue = Color.red
                }
            } else {
                Colour.wrappedValue = Color.gray
            }
        }
        print(Boxcolor)
    }
     */
}

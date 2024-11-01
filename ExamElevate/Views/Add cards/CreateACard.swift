//
//  CreateACard.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 10/7/2024.
//

import SwiftUI

class CreateCardModel: ObservableObject {
    var startercard: Card = Card(dotpoint: "", activated: true, custom: true, flashcardfront: "", flashcardback: "", question: "", answer1: "", answer2: "", answer3: "", answer4: "", answerpos: 0, dotpointnotes: "")
    init() {
        startercard.answerpos = Int.random(in: 0...3)
    }
}

struct CreateACard: View {
    // a lot of this should be shifted into model, this is not explicitly nescesary
    @State var Model: ExamElevateModel
    @State var popover = false
    var index: Int
    var savefunctiondotpoint: ()
    @ObservedObject var CardModel: CreateCardModel = CreateCardModel()

        var body: some View {
            // this is editing the card in the model, nothing is written to the model
            ScrollView {
                Popup_question_mark(ImageName: "AddCardsOnlineHelp")
                VStack(alignment: .leading) {
                    Group{
                        Textfield_editor_(variablestring: $CardModel.startercard.dotpoint, name: "Dotpoint", savefuction: savefunctiondotpoint)
                        Toggle("Activated", isOn: $CardModel.startercard.activated)
                    }
                    Group{
                        Textfield_editor_(variablestring:$CardModel.startercard.flashcardfront, name: "Flashcard Prompt", savefuction: savefunctiondotpoint)
                        Textfield_editor_(variablestring: $CardModel.startercard.flashcardback, name: "Flashcard Answer", savefuction: savefunctiondotpoint)
                    }
                        // Continue the pattern for other properties
                    Group {
                        Textfield_editor_(variablestring: $CardModel.startercard.question, name: "Multi Choice Question", savefuction: savefunctiondotpoint)
                        // going to have to customise this.
                        VStack {
                            TextField("Answer 1", text: $CardModel.startercard.answer1)
                            // this is not functionasl in selecting
                                .padding()
                                .background(0 == CardModel.startercard.answerpos ? Color.green : Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                            TextField("Answer 2", text: $CardModel.startercard.answer2)
                            // this is not functionasl in selecting
                                .padding()
                                .background(1 == CardModel.startercard.answerpos ? Color.green : Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                            TextField("Answer 3", text: $CardModel.startercard.answer3)
                            // this is not functionasl in selecting
                                .padding()
                                .background(2 == CardModel.startercard.answerpos ? Color.green : Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                            TextField("Answer 4", text: $CardModel.startercard.answer4)
                            // this is not functionasl in selecting
                                .padding()
                                .background(3 == CardModel.startercard.answerpos ? Color.green : Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    Text("Save")
                    .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .onTapGesture {
                        // this is to ensure that the user cannot spam the question a bunch fo times, intentionally or by accident
                            // read sylibi struct equatable module, 
                        if CardModel.startercard != Model.Globaldatabaseinstance[index].deck.last {
                            Model.AppendACard(Card: CardModel.startercard, index: index)
                            popover = true
                        }
                    }

                }
                .padding()
                .popover(isPresented: $popover){
                    Text("Card Added")
                }
            }
        }
    }

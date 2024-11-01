//
//  showdotpointforlist.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 29/12/2023.
//

import SwiftUI

struct showdotpointforlist: View {
    @State var Model: ExamElevateModel
    @Binding var sylibiPoint: Card
    var savefunctiondotpoint: ()

        var body: some View {
            ScrollView {
                Popup_question_mark(ImageName: "EditcardsOnlineHelp")
                VStack(alignment: .leading) {
                    Group{
                        Textfield_editor_(variablestring: $sylibiPoint.dotpoint, name: "Dotpoint", savefuction: Model.savedatabaase())
                        Toggle("Activated", isOn: $sylibiPoint.activated)
                    }
                    Group{
                        Textfield_editor_(variablestring: $sylibiPoint.flashcardfront, name: "Flashcard Prompt", savefuction: Model.savedatabaase())
                        Textfield_editor_(variablestring: $sylibiPoint.flashcardback, name: "Flashcard Answer", savefuction: Model.savedatabaase())
                    }
                        // Continue the pattern for other properties
                    Group {
                        Textfield_editor_(variablestring: $sylibiPoint.question, name: "Multi Choice Question", savefuction: Model.savedatabaase())
                        // going to have to customise this.
                        VStack {
                            TextField("Answer 1", text: $sylibiPoint.answer1)
                            // this is not functionasl in selecting
                                .padding()
                                .background(0 == sylibiPoint.answerpos ? Color.green : Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                            TextField("Answer 2", text: $sylibiPoint.answer2)
                            // this is not functionasl in selecting
                                .padding()
                                .background(1 == sylibiPoint.answerpos ? Color.green : Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                            TextField("Answer 3", text: $sylibiPoint.answer3)
                            // this is not functionasl in selecting
                                .padding()
                                .background(2 == sylibiPoint.answerpos ? Color.green : Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                            TextField("Answer 4", text: $sylibiPoint.answer4)
                            // this is not functionasl in selecting
                                .padding()
                                .background(3 == sylibiPoint.answerpos ? Color.green : Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    //Elijah messing with counter
                    SaveButton(Model: Model, counter: .constant(0))

                }
                .padding()
            }
        }
    }

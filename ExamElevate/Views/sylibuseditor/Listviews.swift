//
//  Listviews.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 3/7/2024.
//

import Foundation
import SwiftUI
struct Subjectview: View {
    @ObservedObject var VM_Object: ExamElevateModel
    @Binding var item: SubjectDeck
    var savechangefunction: ()
    var body: some View {
        VStack{
            HStack {
                Text(item.subject).padding()
                Popup_question_mark(ImageName: "EditcardsOnlineHelp")
            }
            // TODO: intergrate this into the navstack later
                List(item.deck.indices, id: \.self) { index in
                    NavigationLink(
                        destination: showdotpointforlist(Model: VM_Object, sylibiPoint: $item.deck[index], savefunctiondotpoint: savechangefunction)
                    ) {
                        HStack {
                            Text(item.deck[index].dotpoint)
                    }
                }
                
            }
            //Elijah messing with counter
            SaveButton(Model: VM_Object, counter: .constant(0))
        }
    }
}

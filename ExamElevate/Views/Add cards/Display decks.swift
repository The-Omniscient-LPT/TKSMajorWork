//
//  Display decks.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 10/7/2024.
//

import SwiftUI

struct Display_decks: View {
    @StateObject var Model: ExamElevateModel
    var body: some View {
            VStack{
                Popup_question_mark(ImageName: "AddCardsOnlineHelp")
                List(Model.Globaldatabaseinstance.indices, id: \.self) { index in
                    NavigationLink(
                        destination: CreateACard(Model: Model, index: index, savefunctiondotpoint: Model.stubfunction())
                    ) {
                        HStack {
                            Text(String(Model.Globaldatabaseinstance[index].subject))
                        }
                    }
                }
                .navigationBarTitle("Dot Points")
            }
        }
}
struct Display_decks_Previews: PreviewProvider {
    static var previews: some View {
        Display_decks(Model: ExamElevateModel())
    }
}

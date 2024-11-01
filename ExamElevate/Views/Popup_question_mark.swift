//
//  Popup_question_mark.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 23/7/2024.
//

import SwiftUI

struct Popup_question_mark: View {
    @State private var dopopup = false
    var ImageName: String
    var body: some View {
        HStack{
            Spacer()
            Button(action: {
                dopopup=true
            }, label: {
                Image(systemName: "questionmark.circle")
                    .foregroundColor(.blue)
                    .font(.system(size: 22))
            })
            .popover(isPresented: $dopopup){
                Image(ImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

struct Popup_question_mark_Previews: PreviewProvider {
    static var previews: some View {
        Popup_question_mark(ImageName: "HomeScreenOnlineHelp")
    }
}

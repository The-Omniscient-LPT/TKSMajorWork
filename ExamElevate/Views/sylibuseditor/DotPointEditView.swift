//
//  DotPointEditView.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 26/12/2023.
//

import SwiftUI

struct DotPointEditView: View {
    @StateObject var Model: ExamElevateModel
    @State var counter = 0
    
    var body: some View {
        VStack{
            Popup_question_mark(ImageName: "EditcardsOnlineHelp")
            List(Model.Globaldatabaseinstance.indices, id: \.self) { index in
                    NavigationLink(
                        destination: Subjectview(VM_Object: Model, item: $Model.Globaldatabaseinstance[index], savechangefunction: Model.savedatabaase())
                    ) {
                        HStack {
                            Text(String(Model.Globaldatabaseinstance[index].subject))
                            Toggle("", isOn: $Model.Globaldatabaseinstance[index].activated).id(counter)
                        }
                    }
            }.id(counter)
                .navigationBarTitle("Dot Points")
            SaveButton(Model: Model, counter: self.$counter)
            }
        }
}


struct DotPointEditView_Previews: PreviewProvider {
    static var previews: some View {
        DotPointEditView(Model: ExamElevateModel())
    }
}

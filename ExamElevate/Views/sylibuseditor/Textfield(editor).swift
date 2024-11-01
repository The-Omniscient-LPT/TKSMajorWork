//
//  Textfield(editor).swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 22/2/2024.
//

import SwiftUI

struct Textfield_editor_: View {
    @Binding var variablestring: String
            var name: String

    var savefuction: ()
    var body: some View {
        Text(name)
        TextField(name, text: $variablestring, onEditingChanged: {editingChanged in
            if !editingChanged {
                // TODO: this is not working, it seems to be activating on editing change, this worked in older functions examine old builds
                savefuction
                print("unclicked from editor")
            }
            
        })
        .minimumScaleFactor(0.5)

    }
}

struct SaveButton: View {
    @StateObject var Model: ExamElevateModel
    @State var popover: Bool = false
    @Binding var counter: Int
    var body: some View {
        //
        Button("Save"){
            Model.savedatabaase()
            popover = true
            counter = counter+1
        }
        .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.blue)
            .popover(isPresented: $popover){
                Text("saved to deck")
            }
    }
}



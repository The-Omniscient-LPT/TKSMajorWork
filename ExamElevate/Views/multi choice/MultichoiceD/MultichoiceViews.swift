//
//  MultichoiceViews.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 24/7/2024.
//

import Foundation
import SwiftUI
import Combine




struct MultiChoiceC: View {
    @StateObject var VC: MultiChoice_VC
    @StateObject var Model: ExamElevateModel

    var body: some View {
        VStack(spacing: 20) {
            Popup_question_mark(ImageName: "MultichoiceOnlineHelp")
            // the flashcard should be loaded individually.
            Text(VC.VM.flashcard[VC.VM.index].question)
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(10)
            HStack{
                Text(VC.VM.percentage, format: .number)
                Text("%")
            }
            //Text(12.3456, format: .number.rounded(increment: 1.0))
            ForEach(0..<4) { index in
                QuestionBox(VC: VC, BoxPos: index, TextBoxColour: $VC.BVM[index].Boxcolor)
            }
            Text(VC.VM.isFront ? "select the correct answer":"Tap a question to continue")
            HStack {
                Text(VC.VM.offset, format: .number)
            }
                .foregroundColor(.gray)
                .padding(.bottom, 20)
        }.padding()
    }
}

struct QuestionBox: View {
    @ObservedObject var VC: MultiChoice_VC
    let BoxPos: Int
    @Binding var TextBoxColour: Color
    var body: some View {
        Text(VC.BVM[BoxPos].potentialanswer)
            .font(.title2)
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(TextBoxColour)
            .cornerRadius(10)
            .onTapGesture {
                //this should be moved into QB VM but It would make my code more complex
                VC.VM.selectedAnswer = BoxPos
                VC.Tap()
                //VC.BVM[BoxPos].tapped(Colour: $TextBoxColour)
            }
    }
}
struct MultiChoiceC_Previews: PreviewProvider {
    static var previews: some View {
        MultiChoiceC(VC: MultiChoice_VC(Model: ExamElevateModel()), Model: ExamElevateModel())
    }
}

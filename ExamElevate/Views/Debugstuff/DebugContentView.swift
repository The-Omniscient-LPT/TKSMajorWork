//
//  DebugContentView.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 23/5/2024.
//

import SwiftUI

struct DebugContentView: View {
    @StateObject var Model: ExamElevateModel
    var body: some View {
        VStack {
//            NavigationLink(destination: TestSylibusDisplay()) {
//                Text("TestSylibus")
//                    .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 150)
//                    .background(Color.purple)
//                    .cornerRadius(20)
//                    .foregroundColor(.white)
//            }
            NavigationLink(destination: MakeCards()) {
                Text("makecards")
                    .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 150)
                    .background(Color.red)
                    .cornerRadius(20)
                    .foregroundColor(.white)
            }
        }
    }
}

struct DebugContentView_Previews: PreviewProvider {
    static var previews: some View {
        DebugContentView(Model: ExamElevateModel())
    }
}

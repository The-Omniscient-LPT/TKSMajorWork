//
//  ExamElevateApp.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 3/12/2023.
//

import SwiftUI

@main
struct ExamElevateApp: App {
    @StateObject var examElevateModel = ExamElevateModel()
    var body: some Scene {
        
        WindowGroup {
            ContentView(Model: examElevateModel)
        }
        
    }
}

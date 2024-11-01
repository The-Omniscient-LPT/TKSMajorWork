//
//  MakeCards.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 24/5/2024.
//

import SwiftUI

struct MakeCards: View {
    @ObservedObject var Controler = CardEditControler()
    var body: some View {
        Text("Stub")
    }
}


class CardEditControler: ObservableObject {
    @ObservedObject var Model = CardMakeModel()
}

class CardMakeModel: ObservableObject {
    
}
struct MakeCards_Previews: PreviewProvider {
    static var previews: some View {
        MakeCards()
    }
}

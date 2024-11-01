//
//  FlashcardView.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 26/12/2023.
//
//ui modified by chatgpt
import SwiftUI


/*
 TODO: modify backside so that there is not a small time where the backside is backwards, also modify the color to match the color of the flashcards button
 TODO: make this code better/more efficient, also be polite to Gretel because she really cooked on this one
 TODO: shift some stuff into a ViewManager so that the big Fox will be happy
 TODO: see above, fix this into view and model, i should be impaled and bled for this abomination
 */
struct FlashcardView: View {
    @State private var isFront: Bool = true
    @State private var index: Int = 0
    @ObservedObject var Model: ExamElevateModel
    @Binding var flashcards: [Card]
    @State private var showText = true
    let animationDuration = 0.3

    var body: some View {
        VStack {
            Popup_question_mark(ImageName: "FlashcardOnlineHelp")
            Spacer()
            Text(flashcards[index].dotpoint)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(isFront ? Color.blue : Color.green)
                    .frame(width: 300, height: 200)
                    .rotation3DEffect(
                        .degrees(isFront ? 0 : 180),
                        axis: (x: 0, y: isFront ? 1 : 0, z: 0)
                    )
                    Text(flashcards[index].flashcardfront)
                        .font(.system(size: 20, weight: .bold))
                        .padding()
                        .frame(width: 280, height: 180)
                        .rotation3DEffect(
                            .degrees(isFront ? 0 : 180),
                            axis: (x: 0, y: isFront ? 1 : 0, z: 0)
                        )
                        .minimumScaleFactor(0.5)
                        .lineLimit(10) // Set the maximum number of lines if needed
                        .opacity(showText ? 1:0)
                Text(flashcards[index].flashcardback)
                    .font(.system(size: 20, weight: .bold))
                    .padding()
                    .frame(width: 280, height: 180)
                    .rotation3DEffect(
                        .degrees(isFront ? -180 : 0),
                        axis: (x: 0, y: isFront ? 1 : 0, z: 0)
                    )
                    .minimumScaleFactor(0.5)
                    .lineLimit(10) // Set the maximum number of lines if needed
                    .opacity(showText ? 0:1)
            }
            .onTapGesture {
                DispatchQueue.main.asyncAfter(deadline: .now()+(animationDuration/2)) {
                    showText.toggle()
                }
                withAnimation(.easeInOut(duration: animationDuration)) {
                    self.isFront.toggle()
                    if self.isFront {
                        // Move to the next flashcard when on the back
                        if (self.index + 1) % self.flashcards.count == 0 {
                            flashcards = Model.randomList()
                        }
                        self.index = (self.index + 1) % self.flashcards.count
                    }
                }
            }
            Text(String(index))

            Spacer()

            Text("Tap to flip")
                .foregroundColor(.gray)
                .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //.background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

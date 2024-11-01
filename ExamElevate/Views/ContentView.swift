import SwiftUI

struct ContentView: View {
    @StateObject var Model: ExamElevateModel
    @State var OnlineHelpPopup: Bool = false
    var body: some View {
        VStack {
            NavigationStack{
                Popup_question_mark(ImageName: "HomeScreenOnlineHelp")
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        NavigationLink(destination: FlashcardView(Model: Model, flashcards: $Model.randomlist)) {
                            Text("Flashcard")
                                .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 150)
                                .background(Color.blue)
                                .cornerRadius(20)
                                .foregroundColor(.white)
                        }
                        NavigationLink(destination: MultiChoiceC(VC: MultiChoice_VC(Model: Model), Model: Model)) {
                            Text("Multi choice")
                                .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 150)
                                .background(Color.green)
                                .cornerRadius(20)
                                .foregroundColor(.white)
                        }
                    }
                    HStack(spacing: 20) {
                        NavigationLink(destination: DotPointEditView(Model: Model)) {
                            Text("Edit cards")
                                .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 150)
                                .background(Color.orange)
                                .cornerRadius(20)
                                .foregroundColor(.white)
                        }
                        NavigationLink(destination: Display_decks(Model: Model)) {
                            Text("Add Cards")
                                .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 150)
                                .background(Color.purple)
                                .cornerRadius(20)
                                .foregroundColor(.white)
                        }
                    }
//                    NavigationLink(destination: DebugContentView(Model: Model)) {
//                        Text("Debug")
//                            .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 150)
//                            .background(Color.red)
//                            .cornerRadius(20)
//                            .foregroundColor(.white)
//                                    }
                }
                .padding()
                .navigationBarTitle("ExamElevate")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(Model: ExamElevateModel())
    }
}

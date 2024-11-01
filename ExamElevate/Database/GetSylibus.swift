//
//  GetSylibus.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 19/12/2023.
//



import Foundation
// DEPRECIATED, only existing as reference
class DeckmanagerOBSELETE {
    var filename = "DeckJson.json"
    var filemanager: FileManager
    init() {
        filemanager = FileManager.default
    }
//    func DebugSylibusString () -> String? {
//        guard let file = Bundle.main.url(forResource: self.filename, withExtension: nil)
//        else {fatalError("filepath no work on getsylibus, 9/10 check filename ur sending")}
//        let Sillystring = try? String(contentsOf: file, encoding: .utf8)
//        return Sillystring
//    }
//
    func checkAndCreateFile(fileName: String, fileManager: FileManager) {
        let fileData: Data
        // gets url, taken from swiftui tutorial
        guard let file = Bundle.main.url(forResource: self.filename, withExtension: nil)
        else {fatalError("filepath no work on getsylibus, 9/10 check filename ur sending")}
        
        // gets filecontents.
        do {
            fileData = try Data(contentsOf: file)
        }
        catch{
            fatalError("couldnt get data from file, line 32 of GetSylibus")
        }

        
        
        
        // Get the path to the document directory
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
       
        // Define the file path
        let filePath = documentsDirectory.appendingPathComponent(fileName)
       
        // Check if the file exists
        if fileManager.fileExists(atPath: filePath.path) {
            print("File already exists at path: \(filePath.path)")
        } else {
            // If the file does not exist, create it and write data to it
            do {
                try fileData.write(to: filePath)
                print("File created and data written to path: \(filePath.path)")
            } catch {
                print("Error writing file: \(error)")
            }
        }
    }

    func Getsylibus () -> [SubjectDeck] {
        let data: Data
        
        // gets url, taken from swiftui tutorial
        guard let file = Bundle.main.url(forResource: self.filename, withExtension: nil)
        else {fatalError("filepath no work on getsylibus, 9/10 check filename ur sending")}
        
        // gets filecontents.
        do {
            data = try Data(contentsOf: file)
        }
        catch{
            fatalError("couldnt get data from file, line 32 of GetSylibus")
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([SubjectDeck].self, from: data)
        } catch let decodingError {
            print("Decoding error:", decodingError)
            fatalError("Couldn't decode JSON in GetSylibus, line 39. Check console for details.")
        }
    }
    func Activelist() -> [Card] {
        let Preculled = self.Getsylibus()
        var postculled: [Card] = []
        for Subject in Preculled {
            if Subject.activated {
                for cards in Subject.deck {
                    if cards.activated {
                        postculled.append(cards)
                    }
                }
            }
        }
        if postculled == []{
            postculled.append(Preculled[0].deck[0])// this is for the specific case where all cards are deactivated, to prevent errors detected in testing, the active list must have at least 1 element
        }
        return postculled
    }
    //this is modified from random sylibi instancer so the comments might seem silly
    func SaveSomething(Deck: [SubjectDeck]) -> Void{
        let Encoder = JSONEncoder()
        let data: Data
        
        guard let file = Bundle.main.url(forResource: self.filename, withExtension: nil)
        else {
            fatalError("yeah getting the file name didnt work whatsoever, try something else chief")
        }
        //look familiar?
        do {
            // turns it into json
            data = try Encoder.encode(Deck)
            // writes to testsylibus
            try data.write(to: file, options: .atomic)
        }
        catch let encodingError {
            print(encodingError)
            fatalError("data write or encoding failed badly")
        }
    }
}

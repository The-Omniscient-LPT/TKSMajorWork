//
//  Databasemanager.swift
//  ExamElevate
//
//  Created by Harry Le Poer Trench on 28/8/2024.
//

import Foundation

class Deckmanager {
    var filename = "DeckJson.json"
    var filepath: URL = Bundle.main.url(forResource: "DeckJson.json", withExtension: nil)!
    init() {
        filepath = checkAndCreateFile(fileName: "DeckJson.json")
    }
    
    func checkAndCreateFile(fileName: String) -> URL {
        let fileData: Data
        let fileManager = FileManager.default
        // gets url, taken from swiftui tutorial
        
        // gets filecontents.
        do {
            fileData = try Data(contentsOf: filepath)
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
        return filePath
    }
    
    func Getsylibus () -> [SubjectDeck] {
        let data: Data
        
        // gets url, taken from swiftui tutorial
        
        // gets filecontents.
        do {
            data = try Data(contentsOf: filepath)
        }
        catch let decoderError{
            print(decoderError)
            fatalError("")
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([SubjectDeck].self, from: data)
        } catch let decodingError {
            print("Decoding error:", decodingError)
            fatalError("Couldn't decode JSON in GetSylibus. Check console for details.")
        }
    }
    
    func SaveSomething(Deck: [SubjectDeck]) -> Void{
        let Encoder = JSONEncoder()
        let data: Data
        
        //look familiar?
        do {
            // turns it into json
            data = try Encoder.encode(Deck)
            // writes to testsylibus
            try data.write(to: filepath, options: .atomic)
        }
        catch let encodingError {
            print(encodingError)
            fatalError("data write or encoding failed badly")
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
}

//Version : 0_1_2
//Date : 2025-02-05(Wed)
//Content : Word dictionary

import Foundation
import SwiftData

@Model
final class wordDictionary {
    var id: UUID
    var word: String
    var meaning: String
    var imgPath: String
    var isCorrect: Bool
    var isBookmarked: Bool
    
    init(id: UUID, word: String, meaning: String, imgPath: String, isCorrect: Bool = false, isBookmarked: Bool = false) {
        self.id = id
        self.word = word
        self.meaning = meaning
        self.imgPath = imgPath
        self.isCorrect = isCorrect
        self.isBookmarked = isBookmarked
    }
}

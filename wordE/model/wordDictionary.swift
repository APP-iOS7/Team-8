//Version : 0_1_2
//Date : 2025-02-05(Wed)
//Content : Word dictionary

import Foundation
import SwiftData

@Model
final class wordDictionary {
    var word: String
    var meaning: String
    var imgPath: String
    var isCorrect: Bool
    var isBookmarked: Bool
    
    init(word: String, meaning: String, imgPath: String, isCorrect: Bool, isBookmarked: Bool = false) {
        self.word = word
        self.meaning = meaning
        self.imgPath = imgPath
        self.isCorrect = isCorrect
        self.isBookmarked = isBookmarked
    }
}

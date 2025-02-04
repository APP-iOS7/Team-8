//Version : 0_0_1
//Date : 2025-02-04(Tue)
//Content : Word dictionary

import Foundation
import SwiftData

@Model
final class wordDictionary {
    var word: String
    var meaning: String
    var imgPath: String
    var isBookmarked: Bool
    
    init(word: word, meaning: meaning, imgPath: imgPath, isBookmarked:Bool = false) {
        var word = word
        var meaning = meaning
        var imgPath = imgPath
        var isBookmarked = isBookmarked
    }
}

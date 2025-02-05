//
//  wordDictionary.swift
//  wordE
//
//  Created by 존진 on 2/5/25.
//

import Foundation
import SwiftData

@Model
final class wordDictionary {
    var word: String
    var meaning: String
    var imgPath: String
    var isBookmarked: Bool
    var isCorrect: Bool
    
    init(word: String, meaning: String, imgPath: String, isBookmarked:Bool = false, isCorrect: Bool = false) {
        self.word = word
        self.meaning = meaning
        self.imgPath = imgPath
        self.isBookmarked = isBookmarked
        self.isCorrect = isCorrect
    }
    
}



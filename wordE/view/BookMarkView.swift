//
//  BookMarkView.swift
//  wordE
//
//  Created by 존진 on 2/5/25.
//

import SwiftUI
import SwiftData

struct BookMarkView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var words: [wordDictionary]
    @State private var sortOrder: SortOrder = .ascending
    @State private var isBookmarked: Bool = false
    
    var sortedWords: [wordDictionary] {
        // 북마크된 단어들만 추출
        let bookmarkedWords = words.filter { $0.isBookmarked }
        let sortedBookmarkedWords = bookmarkedWords.sorted {
            sortOrder == .ascending ? $0.word < $1.word : $0.word > $1.word
        }
        return sortedBookmarkedWords
    }
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Picker("정렬", selection: $sortOrder) {
                    Text("오름차순").tag(SortOrder.ascending)
                    Text("내림차순").tag(SortOrder.descending)
                }
                .padding(.trailing, 70)
                .pickerStyle(.menu)
                .frame(width: 180, height: 40)
                .background(Color("pickerColor"))
                .tint(Color("TextColor"))
                .overlay {
                    RoundedRectangle(cornerRadius: 13)
                        .stroke(Color("sectionBorderColor"), lineWidth: 1)
                }
                Spacer()
            }
            .offset(x: -70, y: 90)
            
            Spacer()
            ScrollView {
                VStack {
                    ForEach(words) { word in
                        NavigationLink(destination: CardAnimationView(wordInfo: word)) {
                            VStack {
                                HStack {
                                    Text("\(word.word)")
                                        .font(.system(size: 21, weight: .semibold))
                                        .foregroundStyle(Color.black)
                                        .padding()
                                    Spacer()
                                    // 북마크 버튼
                                    Button(action: {
                                        toggleBookmark(for: word)
                                    }) {
                                        Image(systemName: word.isBookmarked ? "bookmark.fill" : "bookmark")
                                            .foregroundStyle(word.isBookmarked ? Color("bookmarkColor") : .gray)
                                            .padding()
                                    }
                                }
                                .frame(width: 315, height: 50)
                                .background(Color("sectionBackColor"))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 13).stroke(Color("sectionBorderColor"))
                                }
                            }
                        }
                    }
                }
            }
        }
        Spacer()
    }
    private func toggleBookmark(for word: wordDictionary) {
        // 북마크 상태 토글
        word.isBookmarked.toggle()
        
        let wordDictionary = wordDictionary(id: word.id, word: word.word, meaning: word.meaning, imgPath: word.imgPath, isCorrect: word.isCorrect, isBookmarked: !word.isBookmarked)
        modelContext.insert(wordDictionary)
    }
}

// 정렬 타입
enum SortOrder {
    case ascending
    case descending
}

#Preview {
    BookMarkView()
}

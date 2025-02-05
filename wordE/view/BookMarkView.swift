//
//  BookMarkView.swift
//  wordE
//
//  Created by 존진 on 2/5/25.
//

import SwiftUI
import SwiftData

struct BookMarkView: View {
    @Query var words: [wordDictionary]
    @State private var sortOrder: SortOrder = .ascending
    @State private var isBookmarked: Bool = false
    
    var sortedWords: [wordDictionary] {
        // 북마크된 단어들만 추출
        let bookmarkedWords = words.filter { $0.isBookmarked }
        return bookmarkedWords.sorted {
            sortOrder == .ascending ? $0.word < $1.word : $0.word > $1.word
        }
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
                    ForEach(words.filter { !$0.isCorrect }) { word in
                        NavigationLink(destination: ContentView(/*word: word*/)) {
                            VStack {
                                HStack {
                                    Text("\(word.word)")
                                        .font(.system(size: 21, weight: .semibold))
                                        .foregroundStyle(Color("xmarkColor"))
                                        .padding()
                                    Spacer()
                                    // 북마크 버튼
                                    Button(action: {
                                        isBookmarked.toggle()
                                    }) {
                                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                                            .foregroundStyle(isBookmarked ? Color("bookmarkColor") : .gray)
                                            .padding()
                                    }
                                }
                                .frame(width: .infinity, height: 50)
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
}

// 정렬 타입
enum SortOrder {
    case ascending
    case descending
}

#Preview {
    BookMarkView()
}

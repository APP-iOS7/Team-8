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
    @State private var showingUnbookmarkAlert = false
    @State private var wordToUnbookmark: wordDictionary?
    
    var sortedWords: [wordDictionary] {
        // 북마크된 단어들만 추출
        let bookmarkedWords = words.filter { $0.isBookmarked }
        let sortedBookmarkedWords = bookmarkedWords.sorted {
            sortOrder == .ascending ? $0.word < $1.word : $0.word > $1.word
        }
        return sortedBookmarkedWords
    }
    
    var body: some View {
        VStack(alignment: .leading) {
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
                .padding(.top, 1)
                .overlay {
                    RoundedRectangle(cornerRadius: 13)
                        .stroke(Color("sectionBorderColor"), lineWidth: 1)
                }
            }

            ScrollView {
                VStack {
                    ForEach(sortedWords) { word in
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
                                        if word.isBookmarked {
                                            wordToUnbookmark = word
                                            showingUnbookmarkAlert = true
                                        } else {
                                            clickedBookmark(item: word)
                                        }
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
                .alert("북마크 해제", isPresented: $showingUnbookmarkAlert, presenting: wordToUnbookmark)
                { word in
                    Button("취소", role: .cancel) {}
                    Button("북마크 해제", role: .destructive) {
                        clickedBookmark(item: word)
                    }
                } message: { word in
                    Text("\(word.word)의 북마크를 해제 하시겠습니까?")
                }
            }
        }
        Spacer()
    }
    private func clickedBookmark(item: wordDictionary) {
        if let index = words.firstIndex(where: { $0.id == item.id }) {
            words[index].isBookmarked = !words[index].isBookmarked
            try? modelContext.save()
        }
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

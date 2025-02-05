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
    
    var sortedWords: [wordDictionary] {
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
                .pickerStyle(.menu) // 메뉴 스타일 적용
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
            NavigationStack {
                List(sortedWords, id: \.word) { word in
                    NavigationLink(destination: ContentView(/*word: word*/)) {
                        HStack {
                            Text(word.word)
                                .font(.title3)
                                .bold()
                            Spacer()
                            Image(systemName: "bookmark.fill")
                                .foregroundStyle(Color("bookmarkColor"))
                        }
                        .padding()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            Spacer()
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

//
//  ResultView.swift
//  wordE
//
//  Created by 존진 on 2/4/25.
//

import SwiftUI
import SwiftData

struct ResultView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var words: [wordDictionary]
    
    // 정답 개수
    private var correctCount: Int {
        words.filter { $0.isCorrect }.count
    }
    
    // 오답 개수
    private var wrongCount: Int {
        words.count - correctCount
    }
    
    // 정답 비율 (퍼센트)
    private var correctPercentage: Double {
        words.isEmpty ? 0 : (Double(correctCount) / Double(words.count)) * 100
    }
    
    private var fillteredWord: [wordDictionary] {
        return []
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    VStack {
                        HStack {
                            Image(systemName: "checkmark")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(Color("checkColor"))
                            
                            Text("정답 수: \(correctCount)")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(Color("resultFontColor"))
                        }
                        HStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(Color("xmarkColor"))
                            Text("오답 수: \(wrongCount)")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(Color("resultFontColor"))
                        }
                    }
                    .padding()
                    // 원형 차트
                    CircularChartView(correctPercentage: correctPercentage)
                        .frame(width: 130, height: 130)
                        .padding()
                }
                
                Spacer()
                
                ScrollView {
                    VStack {
//                         오답 단어 표시
                        ForEach(fillteredWord) { word in
                            NavigationLink(destination: CardAnimationView(wordInfo: word)) {
                                VStack {
                                    HStack {
                                        Text("\(word.word)")
                                            .font(.system(size: 21, weight: .semibold))
                                            .foregroundStyle(Color("xmarkColor"))
                                            .padding()
                                        Spacer()
                                        // 북마크 버튼
                                        Button(action: {
                                            clickedBookmark(item: word)
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
                        
                        Divider()
                            .frame(width: 315, height: 25)
                            .foregroundStyle(Color("bookmarkColor"))
                        
                        // 정답 단어 표시
                        ForEach(fillteredWord) { word in
                            NavigationLink(destination: CardAnimationView(wordInfo: word)) {
                                VStack {
                                    HStack {
                                        Text("\(word.word)")
                                            .font(.system(size: 21, weight: .semibold))
                                            .foregroundStyle(Color("checkColor"))
                                            .padding()
                                        Spacer()
                                        // 북마크 버튼
                                        Button(action: {
                                            clickedBookmark(item: word)
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
            }.padding(.horizontal, 42)  // 좌우 여백
                .onAppear(perform: {
                    print(words)
                        })
        }
        Spacer()
    }
    
    private func clickedBookmark(item: wordDictionary) {
        if let index = words.firstIndex(where: { $0.id == item.id }) {
            words[index].isBookmarked = !words[index].isBookmarked
//            words[index].isBookmarked.toggle()
            try? modelContext.save()
            print(words[index])
        }
    }
    
}

struct CircularChartView: View {
    var correctPercentage: Double // 0~100 사이 값
    
    var body: some View {
        ZStack {
            // 배경 원
            Circle()
                .stroke(Color.white)
            
            Text("\(Int(correctPercentage))%")
                .font(.system(size: 23, weight: .semibold))
                .foregroundStyle(Color("resultFontColor"))
            
            // 정답 퍼센트 원형 차트
            Circle()
                .trim(from: 0, to: correctPercentage / 100) // 정답 퍼센트 만큼 자르기
                .stroke(Color("graphColor"), style: StrokeStyle(lineWidth: 16, lineCap: .round))
                .rotationEffect(.degrees(50))
        }
        .frame(width: 100, height: 100)
    }
}

#Preview {
    ResultView()
}

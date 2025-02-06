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
    
    var word: [dummyData]
    
    @State private var wordList : [dummyData] = []
    
    // 정답 개수
    private var correctCount: Int {
        word.filter { $0.isCorrect }.count
    }
    
    // 오답 개수
    private var wrongCount: Int {
        word.count - correctCount
    }
    
    // 정답 비율 (퍼센트)
    private var correctPercentage: Double {
        word.isEmpty ? 0 : (Double(correctCount) / Double(word.count)) * 100
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
                        // 오답 단어 표시
                        ForEach(wordList.filter( { !$0.isCorrect })) { word in
                            NavigationLink(destination: CardAnimationView()) {
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
                        ForEach(wordList.filter( { $0.isCorrect })) { word in
                            NavigationLink(destination: CardAnimationView()) {
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
                            wordList = word
                        })
        }
        Spacer()
    }
    
    private func clickedBookmark(item: dummyData) {
        if let index = wordList.firstIndex(where: { $0.id == item.id }) {
            wordList[index].isBookmarked = !wordList[index].isBookmarked
        }
        
        print(word)
        print(index)
        let wordDictionary = wordDictionary(id: item.id, word: item.word, meaning: item.meaning, imgPath: item.imgPath, isCorrect: item.isCorrect, isBookmarked: !item.isBookmarked)
        modelContext.insert(wordDictionary)
        print("저장 후", wordList)
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
    ResultView(word: [dummyData(id: 1, word: "apple", meaning: "사과", imgPath: "dddsd", isBookmarked: false, isCorrect: true)])
}

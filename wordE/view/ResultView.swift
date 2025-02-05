//
//  ResultView.swift
//  wordE
//
//  Created by 존진 on 2/4/25.
//

import SwiftUI

struct ResultView: View {
    
    let correct: Int
    let wrong: Int
    
    private var total: Int { correct + wrong }
    private var correctPercentage: Double {
        total > 0 ? (Double(correct) / Double(total)) * 100 : 0
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack {
                    HStack {
                        Image(systemName: "checkmark")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(Color("checkColor"))
                        
                        Text("정답 수: ")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(Color("resultFontColor"))
                        Text("1")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(Color("resultFontColor"))
                    }
                    HStack {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(Color("xmarkColor"))
                        Text("오답 수: ")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(Color("resultFontColor"))
                        Text("1")
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
            
            Spacer()
            ScrollView {
                HStack {
                    Text("Apple")
                        .font(.system(size: 21, weight: .semibold))
                        .foregroundStyle(Color("xmarkColor"))
                        .padding()
                    Spacer()
                    Image(systemName: "bookmark")
                        .foregroundStyle(Color("bookmarkColor"))
                        .padding()
                }
                .frame(width: .infinity, height: 50)
                .background(Color("sectionBackColor"))
                .overlay {
                    RoundedRectangle(cornerRadius: 13).stroke(Color("sectionBorderColor"))
                }
                
                Divider()
                    .frame(width: .infinity, height: 25)
                    .foregroundStyle(Color("bookmarkColor"))
                
                HStack {
                    Text("Banana")
                        .font(.system(size: 21, weight: .semibold))
                        .foregroundStyle(Color("checkColor"))
                        .padding()
                    Spacer()
                    Image(systemName: "bookmark")
                        .foregroundStyle(Color("bookmarkColor"))
                        .padding()
                }
                .frame(width: .infinity, height: 50)
                .background(Color("sectionBackColor"))
                .overlay {
                    RoundedRectangle(cornerRadius: 13).stroke(Color("sectionBorderColor"))
                }
                
            }
        }.padding(.horizontal, 42)  // 좌우 여백
        
        Spacer()
    }
}

struct CircularChartView: View {
    var correctPercentage: Double // 0~100 사이 값

    var body: some View {
        ZStack {
            // 배경 원 (연한 회색)
            Circle()
                .stroke(Color.white)
            
            Text("59%")
                .font(.system(size: 23, weight: .semibold))
                .foregroundStyle(Color("resultFontColor"))

            // 정답 퍼센트 원형 차트
            Circle()
                .trim(from: 0, to: correctPercentage / 100) // 정답 퍼센트 만큼 자르기
                .stroke(Color("graphColor"), style: StrokeStyle(lineWidth: 16, lineCap: .round))
                .rotationEffect(.degrees(-90)) // 12시 방향에서 시작
        }
        .frame(width: 100, height: 100)
    }
}

#Preview {
    ResultView(correct: 3, wrong: 2)
}

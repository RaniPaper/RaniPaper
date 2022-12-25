//
//  InfoView.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/11/29.
//
// Info View For Test


import SwiftUI

struct CreditView: View {
    
    let height = ScreenSize.height/6
    
    
    var body: some View {
        ZStack{
            Color(hexcode: "B2BFAC")
            
            VStack(spacing: 0) {
                // MARK: Header
                VStack(spacing: 0){
                    Spacer()
                    Text("크레딧")
                        .font(.efDiary(35))
                        .foregroundColor(.memoPrimary)
                    Text("credits")
                        .font(.efDiary(13))
                        .foregroundColor(.memoPrimary)
                    
                    Spacer()
                    Rectangle().frame(maxHeight: 2).foregroundColor(.memoPrimary)
                }
                .padding(.top,20)
                .frame(maxWidth: .infinity,maxHeight: height)
                .background {
                    Color.memoBg
            }
                ScrollView(showsIndicators: false){
                    VStack(spacing:5){
                        Text("팀장").font(.efDiary(20)).foregroundColor(.memoPrimary).frame(maxWidth: .infinity)
                        HStack(spacing:5){
                            Image("creditClover")
                                .resizable()
                                .scaledToFit()
                                .frame(width:13,height: 13)
                            Text("테아")
                                .font(.efDiary(13)).foregroundColor(.memoPrimary)
                        }
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundColor(Color.memoPrimary)
                            .frame(height: 1).padding(.horizontal,15)
                            .padding(.top,3)
                        
                    }.padding(.top)
                    
                    CreditGridView(teamName: "기획 / 연출", teamMembers: ["냄냄","도네최고아이돌","아코","우파루파맨","테아","청달이"])
                    
                    CreditGridView(teamName: "개발", teamMembers: ["iOS Hamp","케이","굵은소금"])
                    
                    CreditGridView(teamName: "UI / 디자인", teamMembers: ["계란밥","doki","밤바다소다","유문암"])
                    
                    CreditGridView(teamName: "일러스트", teamMembers: ["계란밥","레모네","와랑","테아","혓바늘"])
                    
                    CreditGridView(teamName: "애니메이션", teamMembers: ["레모네"])
                    
                    CreditGridView(teamName: "효과음 / 배경음", teamMembers: ["히사이시죠이시죠"])
                    
                    
                    SpecialThanksView()
                    
                    
                   
                    
                    
                    
                    
                }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
                    .background {
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.memoBg)
                                
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color.memoPrimary, lineWidth:2)
                                .zIndex(2.0)
                            
                        }
                        
                        
                            
                    }
                    .frame(maxWidth:.infinity,maxHeight: .infinity)
                    .padding(.horizontal)
                    .padding(.vertical,5)
                
                
                
                
                    
                
                
                
                // MARK: Footer
                VStack(spacing:20){
                    Rectangle()
                        .fill(Color.memoPrimary)
                        .frame(maxWidth:.infinity,maxHeight: 1)
                    Rectangle()
                        .fill(Color.memoPrimary)
                        .frame(maxWidth:ScreenSize.width/3,maxHeight: 2)
                   
                    
                        
                    
                    Spacer()
                }.frame(maxWidth:.infinity,maxHeight: ScreenSize.height/6,alignment: .top)
                    .background(Color.memoBg)
            }
           
            
            
        }
        .ignoresSafeArea()
    }
}




struct Credit_Previews: PreviewProvider {
    static var previews: some View {
        CreditView()
    }
}


struct CreditGridView: View {
    
    var teamName:String
    var teamMembers:[String]
    
    
    var body: some View {
        let size:CGFloat = 13
        VStack(spacing:5){
            Text(teamName).font(.efDiary(20)).foregroundColor(.memoPrimary).frame(maxWidth: .infinity)
            HStack(spacing:0){
                
                ForEach(teamMembers,id: \.self){ (member:String) in
                    Image("infoLeaf")
                        .resizable()
                        .scaledToFit()
                        .frame(width:size,height: size)
                    Text(member)
                        .font(.efDiary(size)).foregroundColor(.memoPrimary)
                }
                
            }
            Line()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .foregroundColor(Color.memoPrimary)
                .frame(height: 1).padding(.horizontal,15)
                .padding(.top,3)
            
        }
    }
}

struct SpecialThanksView: View {
    
    let columns:[GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    let supports = ["뚱이99", "컹스캉스콩스", "9급갓무원", "우유니화이트",
                    "개털",
                    "빛고래",
                    "qlapalal",
                    "백색큐브",
                    "리버7",
                    "김아진03",
                    "냉동피자",
                    "재은잉",
                    "안솔머칸나",
                    "Funnnnnnn7",
                    "메루",
                    "이젠",
                    "타케하",
                    "꼬마",
                    "별뮤",
                    "탄자나이트",
                    "개두",
                    "서라연",
                    "하루조아",
                    "열람제한",
                    "청슬",
                    "오렌 Oren",
                    "챤넛",
                    "밤서",
                    "혼종밀가루",
                    "펄슨얼리티",
                    "놀찬",
                    "휘뚜루따뚜루",
                    "Gonei",
                    "삼월과군청",
                    "조1l",
                    "해 무",
                    "찌가",
                    "시계소년",
                    "빈매미",
                    "웅와",
                    "전번",
                    "유해",
                    "Bbada",
                    "조은놈",
                    "짜짜네",
                    "우리의멋진스노우맨",
                    "오잉지에이드",
                    "개굴주먹밥",
                    "때찌",
                    "베라기0",
                    "우워링",
                    "레모네",
                    "투헤드",
                    "애아빠우왁굳",
                    "랄비",
                    "취한고라니",
                    "이시국로동자",
                    "버동",
                    "군만두6",
                    "뱌 밍",
                    "수우현",
                    "은한",
                    "TriShiKa",
                    "HamHam",
                    "반갑다구ㄹl",
                    "이공우",
                    "마인워크",
                    "김세윤",
                    "Undeok",
                    "송도 살고싶다",
                    "탈모걸린검사",
                    "너귤너굴",
                    "어덜트매드맨",
                    "대오",
                    "l 고라니단 l",
                    "두개바면",
                    "멍차",
                    "방석에있는인형",
                    "파마산치2즈",
                    "콜라맛마이쭈",
                    "날구리",
                    "왁동물원",
                    "아즈사",
                    "임쌈장",
                    "첫눈1103",
                    "고라윙",
                    "세제는 피죤",
                    "이제막유입한팬치",
                    "새카매요",
                    "디잔몬",
                    "구아구아",
                    "연  풍",
                    "왁만치",
                    "굵은소금",
                    "GongNo20",
                    "메타범순",
                    "곽덕팔",
                    "아몬드사탕",
                    "원땅",
                    "3만원",
                    "레오29",
                    "Inoue",
                    "따뜻하니까",
                    "센티미터",
                    "anniyong",
                    "케이",
                    "냄냄",
                    "아코",
                    "품애",
                    "단이비",
                    "혓바늘",
                    "도네최고아이돌"]
    
    
    var body: some View {
        let size:CGFloat = 13
        VStack(spacing:5){
            Text("Special Thanks").font(.efDiary(30))
                .foregroundColor(.memoPrimary)
            
            
            LazyVGrid(columns: columns) {
                ForEach(supports,id:\.self){ (support:String) in
                    HStack(spacing:0){
                        
                            Image("infoLeaf")
                                .resizable()
                                .scaledToFit()
                                .frame(width:size,height: size)
                            Text(support)
                                .font(.efDiary(size)).foregroundColor(.memoPrimary)
                        }
                        
                }.padding(.vertical,5)
            }
            
            }
             
        }
}


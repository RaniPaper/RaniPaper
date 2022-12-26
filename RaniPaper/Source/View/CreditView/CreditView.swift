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
    let supports = [                    "뚱이99",
                                        "컹스캉스콩스",
                                        "9급갓무원",
                                        "우유니화이트",
                                        "3만원",
                                        "anniyong",
                                        "Bbada",
                                        "Funnnnnnn7",
                                        "Gonei",
                                        "GongNo20",
                                        "HamHam",
                                        "Inoue",
                                        "l 고라니단 l",
                                        "qlapalal",
                                        "TriShiKa",
                                        "Undeok",
                                        "개굴주먹밥",
                                        "개두",
                                        "개털",
                                        "계란밥",
                                        "고라윙",
                                        "곽덕팔",
                                        "구아구아",
                                        "군만두6",
                                        "굵은소금",
                                        "김세윤",
                                        "김아진03",
                                        "꼬마",
                                        "날구리",
                                        "냄냄",
                                        "냉동피자",
                                        "너귤너굴",
                                        "놀찬",
                                        "단이비",
                                        "대오",
                                        "도네최고아이돌",
                                        "두개바면",
                                        "디잔몬",
                                        "따뜻하니까",
                                        "때찌",
                                        "랄비",
                                        "레모네",
                                        "레오29",
                                        "리버7",
                                        "마인워크",
                                        "멍차",
                                        "메루",
                                        "메타범순",
                                        "반갑다구ㄹl",
                                        "밤바다소다",
                                        "밤서",
                                        "방석에있는인형",
                                        "백색큐브",
                                        "뱌 밍",
                                        "버동",
                                        "베라기0",
                                        "별뮤",
                                        "빈매미",
                                        "빛고래",
                                        "삼월과군청",
                                        "새카매요",
                                        "서라연",
                                        "세제는 피죤",
                                        "센티미터",
                                        "송도 살고싶다",
                                        "수우현",
                                        "시계소년",
                                        "아몬드사탕",
                                        "아즈사",
                                        "아코",
                                        "안솔머칸나",
                                        "애아빠우왁굳",
                                        "어덜트매드맨",
                                        "연 풍",
                                        "열람제한",
                                        "오렌 Oren",
                                        "오잉지에이드",
                                        "왁동물원",
                                        "왁만치",
                                        "우리의멋진스노우맨",
                                        "우워링",
                                        "웅와",
                                        "원땅",
                                        "유해",
                                        "은한",
                                        "이공우",
                                        "이시국로동자",
                                        "이제막유입한팬치",
                                        "이젠",
                                        "임쌈장",
                                        "재은잉",
                                        "전번",
                                        "조1l",
                                        "조은놈",
                                        "짜짜네",
                                        "찌가",
                                        "챤넛",
                                        "첫눈1103",
                                        "청슬",
                                        "취한고라니",
                                        "케이",
                                        "콜라맛마이쭈",
                                        "타케하",
                                        "탄자나이트",
                                        "탈모걸린검사",
                                        "테아",
                                        "투헤드",
                                        "파마산치2즈",
                                        "펄슨얼리티",
                                        "품애",
                                        "하루조아",
                                        "핫케이크좋아",
                                        "해 무",
                                        "혓바늘",
                                        "혼종밀가루",
                                        "휘뚜루따뚜루",]
    
    
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


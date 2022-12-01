//
//  MemoView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/27.
//

import SwiftUI

struct MemoView: View {
    @ObservedObject var viewModel:MemoViewModel = MemoViewModel()
    let columns:[GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    let memos:[MemoModel] = [MemoModel(title: "제목1", content: "간다라ㅏㅁ암앎ㅇ라asdasdsdadasdaas"),
                             MemoModel(title: "제목2", content: "내용22222222222222222222"),
                             MemoModel(title: "제목3", content: "내용33333333333333333333"),
                             MemoModel(title: "제목4", content: "내용44444444444444444444"),
                             MemoModel(title: "제목5", content: "내용55555555555555555555"),
                             MemoModel(title: "제목6", content: "내용66666666666666666666"),
                             MemoModel(title: "제목7", content: "내용66666666666666666666"),
                             MemoModel(title: "제목8", content: "내용66666666666666666666"),
                             MemoModel(title: "제목9", content: "내용66666666666666666666")]
    var body: some View {
        ZStack(alignment:.bottom) {
            VStack(spacing:0){
                
                GeometryReader { proxy in
                    let thin:CGFloat = 5
                    let thinPadding:CGFloat = 10
                    ZStack {
                        //MARK: 왼쪽 사각형
                        VStack{
                            Rectangle()
                                .fill(Color.memoPrimary)
                                .frame(maxWidth:thin,maxHeight: proxy.size.height)
                                .padding(.leading,thinPadding)
                        }.frame(maxWidth:proxy.size.width,alignment: .leading)
                        
                        VStack(spacing: 2) {
                        
                            Text("기록")
                                .font(.efDiary(30))
                                .foregroundColor(.memoPrimary)
                            Text("(-)")
                                .font(.efDiary(20))
                                .foregroundColor(.memoPrimary)
                                .frame(maxWidth:proxy.size.width)
                                .overlay {
                                    HStack{
                                        //MARK: 보는 방법 버튼
                                        Button {
                                                viewModel.isDropDown.toggle()
                                            
                                        } label: {
                                            HStack(spacing: 0){
                                                Text(viewModel.wayToShow)
                                                    .font(.kotra(20))
                                                    .foregroundColor(.memoPrimary)
                                                Image(systemName: "arrowtriangle.down.fill").foregroundColor(.memoPrimary)
                                            }
                                        }
                                        .overlay(alignment:.topLeading) {
                                            //MARK: 드랍다운
                                            if viewModel.isDropDown{
                                                VStack(spacing:0){
                                                    
                                                    Text("크게보기")
                                                        .font(.kotra(20))
                                                        .foregroundColor(.memoDropDownText)
                                                        .contentShape(Rectangle())
                                                        .onTapGesture {
                                                            
                                                            viewModel.isDropDown.toggle()
                                                            if(viewModel.wayToShow != "크게보기")
                                                            {
                                                                viewModel.wayToShow = "크게보기"
                                                            }
                                                                
                                                            
                                                        }
                                                    
                                                    Rectangle().frame(height: 1).padding(.horizontal,5)
                                                        .foregroundColor(.memoDropDownText)
                                                    Text("작게보기")
                                                        .font(.kotra (20))
                                                        .foregroundColor(.memoDropDownText)
                                                        .contentShape(Rectangle())
                                                        .onTapGesture {
                                                            
                                                            viewModel.isDropDown.toggle()
                                                            if(viewModel.wayToShow != "작게보기")
                                                            {
                                                                viewModel.wayToShow = "작게보기"
                                                            }
                                                                
                                                            
                                                        }
                                                }
                                                .padding(.horizontal,5)
                                                .background(Color.memoDropDownBg)
                                                .offset(y:25)
                                                
                                            }
                                            
                                        }
                                        .zIndex(2.0)
                                        .offset(x:thinPadding*2)
                                    
                                        
                                        Spacer()
                                        
                                        //MARK: 달력버튼
                                        Button {
                                            viewModel.showDatePicker.toggle()
                                        } label: {
                                            Image("memoCalendar")
                                        }
                                      
                                        //MARK: 삭제버튼
                                        Button {
                                            viewModel.deleteMode.toggle()
                                        } label: {
                                            Image("memoTrash")
                                        }.padding(.trailing,thinPadding*2)

                                    }
                                }
                                .zIndex(2)
                            
                            //MARK: 하단 사각형
                            Rectangle()
                                .fill(Color.memoPrimary)
                                .frame(maxWidth:proxy.size.width,maxHeight: 10)
                                .padding(.bottom,thinPadding).zIndex(1)
                            
                            Rectangle()
                                .fill(Color.memoPrimary)
                                .frame(maxWidth:proxy.size.width,maxHeight: 1)

                        }
                        .frame(maxWidth:proxy.size.width,maxHeight:proxy.size.height,alignment: .bottom)
                        
                        
                        //MARK: 오른 사각형
                        VStack{
                            Rectangle()
                                .fill(Color.memoPrimary)
                                .frame(maxWidth:thin,maxHeight: proxy.size.height)
                                .padding(.trailing,thinPadding)
                        }.frame(maxWidth:proxy.size.width,alignment: .trailing)
                    }
                    
                }
                .frame(maxHeight:ScreenSize.height/6,alignment: .bottom)
                .background( Color.memoBg)
                .zIndex(2)
                //Header
                
                
                ScrollView(.vertical)
                {
                    LazyVGrid(columns: columns) {
                        ForEach(memos){ memo in
                            StickerView(memo: memo)
                        }
                    }
                }
                .padding(.vertical)
                .background(Color.init(hexcode: "B2BFAC"))
                .overlay {
                    VStack{
                        Button {
                            
                        } label: {
                            Image("Floating")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .padding(.bottom,10)
                                .padding(.trailing,10)
                        }
                    }.frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .bottomTrailing)

                }
                
                
                Image("memoBottomBanner")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth:.infinity,maxHeight: ScreenSize.height/6)
                    
                
            } //Header
            
            
        }
        .edgesIgnoringSafeArea(.vertical)
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView()
    }
}

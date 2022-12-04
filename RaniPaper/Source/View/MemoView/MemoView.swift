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
                            Text("(\(viewModel.memos.count))")
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
                                                    .padding(.leading,10)
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
                                               // .padding(.horizontal,5)
                                                .background(Color.memoDropDownBg)
                                                .offset(y:25)
                                                
                                            }
                                            
                                        }
                                        .zIndex(2.0)
                                        .offset(x:thinPadding+5)
                                    
                                        
                                        Spacer()
                                        
                                      

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
                
                //MARK: Scroll
                ScrollView(.vertical)
                {
                    if(viewModel.wayToShow == "크게보기")
                    {
                        LazyVGrid(columns: columns) {
                            ForEach(viewModel.memos){ memo in
                                LargeStickerView(memo: memo)
                                    .overlay(content: {
                                        VStack{
                                            if(viewModel.deleteMode)
                                            {
                                                Button {
                                                    if(viewModel.trashSet.contains(memo.id))
                                                    {
                                                        viewModel.trashSet.remove(memo.id)
                                                    }
                                                    else
                                                    {
                                                        viewModel.trashSet.insert(memo.id)
                                                    }
                                                    
                                                } label: {
                                                    
                                                Image (viewModel.trashSet.contains(memo.id) ? "memoCheckBox": "memoEmptyBox")
                                                }
                                                .padding(.leading,5)
                                                .padding(.top,5)
                                                       
                                                       
                                                    

                                            }
                                            
                                        }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
                                    })
                                    .contentShape(Rectangle())
                                    .onTapGesture { 
                                        viewModel.showEditView = true
                                        viewModel.existMemo = memo
                                    }
                            }
                        }
                    }
                    else
                    {
                        LazyVGrid(columns:[GridItem(.flexible())])
                        {
                            ForEach(viewModel.memos) { memo in
                                SmallStickerView(memo: memo)
                                    .overlay(content: {
                                        VStack{
                                            if(viewModel.deleteMode)
                                            {
                                                Button {
                                                    if(viewModel.trashSet.contains(memo.id))
                                                    {
                                                        viewModel.trashSet.remove(memo.id)
                                                    }
                                                    else
                                                    {
                                                        viewModel.trashSet.insert(memo.id)
                                                    }
                                                    
                                                } label: {
                                                    
                                                Image (viewModel.trashSet.contains(memo.id) ? "memoCheckBox": "memoEmptyBox")
                                                }
                                                .padding(.leading,5)
                                                .padding(.top,5)
                                                       
                                                       
                                                    

                                            }
                                            
                                        }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
                                    })
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        viewModel.showEditView = true
                                        viewModel.existMemo = memo
                                    }
                            }
                        }
                    }
                    
                }
                .padding(.vertical)
                .background(Color.init(hexcode: "B2BFAC"))
                .overlay {
                    //MARK: 플로팅 버튼
                    VStack{
                        Button {
                           // viewModel.existMemo = nil
                            //viewModel.showEditView = true
                            viewModel.showDeleteModal.toggle()
                        } label: {
                            Image("memoWrite")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .padding(.bottom,10)
                                .padding(.trailing,10)
                        }
                    }.frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .bottomTrailing)

                }
                
                // MARK: 하단 배너
                Image("memoBottomBanner")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth:.infinity,maxHeight: ScreenSize.height/6)
                    
                
            }
            
            
        }
 
        .edgesIgnoringSafeArea(.vertical)
        .fullScreenCover(isPresented: $viewModel.showEditView, content: {
            EditMemoView(showEditView: $viewModel.showEditView,existMemo: viewModel.existMemo).onDisappear{
                //편집 창 꺼지면 fetchMemos
                viewModel.fetchMemos()
            }
        })
        .popup(isPresented: $viewModel.showDeleteModal) {
            
            VStack{
                Image("memoDeleteTrash")
            }
            .padding()
            //.background(RoundedRectangle(cornerRadius:10))
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView()
    }
}

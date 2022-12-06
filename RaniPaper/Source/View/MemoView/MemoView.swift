//
//  MemoView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/11/27.
//

import SwiftUI
import PopupView

struct MemoView: View {
    @ObservedObject var viewModel:MemoViewModel = MemoViewModel()
    let columns:[GridItem] = Array(repeating: GridItem(.flexible()), count: 2)

   
    var body: some View {
        ZStack(alignment:.bottom) {
            VStack(spacing:0){
                
                GeometryReader { proxy in
                    let thinPadding:CGFloat = 20
                    ZStack {
                        //MARK: 왼쪽 사각형
                        
                        
                        VStack(spacing: 2) {
                        
                            Text("기록")
                                .font(.efDiary(30))
                                .bold()
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
                                            // MARK: 보는방법 텍스트
                                            HStack(spacing: 0){
                                                Text(viewModel.wayToShow)
                                                    .font(.kotra(20))
                                                    .foregroundColor(.memoPrimary)
                                                Image(systemName: "arrowtriangle.down.fill").foregroundColor(.memoPrimary)
                                            }
                                            .padding(.leading,10)
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
                                .padding(.bottom,10).zIndex(1)
                            
                            Rectangle()
                                .fill(Color.memoPrimary)
                                .frame(maxWidth:proxy.size.width,maxHeight: 1)

                        }
                        .frame(maxWidth:proxy.size.width,maxHeight:proxy.size.height,alignment: .bottom)
                        
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
                                        if(viewModel.deleteMode) //삭제 모드 켜있을 시 메모지 클릭해도 삭제 담기
                                        {
                                            if(viewModel.trashSet.contains(memo.id))
                                            {
                                                viewModel.trashSet.remove(memo.id)
                                            }
                                            else
                                            {
                                                viewModel.trashSet.insert(memo.id)
                                            }
                                        }
                                        else //아닐 시 편집화면
                                        {
                                            viewModel.showEditView = true
                                            viewModel.existMemo = memo
                                        }
                                        
                                    }
                                    .onLongPressGesture(minimumDuration: 1) {
                                        HapticManager.shared.impact(style: .light)
                                        viewModel.deleteMode = true
                                    }
                            }
                        }
                        .padding(.leading,5)
                        .padding(.top,5)
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
                                        if(viewModel.deleteMode) //삭제 모드 켜있을 시 메모지 클릭해도 삭제 담기
                                        {
                                            if(viewModel.trashSet.contains(memo.id))
                                            {
                                                viewModel.trashSet.remove(memo.id)
                                            }
                                            else
                                            {
                                                viewModel.trashSet.insert(memo.id)
                                            }
                                        }
                                        else //아닐 시 편집화면
                                        {
                                            viewModel.showEditView = true
                                            viewModel.existMemo = memo
                                        }
                                        
                                    }
                                    .onLongPressGesture(minimumDuration: 1) {
                                        HapticManager.shared.impact(style: .light)
                                        viewModel.deleteMode = true
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
                            if(viewModel.deleteMode)
                            {
                                viewModel.showDeleteModal.toggle()
                            }
                            else
                            {
                                viewModel.existMemo = nil
                                 viewModel.showEditView = true
                            }
                           
                           
                        } label: {
                            Image(viewModel.deleteMode ? "memoFloatingDelete" : "memoFloatingPen")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .padding(.bottom,20)
                                .padding(.trailing,10)
                        }
                    }.frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .bottomTrailing)

                }
                
                // MARK: 하단 배너
                VStack(spacing:0){
                    Rectangle()
                        .fill(Color.memoPrimary)
                        .frame(maxWidth:.infinity,maxHeight: 1)
                    Spacer()
                    Rectangle()
                        .fill(Color(hexcode: "F4D4B6"))
                        .frame(maxWidth:ScreenSize.width/3,maxHeight: 2)
                        .padding(.bottom,15)
                    Image("memoClover")
                        .resizable()
                        .frame(width: ScreenSize.width/6, height: ScreenSize.width/6)
                        .scaledToFit()
                        .padding(.bottom,15)
                        
                    
                    Spacer()
                }.frame(maxWidth:.infinity,maxHeight: ScreenSize.height/6)
                    .background(Color.memoBg)
              
                    
                    
                
            }
            
            
        }
        .edgesIgnoringSafeArea(.vertical)
        .fullScreenCover(isPresented: $viewModel.showEditView, content: {
            EditMemoView(showEditView: $viewModel.showEditView,existMemo: viewModel.existMemo).onDisappear{
                //편집 창 꺼지면 fetchMemos
                viewModel.fetchMemos()
            }
        })
        .popup(isPresented: $viewModel.showDeleteModal,closeOnTap: false,closeOnTapOutside: true,backgroundColor: .black.opacity(0.2)) {
            viewModel.fetchMemos()
        } view: {
            // MARK: 팝업 뷰
            ZStack(alignment: .top){
               RoundedRectangle(cornerRadius:15).fill(Color.init(hexcode: "FFF0BB")) //채우기
               RoundedRectangle(cornerRadius:15).stroke(Color.memoPrimary,lineWidth: 3) //테두리
                VStack(spacing:20){
                   Image("memoDeleteTrash")
                   Text("정말로 삭제하시겠습니까?").font(.efDiary(18)).foregroundColor(Color.init(hexcode: "9E4242"))
                   
                   Text("*지운 메모는 복구할 수 없습니다.").font(.efDiary(13)).foregroundColor(Color.init(hexcode: "D09393"))
                    HStack(spacing:30){
                        Button {
                            viewModel.deleteMemos()
                            viewModel.showDeleteModal = false
                            viewModel.deleteMode = false
                        } label: {
                            Text("삭제")
                                .font(.efDiary(28))
                                .foregroundColor(Color.init(hexcode: "EC3A3A"))
                        }

                        Button {
                            viewModel.showDeleteModal = false
                        } label: {
                            Text("취소")
                                .font(.efDiary(28))
                                .foregroundColor(Color.init(hexcode: "5E2121"))
                        }

                    }
                    .frame(maxWidth:.infinity)
                 
                   
                   
               }
               .padding(.top,20)
            
               
            }
            .frame(maxWidth:ScreenSize.width/1.5,maxHeight: ScreenSize.width/1.7)
                 
            
                
        }
        .onTapGesture {
            viewModel.deleteMode = false
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView()
    }
}

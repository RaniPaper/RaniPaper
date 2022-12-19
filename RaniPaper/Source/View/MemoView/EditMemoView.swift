//
//  MemoEditView.swift
//  RaniPaper
//
//  Created by yongbeomkwak on 2022/12/01.
//

import SwiftUI
import AlertToast

struct EditMemoView: View {
    

    @ObservedObject var viewModel:EditMemoViewModel = EditMemoViewModel()
    @Binding var showEditView:Bool
    var existMemo: MemoModel? // 기존의 memo
    
    var body: some View {
        let inputColor:Color = Color.init(hexcode: "FFFDF4")
        ZStack {

            VStack(){
      
                VStack(spacing:0){
                    // - MARK: 뒤로가기
                    HStack{
                        Button {
                            UIApplication.shared.endEditing()
                            showEditView = false
                        }label: {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(Color.memoPrimary)
                        }
                        
                        Spacer()
                        
                    }
                    // MARK: 날짜,새싹,구분선
                    HStack(alignment: .bottom,spacing: 0){
                        Text(Date.dateformat.string(from: viewModel.nowDate))
                            .font(.kotra(25)).frame(maxWidth:.infinity,alignment: .leading)
                        
                    
                        Image("footPrint").padding(.bottom)
                        
                        Text("(\(viewModel.content.count))")
                            .font(.efDiary(25)).offset(x:-5).frame(maxWidth:.infinity,alignment: .trailing)
                            
                        
                    }.foregroundColor(.memoPrimary)
 
                    // MARK: 제목
                    TextField("", text: $viewModel.title)
                        .font(.kotra(20))
                        .foregroundColor(Color.memoPrimary)
                    // 텍스트 필드 모양 결정하는 패딩
                        .padding(.vertical,10)
                        .padding(.horizontal,25)
                        .background(RoundedRectangle(cornerRadius: 8).fill(inputColor))
                        .lineLimit(1)
                        .overlay(RoundedRectangle(cornerRadius: 8.0).strokeBorder(Color.memoPrimary, style: StrokeStyle(lineWidth: 2.0)))
                        .overlay {
                            HStack{
                                Capsule().fill(Color.memoPrimary).frame(width:30,height:15).offset(x:-10)
                            }.frame(maxWidth: .infinity,alignment: .leading)
                        }
                        .overlay {
                            VStack{
                                Button {
                                    if(viewModel.title.isEmpty)
                                    {
                                        viewModel.showAlert.toggle()
                                    }
                                    else
                                    {
                                        if viewModel.update() {
                                            UIApplication.shared.endEditing()
                                            showEditView = false
                                        }
                                    }
                                    
                                    
                                } label: {
                                    Image("memoSave")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                }
                                .frame(width: 50,height: 60)
                            }.frame(maxWidth: .infinity,alignment: .bottomTrailing)
                                .offset(x:-10,y:51) //y:offset TextField Height + strok
                                
                        }
                }
                .padding(.horizontal,15) //너비 결정하는 패딩
                .zIndex(2)
                
                
               
                   
                VStack {
                    Text("MEMO").font(.efDiary(20))
                        .foregroundColor(Color(hexcode: "E1C4B7"))
                        .padding(.top)
                    TextEditor(text: $viewModel.content)
                        .font(.kotra(25))
                        .foregroundColor(.memoPrimary)
                        .colorMultiply(inputColor)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal,5) //글자 들여쓰기를 위한 패딩
                    
                    
                    if(viewModel.showStamps)
                    {
                        HStack{
                            
                            ForEach(viewModel.stamps.filter({
                                $0 != viewModel.selectedStamp
                            }),id: \.self) { (id:Int) in
                                Image("viichanStemp\(id)")
                                    .resizable()
                                    .frame(width:70,height: 70)
                                    .scaledToFit()
                                    .contentShape(Rectangle())
                                    .padding(.vertical,5)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        
                                        withAnimation {
                                            viewModel.selectedStamp = id
                                            viewModel.showStamps = false
                                        }
                                        
                                        
                                    }
                            }
                            
                            
                        }.frame(maxWidth:.infinity)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8.0).strokeBorder(Color.memoPrimary, style: StrokeStyle(lineWidth: 2.0))
                            }
                            .padding(.horizontal)
                            .transition(.asymmetric(insertion: .opacity, removal: .scale(scale: .zero)))
                           
                        
                    }
                    
                    
                    HStack{
                        Spacer()
                        
                        // MARK: 비챤 스탬프
                        Image("viichanStemp\(viewModel.selectedStamp)")
                            .resizable()
                            .frame(width:70,height: 70)
                            .scaledToFit()
                            .contentShape(Rectangle())
                            .onTapGesture {
                                
                                withAnimation {
                                    viewModel.showStamps.toggle()
                                }
                                
                                
                            }
                    }.padding(.trailing,10)
                        .padding(.bottom,10)
                        
                    
                }
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 8.0).strokeBorder(Color.memoPrimary, style: StrokeStyle(lineWidth: 2.0))
                })
                .background(inputColor)
                .padding(.top,5)
                .padding(.horizontal,15)
                .padding(.bottom,20)
                
                    
                    
                   
                    
                
                
                
                
               
            }
        }
        //.edgesIgnoringSafeArea(.vertical)
        .background(Color.memoBg)
        .onAppear{
            guard let existMemo else { return }
            print("기존 memo를 불러옵니다:", existMemo)
            viewModel.memoId = existMemo.id
        //    viewModel.nowDate = existMemo.date // 업데이트 날짜로 반영해야하나?
            viewModel.title = existMemo.title
            viewModel.content = existMemo.content
            viewModel.selectedStamp = existMemo.stamp
        }
        .toast(isPresenting: $viewModel.showAlert) {
            AlertToast(displayMode: .hud, type: .error(.red), title: "제목이 비어있습니다!", subTitle: "제목을 입력해주세요")
        }
        
    }
}

struct MemoEditView_Previews: PreviewProvider {
    static var previews: some View {
        EditMemoView(showEditView: .constant(false))
    }
}

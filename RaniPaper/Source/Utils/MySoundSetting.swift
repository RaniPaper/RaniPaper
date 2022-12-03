//
//  MySoundSetting.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/02.
//

import Foundation
import AVKit

class MySoundSetting: ObservableObject{
    static let BGM = MySoundSetting(url: "testBGM", extension: ".flac", .BGM) // BGM 컨트롤용 인스턴스
    static let SFX = MySoundSetting(url: "testSFX", extension: ".mp3", .SFX) // SFX 컨트롤용 인스턴스
    
    var player: AVAudioPlayer?
    var isEnable: Bool = true
    
    private init(url urlName: String, extension extensionName: String, _ type: SoundType){
        guard let url = Bundle.main.url(forResource: urlName, withExtension: extensionName) else {return}
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            
        } catch let error {
            print("음원을 불러오는데 오류가 발생했습니다.\(error.localizedDescription)")
        }
        
        switch type {
        case .BGM:
            isEnable = MyUserDefaults.shared.getValue(key: "배경음") as! Bool
        case .SFX:
            isEnable = MyUserDefaults.shared.getValue(key: "효과음") as! Bool
        }
            
        print("✅ MySoundSetting init")
    }
    
    //음원 재생
    func play(){
        player?.play()
    }
    
    //음원 정지
    func stop(){
        player?.stop()
    }
    
    func isPlaying() -> Bool{
        if let isPlaying = player?.isPlaying{
            return isPlaying
        } else {
            print("player이 생성되지 않음")
            return false
        }
    }
    //update isEnable
    func updateEnable(key: String){
        
    }
}

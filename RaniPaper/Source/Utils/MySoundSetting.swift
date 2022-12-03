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
    
    let urlName: String
    let extensionName: String
    var player: AVAudioPlayer?
    var isEnable: Bool = true
    
    private init(url urlName: String, extension extensionName: String, _ type: SoundType){
        self.urlName = urlName
        self.extensionName = extensionName
        
        // 해당 음성 타입의 활성 상태 초기화
        switch type {
        case .BGM:
            isEnable = MyUserDefaults.shared.getValue(key: "배경음") as! Bool
            player?.numberOfLoops = -1
        case .SFX:
            isEnable = MyUserDefaults.shared.getValue(key: "효과음") as! Bool
        }
            
        print("✅ MySoundSetting init")
    }
    
    //음원 재생
    func play() {
        guard let url = Bundle.main.url(forResource: self.urlName, withExtension: self.extensionName) else {return} // 번들에서 url 불러오기, 에러 처리 필요
        
        // 해당 url의 음원 재생하는 플레이어 생성
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch let error {
            print("음원을 불러오는데 오류가 발생했습니다.\(error.localizedDescription)")
        }
        
        if self.isEnable{
            player?.play()
        }
    }
    
    //음원 정지
    func stop(){
        player?.stop()
        player?.currentTime = 0
    }
    
    //음원 재생 상태 확인
    func isPlaying() -> Bool{
        if let isPlaying = player?.isPlaying{
            return isPlaying
        } else {
            print("player이 생성되지 않음")
            return false
        }
    }
    
    //음성 타입 활성 상태 업데이트
    func updateEnable(soundType: SoundType){
        self.isEnable = MyUserDefaults.shared.getValue(key: soundType.rawValue) as! Bool
    }
    
    // 음성 재생 상태 업데이트
    func updateSoundState(soundType: SoundType){
        self.updateEnable(soundType: soundType)
        switch soundType {
        case .BGM:
            if self.isEnable{
                if !self.isPlaying(){
                    self.play()
                }
            }
            else{
                self.stop()
            }
        default:
            break
        }
    }
}

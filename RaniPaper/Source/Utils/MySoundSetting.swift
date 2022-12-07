//
//  MySoundSetting.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/02.
//

import Foundation
import AVKit

class MySoundSetting: ObservableObject{
    let urlName: String
    let extensionName: String
    let soundType: SoundType
    var player: AVAudioPlayer?
    var isEnable: Bool = true
    
    private init(url urlName: String, extension extensionName: String, _ type: SoundType){
        self.urlName = urlName
        self.extensionName = extensionName
        
        // 해당 음성 타입의 활성 상태 초기화
        isEnable = MyUserDefaults.shared.getValue(key: type.rawValue) as! Bool
        player = nil
        soundType = type
            
        print("✅ MySoundSetting init")
        print("\(type.rawValue) 인스턴스 생성, fileName: \(self.urlName).\(self.extensionName)")
    }
    
    //음원 재생
    func play() {
        // 번들에서 url 불러오기, 에러 처리 필요
        guard let url = Bundle.main.url(forResource: self.urlName, withExtension: self.extensionName) else {
            print("🔥 url을 불러오지 못했습니다.")
            return
        }
        
        // 해당 url의 음원 재생하는 플레이어 생성
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch let error {
            print("🔥 음원을 불러오는데 오류가 발생했습니다.\(error.localizedDescription)")
        }
        
        // 소리 종류에 따라 루프 여부 결정
        switch soundType {
        case .BGM, .ALARM:
            player?.numberOfLoops = -1
        default:
            break
        }
        
        // 소리 설정이 활성 상태면 음원 재생
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

// 인스턴스 관리
extension MySoundSetting {
    static let BGM = MySoundSetting(url: "testBGM", extension: "mp3", .BGM)
    // BGM 컨트롤용 인스턴스
    static let SFX = MySoundSetting(url: "testSFX", extension: "mp3", .SFX)
    // SFX 컨트롤용 인스턴스
    static let Alarm = MySoundSetting(url: "testAlarm", extension: "mp3", .ALARM)
    static let bookFlip = MySoundSetting(url: "wavTest2", extension: "wav", .SFX)
    
    // 효과음 추가되면 위 형식으로 인스턴스 추가해서 사용 가능
    
    static func getInstance(soundType: SoundType) -> MySoundSetting{
        switch soundType {
        case .BGM:
            return MySoundSetting.BGM
        case .SFX:
            return MySoundSetting.SFX
        case .ALARM:
            return MySoundSetting.Alarm
        }
    }
}

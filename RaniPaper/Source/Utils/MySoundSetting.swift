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
        if let value = MyUserDefaults.shared.getValue(key: type.rawValue){
            self.isEnable = value as! Bool
        } else{
            self.isEnable = true
        }
        player = nil
        soundType = type
            
        print("✅ MySoundSetting init")
        print("\(type.rawValue) 인스턴스 생성, fileName: \(self.urlName).\(self.extensionName)")
    }
    
    /// 음원 재생 : 해당 인스턴스의 음원을 재생합니다.
    func play() {
        // 번들에서 url 불러오기, 에러 처리 필요
        guard let url = Bundle.main.url(forResource: self.urlName, withExtension: self.extensionName) else {
            print("🔥 url을 불러오지 못했습니다.")
            return
        }
        
        // 해당 url의 음원 재생하는 플레이어 생성(오버레이를 위해)
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch let error {
            print("🔥 음원을 불러오는데 오류가 발생했습니다.\(error.localizedDescription)")
        }
        
        // 소리 종류에 따라 설정 변경
        switch soundType {
        case .BGM:
            player?.numberOfLoops = -1
            player?.setVolume(0.5, fadeDuration: 0)
        default:
            player?.setVolume(0.75, fadeDuration: 0)
        }
        
        //볼륨 설정
        
        // 소리 설정이 활성 상태면 음원 재생
        if self.isEnable{
            player?.play()
        }
    }
    
    /// 음원 정지 : 해당 인스턴스의 음원 재생을 정지합니다.
    func stop(){
        player?.stop()
        player?.currentTime = 0
    }
    
    /// 음원 재생 상태 확인 : 해당 인스턴스의 음원을 재생합니다.
    /// - Returns: 음원이 재생중이면 true, 아니면 false 반환
    func isPlaying() -> Bool{
        if let isPlaying = player?.isPlaying{
            return isPlaying
        } else {
            print("player이 생성되지 않음")
            return false
        }
    }

    /// 음성 설정 상태 업데이트 : 설정에서 해당 종류의 음원 온/오프 여부를 업데이트 합니다.
    /// - Parameter SoundType: 음원 종류(BGM, SFX, ALARM)
    func updateEnable(soundType: SoundType){
        if let value = MyUserDefaults.shared.getValue(key: soundType.rawValue){
            self.isEnable =  value as! Bool
        } else {
            self.isEnable = true
        }
    }
    
    /// 음성 재생 상태 업데이트 : 설정에서 음원 온/오프 여부에 따라 현재 음원의 재생 상태를 업데이트 합니다.
    /// - Parameter SoundType: 음원 종류(BGM, SFX, ALARM)
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
    
    func setChannelVolume(_ volume: Float){
        self.player?.setVolume(volume, fadeDuration: 0)
    }
}

/// 인스턴스 관리
extension MySoundSetting {
    static let BGM = MySoundSetting(url: "BGM", extension: "wav", .BGM)
    // BGM 컨트롤용 인스턴스
    static let Alarm = MySoundSetting(url: "testAlarm", extension: "mp3", .ALARM)
    static let openSideMenu = MySoundSetting(url: "openSideMenu", extension: "wav", .SFX)
    static let closeSideMenu = MySoundSetting(url: "closeSideMenu", extension: "wav", .SFX)
    static let clickSideMenu = MySoundSetting(url: "clickSideMenu", extension: "wav", .SFX)
    
    // MARK: 사용 예시
    // static let MySound = MySoundSetting(url: "MySoundFileName", extension: "mp3", .SFX)
    // static let MySound2 = MySoundSetting(url: "MySoundFileName2", extension: "wav", .BGM)
    // static let MySound3 = MySoundSetting(url: "MySoundFileName3", extension: "flac", .ALARM)
    
    // 아래 함수는 수정 예정, 수정 전까지 새로 생성한 인스턴스가 설정의 온/오프 상태에 영향을 받지 않을 수 있음
    static func getInstance(soundType: SoundType) -> [MySoundSetting]{
        switch soundType {
        case .BGM:
            return [MySoundSetting.BGM]
        case .SFX:
            return [MySoundSetting.openSideMenu,
                    MySoundSetting.closeSideMenu,
                    MySoundSetting.clickSideMenu]
        case .ALARM:
            return [MySoundSetting.Alarm]
        }
    }
}

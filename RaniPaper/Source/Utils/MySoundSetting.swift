//
//  MySoundSetting.swift
//  RaniPaper
//
//  Created by SeaSalt on 2022/12/02.
//

import Foundation
import AVKit

class MySoundSetting: ObservableObject{
    static let instance = MySoundSetting()
    static let urlName = "testBGM"
    static let extensionName = ".flac"
    
    var player: AVAudioPlayer?
    
    //음원 재생
    func playSound(){
        guard let url = Bundle.main.url(forResource: MySoundSetting.urlName, withExtension: MySoundSetting.extensionName) else {return}
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print("재생하는데 오류가 발생했습니다.\(error.localizedDescription)")
        }
    }
    
    //음원 정지
    func stopSound(){
        player?.stop()
    }
}

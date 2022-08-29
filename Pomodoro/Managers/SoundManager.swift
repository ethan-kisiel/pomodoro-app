//
//  SoundManager.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 8/29/22.
//

import AVKit
import Foundation

class SoundManager
{
    static let shared = SoundManager()
    var player: AVAudioPlayer?
    
    func playSound(soundName: String)
    {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        do
        {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error
        {
            print("Error initializing audio player. \(error.localizedDescription)")
        }
    }
}

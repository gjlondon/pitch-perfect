//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by George London on 3/13/15.
//  Copyright (c) 2015 Rogueleaderr. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var receivedAudio:RecordedAudio!
    override func viewDidLoad() {
        super.viewDidLoad()
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filepathURL, error: &error)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filepathURL, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.rate = 2.0
        playAudio()
    }
    @IBAction func playSlowAudio(sender: UIButton) {            audioPlayer.rate = 0.5
        playAudio()
    }

    func playAudio(){
        audioEngine.stop()
        if audioPlayer.url != nil {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        else{
            println("player is nil")
        }
    }

    @IBAction func stopPlayback(sender: UIButton) {
        if audioPlayer.url != nil {
            audioPlayer.stop()
        }
        else{
            println("player is nil")
        }
    }

    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(2000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }

    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        var pitchPlayer = AVAudioPlayerNode()
        audioEngine.attachNode(pitchPlayer)
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch // In cents. The default value is 1.0. The range of values is -2400 to 2400
        audioEngine.attachNode(changePitchEffect)
        audioEngine.connect(pitchPlayer, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        pitchPlayer.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        pitchPlayer.play()
    }


}

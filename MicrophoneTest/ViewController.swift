//
//  ViewController.swift
//  MicrophoneTest
//
//  Created by yoshiaki-yamada on 2017/02/08.
//  Copyright © 2017年 yoshiaki-yamada. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate{

    var engine: AVAudioEngine!
    var snowboy: SnowBoyWrapper!

    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        snowboy = SnowBoyWrapper()
        engine = AVAudioEngine()

        engine.inputNode!.installTap(onBus: 0, bufferSize: 1024, format: engine.inputNode?.outputFormat(forBus: 0)) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            print(buffer.audioBufferList)
            self.snowboy.snowboyDetection(buffer)
        }

        try! engine.start()

        let urlString = Bundle.main.path(forResource: "pipipi", ofType: "mp3")
        let url = NSURL.init(fileURLWithPath: urlString!)

        do {
            audioPlayer = try AVAudioPlayer.init(contentsOf: url as URL)
            audioPlayer.delegate = self
        } catch{
            audioPlayer = nil
            print("audio player setting error")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finished")
    }

    @IBAction func pipipi(_ sender: Any) {
        // play sound prepared developer test. (pipipi.mp3)
        var soundIdRing:SystemSoundID = 0
        let soundUrl = NSURL.fileURL(withPath: Bundle.main.path(forResource: "pipipi", ofType:"mp3")!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundIdRing)
        AudioServicesPlaySystemSound(soundIdRing)
    }

}


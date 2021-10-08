//
//  ShazamService.swift
//  shazamMapProject
//
//  Created by Shukhrat Sagatov on 08.10.2021.
//

import ShazamKit
import AVFoundation

class ShazamService: NSObject {
    let session = SHSession()
    let audioEngine = AVAudioEngine()
    var lastMatchID: String = ""

    override init() {
        super.init()
        session.delegate = self
    }

    func startAnalysingAudio() {
        let inputNode = audioEngine.inputNode
        let bus = 0
        inputNode.installTap(onBus: bus, bufferSize: 2048, format: inputNode.inputFormat(forBus: bus)) { (buffer: AVAudioPCMBuffer!, time: AVAudioTime!) -> Void in
            self.session.matchStreamingBuffer(buffer, at: time)
        }

        audioEngine.prepare()
        try! audioEngine.start()
    }

    func stopAnalysingAudio() {
        let inputNode = audioEngine.inputNode
        let bus = 0
        inputNode.removeTap(onBus: bus)
        self.audioEngine.stop()
    }

}

extension ShazamService: SHSessionDelegate {
    func session(_ session: SHSession, didFind match: SHMatch) {
        if let matchedItem = match.mediaItems.first,
           let title = matchedItem.title,
           let artist = matchedItem.artist,
           let matchId = matchedItem.shazamID, matchId != lastMatchID {
            lastMatchID = matchId
            DispatchQueue.main.async {
                print("I am currently listening to: \(title) by \(artist) - Via ShazamKit")
            }
        }
    }

    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        if error != nil {
            print(error as Any)
        }
    }
}

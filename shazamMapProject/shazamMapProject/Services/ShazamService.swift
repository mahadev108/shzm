//
//  ShazamService.swift
//  shazamMapProject
//
//  Created by Shukhrat Sagatov on 08.10.2021.
//

import ShazamKit
import AVFoundation

enum MediaDetectionError: Error {
    case detectionTimeout
}

struct ShazamMedia: Decodable {
    let title: String?
    let subtitle: String?
    let artistName: String?
    let albumArtURL: URL?
    let genres: [String]
}

class ShazamService: NSObject, ObservableObject {
    var isRecording = false {
        didSet { recordingStateChanged?(isRecording) }
    }
    private var audioEngine = AVAudioEngine()
    private let session = SHSession()
    private let signatureGenerator = SHSignatureGenerator()
    private var timer: Timer?
    private var completion: ((Result<ShazamMedia, MediaDetectionError>) -> Void)?
    var recordingStateChanged: ((Bool) -> Void)?

    override init() {
        super.init()
        session.delegate = self
    }

    public func cancelDetection() {
        guard audioEngine.isRunning else {
            return
        }
        audioEngine.stop()
        DispatchQueue.main.async {
            self.isRecording = false
        }
        return
    }

    public func detect(completion: @escaping (Result<ShazamMedia, MediaDetectionError>) -> Void) {
        self.completion = completion
        timer?.invalidate()
        timer = nil

        guard !audioEngine.isRunning else {
            return
        }

        // Create an audio format for our buffers based on the format of the input, with a single channel (mono).
        let audioFormat = AVAudioFormat(
            standardFormatWithSampleRate: audioEngine.inputNode.outputFormat(forBus: 0).sampleRate,
            channels: 1
        )

        audioEngine = AVAudioEngine()
        // Install a "tap" in the audio engine's input so that we can send buffers from the microphone to the session.
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 2048, format: audioFormat) { [weak session] buffer, audioTime in
            // Whenever a new buffer comes in, we send it over to the session for recognition.
            session?.matchStreamingBuffer(buffer, at: audioTime)
        }

        // Tell the system that we're about to start recording.
        try? AVAudioSession.sharedInstance().setCategory(.record)

        // Ensure that we have permission to record, then start running the audio engine.
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] success in
            guard success, let self = self else { return }

            self.timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: false) { t in
                self.cancelDetection()
                DispatchQueue.main.async {
                    self.completion?(.failure(.detectionTimeout))
                }
            }
            try? self.audioEngine.start()
            DispatchQueue.main.async {
                self.isRecording = true
            }
        }
    }
}

extension ShazamService: SHSessionDelegate {

    func session(_ session: SHSession, didFind match: SHMatch) {
        let mediaItems = match.mediaItems

        if let firstItem = mediaItems.first {
            let _shazamMedia = ShazamMedia(
                title: firstItem.title,
                subtitle: firstItem.subtitle,
                artistName: firstItem.artist,
                albumArtURL: firstItem.artworkURL,
                genres: firstItem.genres
            )
            DispatchQueue.main.async {
                self.timer?.invalidate()
                self.timer = nil
                self.cancelDetection()
                self.completion?(.success(_shazamMedia))
            }
        }
    }
}

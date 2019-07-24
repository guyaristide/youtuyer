//
//  YoutuyerView.swift
//  Pods-Runner
//
//  Created by Agnaramon Boris-Carnot on 19/07/2019.
//

import Foundation
import Flutter
import youtube_ios_player_helper
import SnapKit

enum PlayerState: String {
    case UNKNOWN = "UNKNOWN"
    case UNSTARTED = "UNSTARTED"
    case ENDED = "ENDED"
    case PLAYING = "PLAYING"
    case PAUSED = "PAUSED"
    case BUFFERING = "BUFFERING"
    case VIDEO_CUED = "VIDEO_CUED"
}

enum PlayerError: String {
    case UNKNOWN = "UNKNOWN"
    case INVALID_PARAMETER_IN_REQUEST = "INVALID_PARAMETER_IN_REQUEST"
    case HTML_5_PLAYER = "HTML_5_PLAYER"
    case VIDEO_NOT_FOUND = "VIDEO_NOT_FOUND"
    case VIDEO_NOT_PLAYABLE_IN_EMBEDDED_PLAYER = "VIDEO_NOT_PLAYABLE_IN_EMBEDDED_PLAYER"
}

class YoutuyerView: NSObject, FlutterPlatformView{
    
    private let frame: CGRect
    private let viewId: Int64
    private let registrar: FlutterPluginRegistrar
    private let params: [String: Any]
    private let playerView: UIView
    private let channel: FlutterMethodChannel
    private var isPlayerReady = false
    private var player: YTPlayerView!
    
    let playerVars = [
        "origin" : "https://www.youtube.com"
    ]
    
    init(_frame: CGRect,
         _viewId: Int64,
         _params: [String: Any]?,
         _registrar: FlutterPluginRegistrar) {
        frame = _frame
        viewId = _viewId
        registrar = _registrar
        params = _params!
        playerView = UIView(frame: frame)
        channel = FlutterMethodChannel(
            name: "youtuyer",
            binaryMessenger: registrar.messenger()
        )
        super.init()
        self.initPlayer()
        channel.setMethodCallHandler { [weak self] (call, result) in
            guard let `self` = self else { return }
            `self`.handle(call, result: result)
        }
    }
    
    func view() -> UIView {
        return playerView
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialization":
            result(nil)
        case "loadOrCueVideo":
            print("loadOrCueVideo is called")
            let params = call.arguments as! Dictionary<String, Any>
            let videoId = params["videoId"] as! String
            let startSeconds = params["startSeconds"] as? Double ?? 0.0
            loadOrCueVideo(videoId: videoId, startSeconds: startSeconds)
            result(nil)
        case "play":
            print("play is called")
            if (self.isPlayerReady) {
                self.player.playVideo()
            }
            result(nil)
        case "pause":
            print("pause is called")
            if (self.isPlayerReady) {
                self.player.pauseVideo()
            }
            result(nil)
        case "seekTo":
            print("seekTo is called")
            if (self.isPlayerReady) {
                let second = call.arguments as! Double
                self.player.seek(toSeconds: Float(Int(second)), allowSeekAhead: true)
            }
            result(nil)
        case "mute":
            print("mute is called")
            //self.player.mute()
            result(nil)
        case "unMute":
            print("mute is called")
            //self.player.unMute()
            result(nil)
        case "setVolume":
            print("setVolume is called")
            result(nil)
        case "scaleMode":
            /*let scaleMode = call.arguments as! Int
            self.changeScaleMode(scaleMode: scaleMode)
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let `self` = self else { return }
                self.playerView.layoutIfNeeded()
            }*/
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func loadOrCueVideo(videoId: String, startSeconds: Double = 0.0) {
        if (!self.isPlayerReady) {
            return
        }
        player.load(withVideoId: videoId, playerVars: playerVars)
    }
    
    func initPlayer(){
        
        let videoId = params["videoId"] as? String
        let showUI = params["showUI"] as! Bool
        let scaleMode = params["scale_mode"] as? Int ?? 0
       
        self.playerView.backgroundColor = .yellow
        self.player = YTPlayerView()
        self.playerView.addSubview(self.player)
        
        self.player.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        player.delegate = self
        player.load(withVideoId: videoId!, playerVars: playerVars)
        
        //player.cueVideo(byId: "2kHnFYzYC-0", startSeconds: 0.0, suggestedQuality: .medium)
        
    }
    
    private func onStateChange(state: YTPlayerState) {
        var customState: PlayerState!
        switch state {
        case .queued:
            customState = .VIDEO_CUED
        case .ended:
            customState = .ENDED
        case .playing:
            customState = .PLAYING
        case .paused:
            customState = .PAUSED
        case .buffering:
            customState = .BUFFERING
        case .unstarted:
            customState = .UNSTARTED
        case .unknown:
            break
        }
        print("state = \(state)")
        channel.invokeMethod("onStateChange", arguments: customState.rawValue)
    }
    
}

extension YoutuyerView: YTPlayerViewDelegate{
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        print(#function)
        let startSeconds = (params["startSeconds"] as? Double ?? 0.0)
        player.seek(toSeconds: Float(Int(startSeconds)), allowSeekAhead: true)
        self.isPlayerReady = true
        channel.invokeMethod("onReady", arguments: nil)
    }
    
    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {
        print("\(#function):\(playTime)")
        channel.invokeMethod("onCurrentSecond", arguments: playTime)
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        print("\(#function):\(state)")
        if (state == YTPlayerState.playing) {
            channel.invokeMethod("onVideoDuration", arguments: player.duration)
        }
        self.onStateChange(state: state)
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo quality: YTPlaybackQuality) {
         print("\(#function):\(quality)")
    }
}

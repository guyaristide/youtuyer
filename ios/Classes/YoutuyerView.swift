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

class YoutuyerView: NSObject, FlutterPlatformView{
    
    private let frame: CGRect
    private let viewId: Int64
    private let registrar: FlutterPluginRegistrar
    private let playerView: UIView
    private let channel: FlutterMethodChannel
    private var player: YTPlayerView!
    
    init(_frame: CGRect,
         _viewId: Int64,
         _params: [String: Any]?,
         _registrar: FlutterPluginRegistrar) {
        frame = _frame
        viewId = _viewId
        registrar = _registrar
        playerView = UIView(frame: frame)
        channel = FlutterMethodChannel(
            name: "youtuyer",
            binaryMessenger: registrar.messenger()
        )
        super.init()
        self.initPlayer()
        /*channel.setMethodCallHandler { [weak self] (call, result) in
            guard let `self` = self else { return }
            `self`.handle(call, result: result)
        }*/
    }
    
    func view() -> UIView {
        return playerView
    }
    
    func initPlayer(){
        
        self.playerView.backgroundColor = .yellow
        self.player = YTPlayerView()
        self.playerView.addSubview(self.player)
        
        self.player.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        let options = [
            "origin" : "https://www.youtube.com"
        ]
        
        player.load(withVideoId: "2kHnFYzYC-0", playerVars: options)
        //player.cueVideo(byId: "2kHnFYzYC-0", startSeconds: 0.0, suggestedQuality: .medium)
        
    }
    
}

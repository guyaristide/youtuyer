//
//  YoutuyerFactory.swift
//  Pods-Runner
//
//  Created by Agnaramon Boris-Carnot on 23/07/2019.
//

import Foundation
import Flutter

class YoutuyerFactory: NSObject, FlutterPlatformViewFactory {
    let registrar: FlutterPluginRegistrar
    
    init(_registrar: FlutterPluginRegistrar) {
        registrar = _registrar
        super.init()
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return YoutuyerView(_frame: frame,
                                  _viewId: viewId,
                                  _params: args as? Dictionary<String, Any> ?? nil,
                                  _registrar: registrar)
    }
}

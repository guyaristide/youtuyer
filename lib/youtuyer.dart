import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class YoutuyerWidget extends StatefulWidget {
  @override
  _YoutuyerWidgetState createState() => _YoutuyerWidgetState();
}

class _YoutuyerWidgetState extends State<YoutuyerWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildVideo();
  }

  Widget _buildVideo() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'youtuyer',
        /*onPlatformViewCreated: _onPlatformViewCreated,
        creationParams: <String, dynamic>{
          "scale_mode": widget.scaleMode.index,
          "videoId": widget.params.videoId,
          "showUI": widget.params.showUI,
          "startSeconds": widget.params.startSeconds
        },*/
        creationParamsCodec: StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'youtuyer',
        /*onPlatformViewCreated: _onPlatformViewCreated,
        creationParams: <String, dynamic>{
          "videoId": widget.params.videoId,
          "showUI": widget.params.showUI,
          "startSeconds": widget.params.startSeconds
        },*/
        creationParamsCodec: StandardMessageCodec(),
      );
    }
    return Text(
        '$defaultTargetPlatform is not yet supported by the text_view plugin');
  }

}

/*class Youtuyer {
  static const MethodChannel _channel =
      const MethodChannel('youtuyer');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}*/

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtuyer/flutter_youtube_view_controller.dart';
import 'package:youtuyer/you_tube_player_listener.dart';
import 'package:youtuyer/youtube_param.dart';

typedef void FlutterYoutubeViewCreatedCallback(FlutterYoutubeViewController controller);

class YoutuyerWidget extends StatefulWidget {
  const YoutuyerWidget({
    Key key,
    this.onViewCreated,
    this.listener,
    this.scaleMode = YoutubeScaleMode.none,
    this.params = const YoutubeParam()
  }) : super(key: key);

  final FlutterYoutubeViewCreatedCallback onViewCreated;
  final YouTubePlayerListener listener;
  final YoutubeParam params;
  final YoutubeScaleMode scaleMode;

  @override
  _YoutuyerWidgetState createState() => _YoutuyerWidgetState();
}

enum YoutubeScaleMode { none, fitWidth, fitHeight }

class _YoutuyerWidgetState extends State<YoutuyerWidget> {

  FlutterYoutubeViewController _controller;

  @override
  Widget build(BuildContext context) {
    return _buildVideo();
  }

  void _onPlatformViewCreated(int id) {
    _controller = new FlutterYoutubeViewController.of(id, widget.listener);
    if (widget.onViewCreated != null) {
      widget.onViewCreated(_controller);
    }
    _initialization();
  }

  void _initialization() async {
    _controller.initialization();
  }

  Widget _buildVideo() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'youtuyer',
        onPlatformViewCreated: _onPlatformViewCreated,
        creationParams: <String, dynamic>{
          "scale_mode": widget.scaleMode.index,
          "videoId": widget.params.videoId,
          "showUI": widget.params.showUI,
          "startSeconds": widget.params.startSeconds
        },
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

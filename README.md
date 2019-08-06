# youtuyer

# :pray: __Highly inspired by [flutter_youtube_view](https://github.com/hoanglm4/flutter_youtube_view)__ :pray:

This plugin provide a Youtube player for Android and iOS. We've encoutered problems using other flutter plugins : iOS integration doesn't work or take long time to load before playing videos. 

This plugin using:

* Android __(same library work well)__: https://github.com/PierfrancescoSoffritti/android-youtube-player 
* iOS: https://github.com/youtube/youtube-ios-player-helper

## Usage

* Add to your `pubspec.yaml` file:

```yml
youtuyer:
    git:
      url: git://github.com/guyaristide/youtuyer.git
```

* Import in dart code

```dart
import 'package:youtuyer/youtuyer.dart';
```

Currently apps need to opt-in for the UIViews embedding preview on iOS by adding a boolean property to the Info.plist (key=io.flutter.embedded_views_preview value=YES).

* Using Youtuyer
         
```dart
Container(
    child: YoutuyerWidget(
          onViewCreated: _onYoutubeCreated,
          listener: this,
          params: YoutubeParam(
              videoId: 'gcj2RUWQZ60', showUI: true, startSeconds: 5 * 60.0),
    ),
)
```
## Features

### Calls during playback

- play()
- pause()
- loadOrCueVideo()
- seekTo()
- setVolume() only Android
- mute()
- unMute()

### PLAYER callback

```dart
  void onReady();

  void onStateChange(String state);

  void onError(String error);

  void onVideoDuration(double duration);

  void onCurrentSecond(double second);
```

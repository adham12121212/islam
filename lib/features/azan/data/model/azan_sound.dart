import 'package:audioplayers/audioplayers.dart';

class AzanPlayer {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playAzan() async {
    await _player.play(AssetSource('sounds/azan.mp3' ));
  }

  static Future<void> stopAzan() async {
    await _player.stop();
  }
}

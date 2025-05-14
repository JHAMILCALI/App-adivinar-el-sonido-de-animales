import 'package:audioplayers/audioplayers.dart';

class SoundPlayer {
  final AudioPlayer _player = AudioPlayer();

  Future<void> play(String assetPath) async {
    await _player.play(AssetSource(assetPath));
  }
}

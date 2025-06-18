import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class CustomAudio extends StatefulWidget {
  final String urlAudio;
  const CustomAudio({super.key, required this.urlAudio});

  @override
  State<CustomAudio> createState() => _CustomAudioState();
}

class _CustomAudioState extends State<CustomAudio> {
  final player = AudioPlayer();

  String formatDuration(Duration duration) {
    final minutos = duration.inMinutes.remainder(60);
    final segundos = duration.inSeconds.remainder(60);
    return "${minutos.toString().padLeft(2, '0')}:${segundos.toString().padLeft(2, '0')}";
  }

  void handlePause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  void handleSeek(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }

  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  @override
  void initState() {
    super.initState();
    player.setUrl(widget.urlAudio);
    player.positionStream.listen((p) {
      setState(() => position = p);
    });

    player.durationStream.listen((d) {
      setState(() {
        duration = d!;
      });
    });

    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          position = Duration.zero;
        });
        player.pause();
        player.seek(position);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(formatDuration(position)),
          Slider(
            thumbColor: Color(0xfff56E0f),
            min: 0.0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: handleSeek,
          ),
          Text(formatDuration(duration)),
          IconButton(
            onPressed: handlePause,
            icon: Icon(
              player.playing ? Icons.pause : Icons.play_arrow,
              color: Color(0xfff56E0f),
            ),
          ),
        ],
      ),
    );
  }
}

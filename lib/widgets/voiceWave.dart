import 'package:flutter/material.dart';
import 'package:waveform_flutter/waveform_flutter.dart';

class VoiceWave extends StatefulWidget {
  const VoiceWave({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VoiceWaveState createState() => _VoiceWaveState();
}

class _VoiceWaveState extends State<VoiceWave> {
  final Stream<Amplitude> _amplitudeStream = createRandomAmplitudeStream();

  @override
  Widget build(BuildContext context) => AnimatedWaveList(
    stream: _amplitudeStream,
    barBuilder: (animation, amplitude) => WaveFormBar(
      animation: animation,
      amplitude: amplitude,
      color: Colors.red,
      maxHeight: 10,
    ),
  );
}

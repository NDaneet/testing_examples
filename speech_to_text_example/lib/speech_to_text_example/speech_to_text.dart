import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: const Text(
        "Click",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (context) {
            return const AlertDisplay();
          },
        );
      },
    );
  }
}

class AlertDisplay extends StatefulWidget {
  const AlertDisplay({Key? key}) : super(key: key);

  @override
  State<AlertDisplay> createState() => _AlertDisplayState();
}

class _AlertDisplayState extends State<AlertDisplay> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = "";

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(debugLogging: true);
    setState(() {});
  }

  void _startListening() async {
    _lastWords = "";
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(
      () {
        _lastWords = result.recognizedWords;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 10,
        height: MediaQuery.of(context).size.height / 2.5,
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Speech To Text",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              child: _speechToText.isNotListening
                  ? const Icon(
                      Icons.mic,
                      size: 50,
                    )
                  : const Icon(
                      Icons.mic_off,
                      size: 50,
                    ),
              onPressed: _speechToText.isNotListening
                  ? _startListening
                  : _stopListening,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _speechToText.isListening
                  ? _lastWords
                  : _speechEnabled
                      ? "Try saying something"
                      : "Didn't catch that. Try speaking again.",
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            _speechToText.isListening
                ? const SizedBox()
                : OutlinedButton(
                    child: const Text("Try Again"),
                    style: OutlinedButton.styleFrom(
                      onSurface: Colors.blue,
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    onPressed: () {}),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

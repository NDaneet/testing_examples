import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:speech_to_text/speech_to_text.dart";
import "package:speech_to_text/speech_to_text_provider.dart";
import 'package:speech_to_text_example/speech_to_text_provider_example/speech_screen.dart';

class SpeechToTextInitializer extends StatefulWidget {
  const SpeechToTextInitializer({Key? key}) : super(key: key);

  @override
  State<SpeechToTextInitializer> createState() =>
      _SpeechToTextInitializerState();
}

class _SpeechToTextInitializerState extends State<SpeechToTextInitializer> {
  final SpeechToText speech = SpeechToText();
  late SpeechToTextProvider speechProvider;

  @override
  void initState() {
    super.initState();
    speechProvider = SpeechToTextProvider(speech);
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    await speechProvider.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SpeechToTextProvider>.value(
      value: speechProvider,
      child: MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Speech To Text Provider Example"),
            ),
            body: const Center(child: FirstScreen()),
        ),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var speechProvider = Provider.of<SpeechToTextProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 150,
              height: 30,
              child: Row(
                children: [
                  const Text(
                    "Last Word(s): ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    speechProvider.lastResult?.recognizedWords ??
                        "No Result Yet",
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        OutlinedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MicrophoneScreen(),
            ),
          ),
          child: const Text(
            "Click",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        )
      ],
    );
  }
}

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:speech_to_text/speech_to_text_provider.dart";

class MicrophoneScreen extends StatelessWidget {
  const MicrophoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var speechProvider = Provider.of<SpeechToTextProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width - 10,
            height: MediaQuery.of(context).size.height / 2.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Speech Provider",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  child: speechProvider.isNotListening
                      ? const Icon(
                          Icons.mic,
                          size: 50,
                        )
                      : const Icon(
                          Icons.mic_off,
                          size: 50,
                        ),
                  onPressed: speechProvider.isNotListening
                      ? speechProvider.listen
                      : speechProvider.stop,
                ),
                const SizedBox(
                  height: 10,
                ),
                speechProvider.isListening
                    ? Text(speechProvider.lastResult?.recognizedWords ?? "")
                    : const Text(
                        "Try saying something",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                speechProvider.isListening
                    ? const SizedBox()
                    : OutlinedButton(
                        child: const Text("Try Again"),
                        style: OutlinedButton.styleFrom(
                          onSurface: Colors.blue,
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                        onPressed: () {},
                      ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

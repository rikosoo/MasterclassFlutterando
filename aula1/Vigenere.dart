import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    title: 'Cifra de Vigenère',
    home: VigenereApp(),
  ));
}

class VigenereApp extends StatefulWidget {
  @override
  _VigenereAppState createState() => _VigenereAppState();
}

class _VigenereAppState extends State<VigenereApp> {
  TextEditingController textController = TextEditingController();
  TextEditingController keyController = TextEditingController();
  String encodedText = '';
  String decodedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cifra de Vigenère'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Texto',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  String text = textController.text;
                  String key = generateRandomKey(text.length);
                  keyController.text = key;
                  encodedText = encode(text, key);
                  decodedText = decode(encodedText, key);
                });
              },
              child: const Text('Criptografar/Descriptografar'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: keyController,
              decoration: const InputDecoration(
                labelText: 'Chave',
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Texto Criptografado:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(encodedText),
            const SizedBox(height: 16.0),
            Text(
              'Texto Descriptografado:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(decodedText),
          ],
        ),
      ),
    );
  }

  String generateRandomKey(int length) {
    Random random = Random();
    String key = '';
    for (int i = 0; i < length; i++) {
      int randomCharCode = random.nextInt(26) + 65;
      key += String.fromCharCode(randomCharCode);
    }
    return key;
  }

  String encode(String text, String key) {
    String encodedText = '';
    text = text.toUpperCase();
    key = key.toUpperCase();
    int textLength = text.length;
    int keyLength = key.length;

    for (int i = 0; i < textLength; i++) {
      if (text.codeUnitAt(i) < 65 || text.codeUnitAt(i) > 90) {
        encodedText += text[i];
        continue;
      }
      int encodedCharCode =
          ((text.codeUnitAt(i) + key.codeUnitAt(i % keyLength)) % 26) + 65;
      encodedText += String.fromCharCode(encodedCharCode);
    }

    return encodedText;
  }

  String decode(String encodedText, String key) {
    String decodedText = '';
    encodedText = encodedText.toUpperCase();
    key = key.toUpperCase();
    int encodedTextLength = encodedText.length;
    int keyLength = key.length;

    for (int i = 0; i < encodedTextLength; i++) {
      if (encodedText.codeUnitAt(i) < 65 || encodedText.codeUnitAt(i) > 90) {
        decodedText += encodedText[i];
        continue;
      }
      int decodedCharCode = (((encodedText.codeUnitAt(i) - key.codeUnitAt(i % keyLength)) + 26) % 26) + 65;
      decodedText += String.fromCharCode(decodedCharCode);
    }

    return decodedText;
  }
}

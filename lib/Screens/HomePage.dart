import 'package:capture/Screens/EmotionsPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              
              onPressed: () {
                // Backend image viewing page (placeholder)
              },
              child: const Text("View Images from Backend"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EmotionPage()),
                );
              },
              child: const Text("Capture Selfie"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:capture/Repositories/authrepo.dart';
import 'package:capture/Screens/CameraPage.dart';
import 'package:capture/Screens/Login.dart';
import 'package:flutter/material.dart';

class EmotionPage extends StatelessWidget {
  const EmotionPage({super.key});

  final List<String> emotions = const [
    "Happy",
    "Sad",
    "Angry",
    "Surprised",
    "Neutral",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await AuthRepository().logout();

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => LoginPage()),
                (route) => false,
              );
            },

            icon: Icon(Icons.logout),
          ),
        ],
        centerTitle: true,
        title: const Text(
          "Capture Emotions",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView.builder(
        itemCount: emotions.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: ListTile(
              title: Text(
                emotions[index],
                style: const TextStyle(fontSize: 22),
              ),
              trailing: const Icon(Icons.arrow_forward, size: 26),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CameraPage(emotion: emotions[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

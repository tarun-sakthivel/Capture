import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UploadRepository {
  Future<void> uploadEmotionImage({
    required String emotion,
    required File image,
  }) async {

    final prefs = await SharedPreferences.getInstance();
    print("--- Upload Repo Called ---");
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception("Token not found. Please login again.");
    }
    final url = dotenv.env['url'];
   
    final uri = Uri.parse("$url/upload");
    print("UPLOAD URL: $uri");

    // 3️⃣ Multipart Request
    final request = http.MultipartRequest('POST', uri);

    // 4️⃣ Authorization Header
    request.headers['Authorization'] = 'Bearer $token';

    // 5️⃣ Body (as per Postman)
    request.fields['emotion'] = emotion;

    request.files.add(
      await http.MultipartFile.fromPath(
        'image', // MUST match Postman key
        image.path,
      ),
    );
    print("REQUEST FIELDS: ${request.fields}");
    // 6️⃣ Send request
    final response = await request.send();
    print("RESPONSE STATUS: ${response.statusCode}");

    if (response.statusCode != 200) {
      throw Exception("Upload failed");
    }
  }
}

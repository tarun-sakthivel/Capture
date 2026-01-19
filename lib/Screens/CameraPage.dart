import 'dart:io';
import 'package:capture/Bloc/uploadBloc/upload_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  final String emotion;
  const CameraPage({super.key, required this.emotion});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? imageFile;
  final ImagePicker picker = ImagePicker();

  Future<void> captureSelfie() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  Future<void> uploadImage() async {
    if (imageFile == null) return;

    // var request = http.MultipartRequest(
    //   'POST',
    //   Uri.parse('https://your-backend-api/upload'),
    // );

    // request.fields['emotion'] = widget.emotion;
    // request.files.add(
    //   await http.MultipartFile.fromPath('image', imageFile!.path),
    // );

    // await request.send();

    context.read<UploadBlocBloc>().add(
      SubmitEmotionUpload(emotion: widget.emotion, image: imageFile!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Emotion: ${widget.emotion}")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (imageFile != null) Image.file(imageFile!),
          if (imageFile == null)
            Image.asset('Assets/Images/${widget.emotion}.jpg', height: 300),
          const SizedBox(height: 20),

          BlocListener<UploadBlocBloc, UploadBlocState>(
            listener: (context, state) {
              if (state is UploadSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Image uploaded successfully"),
                    backgroundColor: Colors.green,
                  ),
                );
              }

              if (state is UploadFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Row(
              mainAxisAlignment: imageFile != null
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  onPressed: captureSelfie,
                  child: Text(
                    imageFile == null ? "Capture Selfie" : "Retake Selfie",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                if (imageFile != null)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    onPressed: uploadImage,
                    child: const Text(
                      "Send to Backend",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

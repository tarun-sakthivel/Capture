part of 'upload_bloc_bloc.dart';

@immutable
sealed class UploadBlocEvent {}

class SubmitEmotionUpload extends UploadBlocEvent {
  final String emotion;
  final File image;

  SubmitEmotionUpload({required this.emotion, required this.image});
}

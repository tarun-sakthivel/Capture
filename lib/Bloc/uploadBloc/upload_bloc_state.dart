part of 'upload_bloc_bloc.dart';

@immutable
sealed class UploadBlocState {}

class UploadInitial extends UploadBlocState {}

class UploadLoading extends UploadBlocState {}

class UploadSuccess extends UploadBlocState {}

class UploadFailure extends UploadBlocState {
  final String error;
  UploadFailure(this.error);
}
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:capture/Repositories/uploadrepo.dart';
import 'package:meta/meta.dart';

part 'upload_bloc_event.dart';
part 'upload_bloc_state.dart';

class UploadBlocBloc extends Bloc<UploadBlocEvent, UploadBlocState> {
  final UploadRepository repository;

  UploadBlocBloc(this.repository) : super(UploadInitial()) {
    on<SubmitEmotionUpload>(_onSubmitUpload);
  }

  Future<void> _onSubmitUpload(
    SubmitEmotionUpload event,
    Emitter<UploadBlocState> emit,
  ) async {
    emit(UploadLoading());
    try {
      await repository.uploadEmotionImage(
        emotion: event.emotion,
        image: event.image,
      );
      emit(UploadSuccess());
    } catch (e) {
      emit(UploadFailure(e.toString()));
    }
  }
}

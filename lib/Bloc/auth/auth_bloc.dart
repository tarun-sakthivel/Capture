import 'package:bloc/bloc.dart';
import 'package:capture/Repositories/authrepo.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(LoginInitial()) {
    on<SubmitLogin>(_onSubmitLogin);
  }
  Future<void> _onSubmitLogin(
    SubmitLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoginLoading());
    try {
      await repository.login(username: event.username, phone: event.phone);
      final token = await repository.getToken();
      emit(LoginSuccess(token));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}

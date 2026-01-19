import 'package:capture/Bloc/auth/auth_bloc.dart';
import 'package:capture/Bloc/uploadBloc/upload_bloc_bloc.dart';
import 'package:capture/Repositories/authrepo.dart';
import 'package:capture/Repositories/uploadrepo.dart';
import 'package:capture/Screens/EmotionsPage.dart';
import 'package:capture/Screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc(AuthRepository())),
        BlocProvider<UploadBlocBloc>(
          create: (_) => UploadBlocBloc(UploadRepository()),
        ),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage()),
    );
  }
}

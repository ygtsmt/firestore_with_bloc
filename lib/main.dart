import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_with_bloc/bloc/todo_bloc.dart';
import 'package:firestore_with_bloc/firebase_options.dart';
import 'package:firestore_with_bloc/home.dart';
import 'package:firestore_with_bloc/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<TodoBloc>(
              create: (context) => TodoBloc(FirestoreService()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.blueAccent
              )
            ),
            home: const HomeView(),
          )
        );
  }
}
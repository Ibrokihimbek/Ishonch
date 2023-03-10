import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishonch/app/app.dart';
import 'package:ishonch/app/app_bloc_observer.dart';
import 'package:ishonch/data/storage_repository/storage_repository.dart';
import 'package:ishonch/service/get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic("ishonch_news");
  setup();
  StorageRepository.getInstance();
  Bloc.observer = AppBlocObserver();
  runApp(App());
}

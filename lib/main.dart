import 'dart:async';
import 'dart:developer';

import 'package:news_app/config/app_bloc_observer.dart';
import 'package:news_app/core/di/dependency_injection.dart';
import 'package:news_app/cubit/navbar_cubit.dart';
// import 'package:news_app/home/bloc/news_bloc.dart';
import 'package:news_app/home/data/repository/news_repository.dart';
import 'package:news_app/settings/cubit/theme_cubit.dart';
import 'package:news_app/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runZonedGuarded(() async {
    BlocOverrides.runZoned(
      () async {
        setup();
        runApp(const MyApp());
      },
      blocObserver: AppBlocObserver(),
    );
  }, (error, stackTrace) async {
    log('runzoned error');
    log(error.runtimeType.toString());
    log(error.toString(), stackTrace: stackTrace);
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => NewsRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          ),
          BlocProvider<NavbarCubit>(
            create: (context) => NavbarCubit(),
          ),
          // BlocProvider(
          //   create: (context) => NewsBloc(
          //     RepositoryProvider.of<NewsRepository>(context),
          //   )..add(LoadNewsEvent()),
          // ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: state.selectedTheme,
              home: const BottomNavBar(),
            );
          },
        ),
      ),
    );
  }
}

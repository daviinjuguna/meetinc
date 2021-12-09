import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meetinc/bloc/contact/contact_bloc.dart';
import 'package:meetinc/bloc/theme/theme_cubit.dart';
import 'package:meetinc/utils/bloc_observer.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/add_meeting/add_meeting_bloc.dart';
import 'bloc/meeting/meeting_bloc.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: _storage,
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (create) => ThemeCubit()),
        BlocProvider(create: (create) => ContactBloc()),
        BlocProvider(create: (create) => MeetingBloc()),
        BlocProvider(create: (create) => AddMeetingBloc()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'MeetInc',
            debugShowCheckedModeBanner: false,
            theme: context.watch<ThemeCubit>().lightTheme?.copyWith(
                    appBarTheme: const AppBarTheme(
                  centerTitle: true,
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                  titleTextStyle:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  elevation: 0,
                )),
            darkTheme: context.watch<ThemeCubit>().darkTheme?.copyWith(
                    appBarTheme: const AppBarTheme(
                  centerTitle: true,
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                  titleTextStyle:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  elevation: 0,
                )),
            themeMode: context.watch<ThemeCubit>().themeMode,
            highContrastTheme: context.watch<ThemeCubit>().lightTheme?.copyWith(
                    appBarTheme: const AppBarTheme(
                  centerTitle: true,
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                  titleTextStyle:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  elevation: 0,
                )),
            highContrastDarkTheme:
                context.watch<ThemeCubit>().darkTheme?.copyWith(
                        appBarTheme: const AppBarTheme(
                      centerTitle: true,
                      systemOverlayStyle: SystemUiOverlayStyle.dark,
                      titleTextStyle:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                      elevation: 0,
                    )),
            onGenerateRoute: Routes.generateRoute,
            onUnknownRoute: Routes.errorRoute,
          );
        },
      ),
    );
  }
}

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ipaidmoney/config/theme.dart';
import 'package:ipaidmoney/models/init.dart';

Future initializeAll() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: DarkTheme.scaffoldBackgroundColor,
    ),
  );
  await LocalDB.initDB();
}

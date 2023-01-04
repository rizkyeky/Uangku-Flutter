import 'dart:async';

// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart' hide TabPage;
import 'package:uangku/page/_page.dart';
import 'package:uangku/provider/_provider.dart';
import 'package:uangku/service/_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:uangku/utils/_utils.dart';

part 'main.dart';
part 'router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key, 
    required this.details,
  });

  final String details;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: PrimaryColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(details,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: PrimaryColors.base,
            ),
          )
        ),
      ),
    );
  }
}
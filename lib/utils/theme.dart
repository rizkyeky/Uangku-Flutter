part of _utils;

class PrimaryColors {
  const PrimaryColors._();

  static const Color v900 = Color(0xFF005283);
  static const Color v800 = Color(0xFF0072A4);
  static const Color v700 = Color(0xFF0083B8);
  static const Color base = Color(0xFF0097CA);
  static const Color v500 = Color(0xFF00A4D7);
  static const Color v400 = Color(0xFF00B2DC);
  static const Color v300 = Color(0xFF09C0E0);
  static const Color v200 = Color(0xFF66D3E9);
  static const Color v100 = Color(0xFFA5E5F2);

  static const Color white = Color(0xFFFFFFFF);
  static const Color scaffoldBackground = Color(0xFFF2F2F7);
}

class TextColors {
  const TextColors._();

  static const base = Color(0xFF093949);
  static const v800 = Color(0xFF313131);
  static const v700 = Color(0xFF4F4F4F);
  static const v600 = Color(0xFF626262);
  static const v500 = Color(0xFF898989);
  static const v400 = Color(0xFFAAAAAA);
  static const v300 = Color(0xFFCFCFCF);
  static const v200 = Color(0xFFE1E1E1);
  static const v100 = Color(0xFFEEEEEE);

  static dynamicBaseColor(BuildContext context) => CupertinoDynamicColor.resolve(
    const CupertinoDynamicColor.withBrightness(
      color: base, 
      darkColor: v200,
    ), context
  );
}

class SemanticColors {
  const SemanticColors._();

  static const green = CupertinoColors.activeGreen;
  static const orange = CupertinoColors.activeOrange;
  static const error = CupertinoColors.destructiveRed;
}

class TextTheme {
  const TextTheme._();
  
  static CupertinoTextThemeData textThemeData(BuildContext context) {
    return CupertinoTextThemeData(
      textStyle: base.copyWith(
        color: TextColors.dynamicBaseColor(context)
      ),
      primaryColor: PrimaryColors.base,
    );
  }

  static const TextStyle base = TextStyle(
    fontFamily: 'Inter',
  );

  static final TextStyle h1 = TextTheme.base.copyWith(
    fontSize: 48.s,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle h2 = TextTheme.base.copyWith(
    fontSize: 40.s,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle h3 = TextTheme.base.copyWith(
    fontSize: 32.s,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle h4 = TextTheme.base.copyWith(
    fontSize: 20.s,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle body = TextTheme.base.copyWith(
    fontSize: 16.s,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle primaryButton = TextTheme.base.copyWith(
    fontSize: 14.s,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle tileButton = TextTheme.base.copyWith(
    fontSize: 14.s,
    fontWeight: FontWeight.w400,
    color: PrimaryColors.base,
  );
  static final TextStyle bodyMd = TextTheme.base.copyWith(
    fontSize: 16.s,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle bodySm = TextTheme.base.copyWith(
    fontSize: 14.s,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle caption = TextTheme.base.copyWith(
    fontSize: 12.s,
    fontWeight: FontWeight.w400,
    color: TextColors.v500.withOpacity(0.6),
  );
  static final TextStyle helper = TextTheme.base.copyWith(
    fontSize: 10.s,
    fontWeight: FontWeight.w500,
  );
}



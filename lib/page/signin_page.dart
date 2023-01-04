part of _page;

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    Log().build('SignIn page');
    
    final formKey = GlobalKey<FormState>();
    Localizations.localeOf(context);
    
    final authProvider = context.read<AuthProvider>();
    context.read<BrightnessProvider>()
      .brightnessFromPlatform = MediaQuery.of(context).platformBrightness;

    final foo = dotenv.env['ESCAPED_DOLLAR_SIGN'];
    print(foo);

    String? email;
    String? password;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      child: SingleChildScrollView(
        padding: GapPadding.all16S,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap.h32,
              Gap.h32,
              Gap.h32,
              Text('signin'.i18n(),
                style: TextTheme.h2.copyWith(
                  color: TextColors.dynamicBaseColor(context),
                ),
              ),
              Gap.h32,
              Gap.h16,
              CupertinoFormSection(
                children: [
                  RegisterTextField(
                    placeholder: 'Email',
                    onChanged: (val) => email = val,
                    keyboardType: TextInputType.emailAddress,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Email is required'),  
                      EmailValidator(errorText: 'Enter a valid email address')  
                    ])
                  ),
                  RegisterTextField.password(
                    placeholder: 'Password',
                    onChanged: (val) => password = val,
                    validator: MultiValidator([  
                      RequiredValidator(errorText: 'Password is required'),  
                      MinLengthValidator(6, errorText: 'Password must be at least 6 digits long'),  
                    ]),
                  ),
                ]
              ),
              Gap.h32,
              Button.filled(
                onPressed: () async {
                  formKey.currentState?.save();
                  final isValid = formKey.currentState?.validate();
                  if (isValid == true && email != null && password != null) {
                    await authProvider.signIn(email!, password!)
                      .then((value) {
                        Log().success('SignIn');
                      })
                      .onError((error, stackTrace) {
                        SnackBar.show(context, error.toString(), autoDismiss: true);
                      });
                  }
                },
                child: Text('signin'.i18n()),
              ),
              Gap.h32,
              Button.texted(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Routemaster.of(context).push('signup');
                },
                child: Text('signup'.i18n(),
                  style: TextTheme.caption.copyWith(
                    color: PrimaryColors.base
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class RegisterTextField extends StatelessWidget {

  const RegisterTextField({
    Key? key,
    required this.placeholder,
    this.validator,
    this.onChanged,
    this.keyboardType,
  }) : isPassword = false, super(key: key);
  
  const RegisterTextField.password({
    Key? key,
    required this.placeholder,
    this.validator,
    this.onChanged,
    this.keyboardType,
  }) : isPassword = true, super(key: key);

  final bool isPassword;
  final String placeholder;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.brightnessOf(context);
    return isPassword ? StatefulValueBuilder<bool>(
      initialValue: true,
      builder: (context, value, setValue) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              cupertinoTextField(brightness, value),
              Button.texted(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                onPressed: () {
                  setValue(!(value ?? true));
                },
                child: Icon(
                  (value ?? true) 
                  ? CupertinoIcons.eye_slash 
                  : CupertinoIcons.eye
                )
              ),
            ],
          ),
        );
      }
    ) : Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: cupertinoTextField(brightness),
    );
  }

  Widget cupertinoTextField(Brightness brightness, [bool? obscureText]) {
    // final isDark = brightness == Brightness.dark;
    return CupertinoTextFormFieldRow(
      placeholder: placeholder,
      onChanged: onChanged,
      keyboardType: isPassword 
        ? TextInputType.visiblePassword 
        : keyboardType ?? TextInputType.text,
      textInputAction: TextInputAction.done,
      obscureText: isPassword ? (obscureText ?? true) : false,
      padding: EdgeInsets.zero,
      scrollPadding: EdgeInsets.zero,
      validator: validator,
      // decoration: BoxDecoration(
      //   color: isDark ? CupertinoColors.systemBackground.withOpacity(0.16)
      //     : CupertinoColors.secondarySystemBackground,
      //   borderRadius: BorderRadius.circular(4),
      // ),
    );
  }
}
part of _page;

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    Log().build('SignUp page');
    Localizations.localeOf(context);
    String? name;
    String? email;
    String? password;
    final formKey = GlobalKey<FormState>();
    final authProvider = context.read<AuthProvider>();
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
              Text('signup'.i18n(),
                style: TextTheme.h2.copyWith(
                  color: TextColors.dynamicBaseColor(context),
                ),
              ),
              Gap.h32,
              Gap.h16,
              RegisterTextField(
                placeholder: 'Email',
                onChanged: (val) => email = val,
                keyboardType: TextInputType.emailAddress,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Email is required'),  
                  EmailValidator(errorText: 'Enter a valid email address')  
                ])
              ),
              Gap.h16,
              RegisterTextField(
                placeholder: 'name'.i18n(),
                onChanged: (val) => name = val,
                validator: RequiredValidator(errorText: '${'name'.i18n()} is required')
              ),
              Gap.h16,
              RegisterTextField.password(
                placeholder: 'Password',
                onChanged: (val) => password = val,
                validator: MultiValidator([  
                  RequiredValidator(errorText: 'Password is required'),  
                  MinLengthValidator(6, errorText: 'Password must be at least 6 digits long'),  
                ]),
              ),
              Gap.h16,
              RegisterTextField.password(
                placeholder: '${'confirm'.i18n()} Password',
                validator: (val) => MatchValidator(errorText: 'Password do not match')
                  .validateMatch(val ?? '.', password ?? '-'),
              ),
              Gap.h32,
              Button.filled(
                onPressed: () async {
                  formKey.currentState?.save();
                  final isValid = formKey.currentState?.validate();
                  if (isValid == true && email != null && password != null) {
                    await authProvider.signUp(
                      email: email!,
                      password: password!,
                      name: name!,
                    )
                      .then((value) {
                        Log().success('SignUp');
                      })
                      .onError((error, stackTrace) {
                        SnackBar.show(context, error.toString(), autoDismiss: true);
                      });
                  }
                },
                child: Text('signup'.i18n()),
              ),
            ],
          ),
        ),
      )
    );
  }
}
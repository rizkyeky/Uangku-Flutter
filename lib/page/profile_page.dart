part of _page;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightnessProvider = context.read<BrightnessProvider>();
    final authProvider = context.read<AuthProvider>();
    final profile = context.select<int, Profile?>((value) => null);
    Log().build('Profile page');
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('profile'.i18n()),
      ),
      child: SingleChildScrollView(
        padding: GapPadding.all16S,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Gap.h32,
            Gap.h32,
            Gap.h32,
            ValueFutureBuilder<Profile?>(
              future: authProvider.getProfile(),
              onValueBuilder: (context, value) {
                print(value?.toJson());
                return Text(authProvider.user?.email ?? 'no email',
                  style: TextTheme.bodySm.copyWith(
                    color: TextColors.dynamicBaseColor(context),
                  ),
                );
              }
            ),
            Gap.h16,
            Text(authProvider.user?.email ?? 'no email',
              style: TextTheme.body.copyWith(
                color: TextColors.dynamicBaseColor(context),
              ),
            ),
            Gap.h16,
            Button.outlined(
              child: Text('Light'),
              onPressed: () {
                brightnessProvider.setToLight();
              },
            ),
            Gap.h16,
            Button.outlined(
              child: Text('Dark'),
              onPressed: () {
                brightnessProvider.setToDark();
              },
            ),
            Gap.h16,
            Button.outlined(
              child: Text('System'),
              onPressed: () {
                brightnessProvider.setToDefaultSystem();
              },
            ),
            Gap.h32,
            Button.outlined(
              color: SemanticColors.error,
              child: Text('signout'.i18n()),
              onPressed: () async {
                await authProvider.signOut()
                  .then((value) {
                    Log().success('SignOut');
                  })
                  .onError((error, stackTrace) {
                    SnackBar.show(context, error.toString(), autoDismiss: true);
                  });
              },
            ),
          ],
        ),
      )
    );
  }
}
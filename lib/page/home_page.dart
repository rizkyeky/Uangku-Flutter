part of _page;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Log().build('Home page');
    Localizations.localeOf(context);
    
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('home'.i18n()),
        trailing: Button.texted(
          padding: EdgeInsets.zero,
          onPressed: () {
            
          },
          child: const Icon(CupertinoIcons.add),
        )
      ),
      child: SingleChildScrollView(
        padding: GapPadding.all16S,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Gap.h32,
            Gap.h32,
            Gap.h32,
            Text('home'.i18n()),
            Gap.h16,
            // Button.texted(
            //   child: Text('transactions'.i18n()),
            //   onPressed: () {
            //     Routemaster.of(context).push('/trans');
            //   },
            // ),
            // Gap.h16,
            // Button.outlined(
            //   child: Text('profile'.i18n()),
            //   onPressed: () {
            //     Routemaster.of(context).push('/profile');
            //   },
            // ),
            // Gap.h16,
            // Button.tinted(
            //   child: Text('Locale'),
            //   onPressed: () {
            //     final localeProvider = context.read<LocalizationProvider>();
            //     localeProvider.changeLangTo();
            //   },
            // ),
          ],
        ),
      )
    );
  }
}
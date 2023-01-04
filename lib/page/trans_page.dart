part of _page;

class TransPage extends StatelessWidget {
  const TransPage({super.key});

  @override
  Widget build(BuildContext context) {
    Log().build('Trans page');
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('transactions'.i18n()),
      ),
      child: const Center(
        child: Text('Trans Page',)
      )
    );
  }
}
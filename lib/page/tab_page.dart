part of _page;

class TabPage extends StatelessWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabPage = CupertinoTabPage.of(context);
    
    final brightness = CupertinoTheme.brightnessOf(context);
    Localizations.localeOf(context);
    
    final backgroundColor = brightness == Brightness.dark
      ? CupertinoColors.black
      : PrimaryColors.white;
    
    Log().build('Tab page');

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageStackNavigator(stack: tabPage.stacks[tabPage.controller.index]),
        SimpleContainer(
          padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 0),
          color: backgroundColor,
          child: SafeArea(
            top: false,
            right: false,
            left: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonTab(
                  value: 0,
                  label: 'home'.i18n(),
                  iconData: CupertinoIcons.house,
                  activeIconData: CupertinoIcons.house_fill,
                  tabPage: tabPage,
                ),
                ButtonTab(
                  value: 1,
                  label: 'transactions'.i18n(),
                  iconData: CupertinoIcons.doc_text,
                  activeIconData: CupertinoIcons.doc_text_fill,
                  tabPage: tabPage,
                ),
                ButtonTab(
                  value: 2,
                  label: 'profile'.i18n(),
                  iconData: CupertinoIcons.person,
                  activeIconData: CupertinoIcons.person_fill,
                  tabPage: tabPage,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ButtonTab extends StatelessWidget {
  const ButtonTab({
    super.key,
    required this.value,
    required this.label,
    required this.tabPage,
    required this.iconData,
    required this.activeIconData,
    this.activeColor,
    this.inactiveColor,
  });

  final CupertinoTabPageState tabPage;
  final IconData iconData;
  final IconData activeIconData;
  final int value;
  final String label;
  final Color? inactiveColor;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final color1 = activeColor ?? CupertinoTheme.of(context).primaryColor;
    final color2 = inactiveColor ?? CupertinoColors.inactiveGray;
    final index = tabPage.controller.index;
    final color = value == index ? color1 : color2;
    final icon = value == index ? activeIconData : iconData;
          
    return Button.texted(
      padding: EdgeInsets.zero,
      onPressed: () {
        tabPage.controller.index = value;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 320),
            switchInCurve: Curves.easeInOutQuart,
            switchOutCurve: Curves.easeInOutQuart,
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: child,
            ),
            child: Icon(icon, 
              key: ValueKey(icon),
              color: color,
            )
          ),
          Gap.h8,
          Text(label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: value == index 
                ? FontWeight.w600 : FontWeight.w400,
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
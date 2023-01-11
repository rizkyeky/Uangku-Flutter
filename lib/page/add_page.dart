part of _page;

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    Log().build('Add page');
    String? name, desc;
    int? amount;
    String type = 'input';
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('add'.i18n()),
      ),
      child: Padding(
        padding: GapPadding.all16S,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Gap.h32,
            Gap.h16,
            StatefulBuilder(
              builder: (context, setState) {
                return CupertinoSlidingSegmentedControl<String>(
                  groupValue: type,
                  onValueChanged: (value) {
                    if (type != value) {
                      setState(() => type = value!);
                    }
                  },
                  children: {
                    'input': Text('Pemasukan',
                      style: TextStyle(
                        color: TextColors.dynamicBaseColor(context),
                      ),
                    ),
                    'output': Text('Pengeluaran',
                      style: TextStyle(
                        color: TextColors.dynamicBaseColor(context),
                      ),
                    ),
                  },
                );
              }
            ),
            Gap.h16,
            Text('Jumlah',
              style: TextTheme.caption.copyWith(
                color: TextColors.dynamicBaseColor(context)
              ),
            ),
            Gap.h8,
            CupertinoTextField(
              placeholder: 'Masukan jumlah',
              onChanged: (value) => amount = int.tryParse(value),
              inputFormatters: [
                CurrencyTextInputFormatter(
                  locale: 'id',
                  decimalDigits: 0,
                  symbol: ''
                ),
              ],
              keyboardType: TextInputType.number,
              padding: GapPadding.all16S,
              decoration: BoxDecoration(
                color: CupertinoColors.tertiarySystemFill,
                borderRadius: BorderRadius.circular(8),
              ),
              prefix: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Rp',
                  style: TextTheme.caption.copyWith(
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              )
            ),
            Gap.h16,
            Text('name'.i18n(),
              style: TextTheme.caption.copyWith(
                color: TextColors.dynamicBaseColor(context)
              ),
            ),
            Gap.h8,
            CupertinoTextField(
              placeholder: 'Masukan nama',
              onChanged: (value) => name = value,
              keyboardType: TextInputType.text,
              padding: GapPadding.all16S,
              decoration: BoxDecoration(
                color: CupertinoColors.tertiarySystemFill,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Gap.h16,
            Text('Deskripsi',
              style: TextTheme.caption.copyWith(
                color: TextColors.dynamicBaseColor(context)
              ),
            ),
            Gap.h8,
            CupertinoTextField(
              placeholder: 'Masukan deskripsi (opsional)',
              onChanged: (value) => desc = value,
              keyboardType: TextInputType.text,
              padding: GapPadding.all16S,
              decoration: BoxDecoration(
                color: CupertinoColors.tertiarySystemFill,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const Spacer(),
            Button.tinted(
              child: Text('add'.i18n()),
              onPressed: () {
                if (amount != null) {

                } else {
                  SnackBar.show(context, 'Jumlah belum diisi');
                }
              },
            ),
            Gap.h32,
          ],
        ),
      )
    );
  }
}
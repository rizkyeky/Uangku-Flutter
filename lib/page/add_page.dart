part of _page;

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    Log().build('Add page');
    final transactionProvider = context.read<TransactionProvider>();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('add'.i18n()),
      ),
      child: SingleChildScrollView(
        padding: GapPadding.all16S,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Gap.h32,
            Gap.h16,
            StatefulBuilder(
              builder: (context, setState) {
                return CupertinoSlidingSegmentedControl<String>(
                  groupValue: transactionProvider.type,
                  onValueChanged: (value) {
                    if (transactionProvider.type != value) {
                      setState(() => transactionProvider.type = value!);
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
              onChanged: (value) => 
                transactionProvider.amount = int.tryParse(value.replaceAll('.', '')),
              inputFormatters: [
                CurrencyTextInputFormatter(
                  locale: 'id',
                  decimalDigits: 0,
                  symbol: ''
                ),
              ],
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              padding: GapPadding.all16S,
              decoration: BoxDecoration(
                color: CupertinoColors.tertiarySystemFill,
                borderRadius: BorderRadius.circular(8),
              ),
              prefix: Padding(
                padding: const EdgeInsets.only(left: 16),
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
              onChanged: (value) => transactionProvider.name = value,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
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
              onChanged: (value) => transactionProvider.desc = value,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              padding: GapPadding.all16S,
              decoration: BoxDecoration(
                color: CupertinoColors.tertiarySystemFill,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Gap.h32,
            Gap.h32,
            Button.tinted(
              child: Text('add'.i18n()),
              onPressed: () async {
                if (transactionProvider.amount == null) {
                  SnackBar.show(context, 
                    'Jumlah belum diisi',
                    autoDismiss: true
                  );
                } else if (transactionProvider.name == null) {
                  SnackBar.show(context, 'Nama belum diisi',
                    autoDismiss: true
                  );
                } else {
                  await transactionProvider.addTransaction()
                  .then((value) {
                    transactionProvider.clearInput();
                    Navigator.of(context).pop();
                  }, onError: (e, t) {
                    SnackBar.show(context, e.toString(),
                      autoDismiss: true
                    );
                  });
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
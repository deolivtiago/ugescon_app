import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../data/models/models.dart';

class OperationTypePage extends StatelessWidget {
  final EntryModel entry;

  const OperationTypePage({
    required this.entry,
    super.key,
  });

  static Route route(RouteSettings settings) {
    final entry = settings.arguments == null
        ? EntryModel.empty()
        : settings.arguments as EntryModel;

    return MaterialPageRoute(
      settings: settings,
      builder: (_) => OperationTypePage(entry: entry),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: const Text('Lançamentos Contábeis')),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Escolha o tipo de operação',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: entries
                      .map(
                        (e) => Card(
                          child: ListTile(
                            trailing: const Icon(Icons.navigate_next),
                            title: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(e.name),
                            ),
                            onTap: () => Navigator.of(context).pushNamed(
                              AppRoutes.createEntry,
                              arguments: entry.copyWith(
                                debitAccount: e.debitAccount.level == 0
                                    ? entry.debitAccount
                                    : e.debitAccount,
                                creditAccount: e.creditAccount.level == 0
                                    ? entry.creditAccount
                                    : e.creditAccount,
                                description: e.name,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<EntryModel> get entries {
    return [
      EntryModel.empty().copyWith(
        name: 'À Vista em Dinheiro',
        debitAccount: entry.debitAccount.level == 0
            ? entry.debitAccount.copyWith(
                name: 'Caixa',
                level: 4,
                code: '11101',
                type: AccountType.debit,
              )
            : entry.debitAccount,
        creditAccount: entry.creditAccount.level == 0
            ? entry.creditAccount.copyWith(
                name: 'Caixa',
                level: 4,
                code: '11101',
                type: AccountType.debit,
              )
            : entry.creditAccount,
      ),
      EntryModel.empty().copyWith(
        name: 'À Vista com Cartão de Crédito',
        debitAccount: entry.debitAccount.level == 0
            ? entry.debitAccount.copyWith(
                name: 'Bancos',
                level: 4,
                code: '11102',
                type: AccountType.debit,
              )
            : entry.debitAccount,
        creditAccount: entry.creditAccount.level == 0
            ? entry.creditAccount.copyWith(
                name: 'Bancos',
                level: 4,
                code: '11102',
                type: AccountType.debit,
              )
            : entry.creditAccount,
      ),
      EntryModel.empty().copyWith(
        name: 'À Vista com Cartão de Débito',
        debitAccount: entry.debitAccount.level == 0
            ? entry.debitAccount.copyWith(
                name: 'Bancos',
                level: 4,
                code: '11102',
                type: AccountType.debit,
              )
            : entry.debitAccount,
        creditAccount: entry.creditAccount.level == 0
            ? entry.creditAccount.copyWith(
                name: 'Bancos',
                level: 4,
                code: '11102',
                type: AccountType.debit,
              )
            : entry.creditAccount,
      ),
      EntryModel.empty().copyWith(
        name: 'À Vista com Transferencia Bancária',
        debitAccount: entry.debitAccount.level == 0
            ? entry.debitAccount.copyWith(
                name: 'Bancos',
                level: 4,
                code: '11102',
                type: AccountType.debit,
              )
            : entry.debitAccount,
        creditAccount: entry.creditAccount.level == 0
            ? entry.creditAccount.copyWith(
                name: 'Bancos',
                level: 4,
                code: '11102',
                type: AccountType.debit,
              )
            : entry.creditAccount,
      ),
      EntryModel.empty().copyWith(
        name: 'À Prazo em Dinheiro',
        debitAccount: entry.debitAccount.level == 0
            ? entry.debitAccount.copyWith(
                name: 'Contas a Receber',
                level: 4,
                code: '11301',
                type: AccountType.debit,
              )
            : entry.debitAccount,
        creditAccount: entry.creditAccount.level == 0
            ? entry.creditAccount.copyWith(
                name: 'Contas a Receber',
                level: 4,
                code: '11301',
                type: AccountType.debit,
              )
            : entry.creditAccount,
      ),
      EntryModel.empty().copyWith(
        name: 'À Prazo com Cartão de Crédito',
        debitAccount: entry.debitAccount.level == 0
            ? entry.debitAccount.copyWith(
                name: 'Contas a Receber',
                level: 4,
                code: '11301',
                type: AccountType.debit,
              )
            : entry.debitAccount,
        creditAccount: entry.creditAccount.level == 0
            ? entry.creditAccount.copyWith(
                name: 'Contas a Receber',
                level: 4,
                code: '11301',
                type: AccountType.debit,
              )
            : entry.creditAccount,
      ),
      EntryModel.empty().copyWith(
        name: 'À Prazo com Transferencia Bancária',
        debitAccount: entry.debitAccount.level == 0
            ? entry.debitAccount.copyWith(
                name: 'Contas a Receber',
                level: 4,
                code: '11301',
                type: AccountType.debit,
              )
            : entry.debitAccount,
        creditAccount: entry.creditAccount.level == 0
            ? entry.creditAccount.copyWith(
                name: 'Fornecedores',
                level: 4,
                code: '21101',
                type: AccountType.debit,
              )
            : entry.creditAccount,
      ),
    ];
  }
}

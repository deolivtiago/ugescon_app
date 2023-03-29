import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../data/models/models.dart';

class OperationPage extends StatelessWidget {
  final UserModel user;

  const OperationPage({
    required this.user,
    super.key,
  });

  static Route route(RouteSettings settings) {
    final user = settings.arguments == null
        ? UserModel.empty()
        : settings.arguments as UserModel;

    return MaterialPageRoute(
      settings: settings,
      builder: (_) => OperationPage(
        user: user,
        // options: [
        // OperationModel(
        //   name: 'Revenda de Mercadorias',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Venda de Produtos',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Prestação de Serviços',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Recebimento de Cliente',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Compra de Mercadorias para Revenda',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Compra de Materiais para Uso e Consumo',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Compra de Matéria Prima',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Compra de Materiais para Industrialização',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Pagamento de Salários',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Pagamento de Tributos',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Pagamento de Fornecedor',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Descontos Obtidos',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Bonificação Recebida',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Venda de Veículo da Empresa',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Venda de Imóvel da Empresa',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Venda de Equipamentos da Empresa',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Compra de Veículos para a Empresa',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Compra de Imóveis para a Empresa',
        //   account: AccountModel.empty(),
        // ),
        // OperationModel(
        //   name: 'Compra de Equipamentos para a Empresa',
        //   account: AccountModel.empty(),
        // ),
        // ],
      ),
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
                'Escolha uma operação',
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
                              AppRoutes.operationType,
                              arguments: e,
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

  List<EntryModel> get entries => [
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Revenda de Mercadorias',
          creditAccount: AccountModel.empty().copyWith(
            name: 'Revenda de Mercadorias',
            level: 4,
            code: '31101',
            type: AccountType.credit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Venda de Produtos',
          creditAccount: AccountModel.empty().copyWith(
            name: 'Venda de Produtos Industrializados',
            level: 4,
            code: '31201',
            type: AccountType.credit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Prestação de Serviços',
          creditAccount: AccountModel.empty().copyWith(
            name: 'Serviços Prestados',
            level: 4,
            code: '31301',
            type: AccountType.credit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Compra de Mercadorias para Revenda',
          debitAccount: AccountModel.empty().copyWith(
            name: 'Estoque Comércio',
            level: 4,
            code: '11201',
            type: AccountType.debit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Compra de Materiais para Uso e Consumo',
          debitAccount: AccountModel.empty().copyWith(
            name: 'Estoque Prest Serviços',
            level: 4,
            code: '11202',
            type: AccountType.debit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Compra de Matéria Prima',
          debitAccount: AccountModel.empty().copyWith(
            name: 'Estoque Industrialização',
            level: 4,
            code: '11203',
            type: AccountType.debit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Compra de Materiais para Industrialização',
          debitAccount: AccountModel.empty().copyWith(
            name: 'Estoque Industrialização',
            level: 4,
            code: '11203',
            type: AccountType.debit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Pagamento de Salários',
          debitAccount: AccountModel.empty().copyWith(
            name: 'Obrigações Trabalhistas',
            level: 4,
            code: '21102',
            type: AccountType.credit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Pagamento de Tributos',
          debitAccount: AccountModel.empty().copyWith(
            name: 'Obrigações Tributárias',
            level: 4,
            code: '21103',
            type: AccountType.credit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Pagamento de Fornecedor',
          debitAccount: AccountModel.empty().copyWith(
            name: 'Fornecedores',
            level: 4,
            code: '21101',
            type: AccountType.credit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Venda de Veículo da Empresa',
          creditAccount: AccountModel.empty().copyWith(
            name: 'Veículos',
            level: 4,
            code: '12103',
            type: AccountType.debit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Venda de Imóvel da Empresa',
          creditAccount: AccountModel.empty().copyWith(
            name: 'Imóveis',
            level: 4,
            code: '12104',
            type: AccountType.debit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Venda de Equipamentos da Empresa',
          creditAccount: AccountModel.empty().copyWith(
            name: 'Máquinas e Equipamentos',
            level: 4,
            code: '12101',
            type: AccountType.debit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Compra de Veículos para a Empresa',
          debitAccount: AccountModel.empty().copyWith(
            name: 'Veículos',
            level: 4,
            code: '12103',
            type: AccountType.debit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Compra de Imóveis para a Empresa',
          debitAccount: AccountModel.empty().copyWith(
            name: 'Imóveis',
            level: 4,
            code: '12104',
            type: AccountType.debit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Compra de Equipamentos para a Empresa',
          debitAccount: AccountModel.empty().copyWith(
            name: 'Máquinas e Equipamentos',
            level: 4,
            code: '12101',
            type: AccountType.debit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Provisão de Salários',
          creditAccount: AccountModel.empty().copyWith(
            name: 'Obrigações Trabalhistas',
            level: 4,
            code: '21102',
            type: AccountType.credit,
          ),
        ),
        EntryModel.empty().copyWith(
          organization: user.organization,
          name: 'Recebimento de Cliente',
          creditAccount: AccountModel.empty().copyWith(
            name: 'Contas a Receber',
            level: 4,
            code: '11301',
            type: AccountType.debit,
          ),
        ),
      ];
}

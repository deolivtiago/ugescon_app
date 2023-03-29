import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../config/config.dart';
import '../../data/models/models.dart';
import 'journal.dart';

class EntriesPage extends StatelessWidget {
  final OrganizationModel organization;

  const EntriesPage({
    required this.organization,
    super.key,
  });

  static Route route(RouteSettings settings) {
    final organization = settings.arguments == null
        ? OrganizationModel.empty()
        : settings.arguments as OrganizationModel;

    return MaterialPageRoute(
      settings: settings,
      builder: (_) => EntriesPage(
        organization: organization,
        // entries: [
        // OperationModel(
        //   name: 'Compra de Mercadorias para Revenda',
        //   account: AccountModel.empty(),
        //   date: '28/02/2023',
        //   value: 642.84,
        //   description:
        //       'Compra de alimetícios para comercialização com pagamento à vista com dinheiro do caixa',
        // ),
        // OperationModel(
        //   name: 'Compra de Matéria Prima',
        //   account: AccountModel.empty(),
        //   date: '08/02/2023',
        //   value: 984.34,
        //   description:
        //       'Compra de matéria prima para industrialização com pagamento à vista com dinheiro do caixa',
        // ),
        // OperationModel(
        //   name: 'Revenda de Mercadorias',
        //   account: AccountModel.empty().copyWith(type: AccountType.debit),
        //   date: '03/03/2023',
        //   value: 264.81,
        //   description:
        //       'Venda de alimentícios à vista no cartão de crédito para recebimento em até 30 dias',
        // ),
        // OperationModel(
        //   name: 'Compra de Mercadorias para Revenda',
        //   account: AccountModel.empty(),
        //   date: '04/03/2023',
        //   value: 1348.99,
        //   description:
        //       'Compra de utensílios de cozinha para comercialização com pagamento à vista com dinheiro do caixa',
        // ),
        // OperationModel(
        //   name: 'Revenda de Mercadorias',
        //   account: AccountModel.empty().copyWith(type: AccountType.debit),
        //   date: '06/03/2023',
        //   value: 684.11,
        //   description:
        //       'Venda de Utensílios de cozinha com recebimento à vista no dinheiro',
        // ),
        // OperationModel(
        //   name: 'Venda de Produtos',
        //   account: AccountModel.empty().copyWith(type: AccountType.debit),
        //   date: '07/03/2023',
        //   value: 1354.48,
        //   description:
        //       'Venda de produtos industrializados com recebimento em à prazo',
        // ),
        // OperationModel(
        //   name: 'Prestação de Serviços',
        //   account: AccountModel.empty().copyWith(type: AccountType.debit),
        //   date: '10/03/2023',
        //   value: 148.37,
        //   description:
        //       'Prestação de serviços de conserto com recebimento em dinheiro à vista',
        // ),
        // OperationModel(
        //   name: 'Venda de Veículo da Empresa',
        //   account: AccountModel.empty().copyWith(type: AccountType.debit),
        //   value: 984.19,
        //   description:
        //       'Compra de alimetícios para comercialização pago com dinheiro do caixa',
        // ),
        // ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<JournalBloc>()
        .add(JournalFetchEvent(organization: organization));

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Livro Diário')),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocListener<JournalBloc, JournalState>(
                  listener: (context, state) {
                    if (state is Failed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  child: BlocBuilder<JournalBloc, JournalState>(
                    builder: (context, state) {
                      if (state is Loaded && state.entries.isNotEmpty) {
                        return ListView(
                          children: state.entries.reversed
                              .map(
                                (e) => Card(
                                  child: ListTile(
                                    onTap: () =>
                                        Navigator.of(context).pushNamed(
                                      AppRoutes.editEntry,
                                      arguments: e.copyWith(
                                        organization: organization,
                                      ),
                                    ),
                                    title: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 6,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 16.0,
                                              bottom: 4.0,
                                            ),
                                            child: Text(
                                              e.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 2.0),
                                            child: Text(
                                              e.value.toString(),
                                              style: const TextStyle(
                                                color: Colors.blueGrey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            flex: 4,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: Text(
                                                e.description,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: Text(
                                                DateFormat('dd/MM/yyyy')
                                                    .format(e.date),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      }
                      return const Center(child: Text('Sem dados para exibir'));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

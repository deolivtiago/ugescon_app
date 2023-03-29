import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'coa.dart';

class CoaPage extends StatelessWidget {
  const CoaPage({
    super.key,
  });

  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const CoaPage(
          // rows: [
          // ...FinancialStatementsModel.balanceSheetRows(),
          // ...FinancialStatementsModel.incomeStatementRows(),
          // ]
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<CoaBloc>().add(CoaFetchEvent());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Plano de Contas'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: BlocListener<CoaBloc, CoaState>(
            listener: (context, state) {
              if (state is Failed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: BlocBuilder<CoaBloc, CoaState>(builder: (context, state) {
              return state is Loaded
                  ? DataTable(
                      columns: const [
                        DataColumn(
                          label: Text('Código'),
                        ),
                        DataColumn(
                          label: Text('Conta'),
                        ),
                        DataColumn(
                          label: Text('Nível'),
                        ),
                      ],
                      rows: state.accounts
                          .map(
                            (e) => DataRow(
                              cells: [
                                DataCell(
                                  SizedBox(
                                    width: 42,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        e.code,
                                        style: e.level == 4
                                            ? null
                                            : const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      e.name,
                                      style: e.level == 4
                                          ? null
                                          : const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      e.level.toString(),
                                      style: e.level == 4
                                          ? null
                                          : const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    )
                  : const Center(child: CircularProgressIndicator());
            }),
          ),
        ),
      ),
    );
  }
}

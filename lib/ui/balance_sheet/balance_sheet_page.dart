import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import 'balance_sheet.dart';

class BalanceSheetPage extends StatelessWidget {
  final OrganizationModel organization;

  const BalanceSheetPage({
    required this.organization,
    super.key,
  });

  static Route route(RouteSettings settings) {
    final organization = settings.arguments == null
        ? OrganizationModel.empty()
        : settings.arguments as OrganizationModel;

    return MaterialPageRoute(
      settings: settings,
      builder: (_) => BalanceSheetPage(organization: organization),
    );
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<BalanceSheetBloc>()
        .add(BalanceSheetFetchEvent(organization: organization));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Balanço Patrimonial'),
      ),
      body: Center(
        child: BlocBuilder<BalanceSheetBloc, BalanceSheetState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is Loaded) {
              return SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 16.0,
                  columns: const [
                    DataColumn(
                      label: Text('Código'),
                    ),
                    DataColumn(
                      label: Text('Conta'),
                    ),
                    DataColumn(
                      label: Text('Total'),
                    ),
                  ],
                  rows: state.balanceSheetRows
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
                                  e.accountName,
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
                                  e.total.toString(),
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
                ),
              );
            }
            return const Center(
              child: Text('Sem dados'),
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.download),
      //   onPressed: () => context
      //       .read<BalanceSheetBloc>()
      //       .add(BalanceSheetFetchEvent(organization: organization)),
      // ),
    );
  }
}

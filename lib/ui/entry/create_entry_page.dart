import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../data/models/models.dart';
import '../../config/config.dart';
import 'entry.dart';

class CreateEntryPage extends StatefulWidget {
  final EntryModel entry;

  const CreateEntryPage({
    required this.entry,
    super.key,
  });

  static Route route(RouteSettings settings) {
    final entry = settings.arguments == null
        ? EntryModel.empty()
        : settings.arguments as EntryModel;

    return MaterialPageRoute(
      settings: settings,
      builder: (_) => CreateEntryPage(entry: entry),
    );
  }

  @override
  State<CreateEntryPage> createState() => _CreateEntryPageState();
}

class _CreateEntryPageState extends State<CreateEntryPage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _ecDate;
  late TextEditingController _ecValue;
  late TextEditingController _ecDescription;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _ecDate = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(widget.entry.date),
    );
    _ecValue = TextEditingController(text: widget.entry.value.toString());
    _ecDescription = TextEditingController(
      text: '${widget.entry.name} ${widget.entry.description}',
    );
    _selectedDate = widget.entry.date;
  }

  @override
  Widget build(BuildContext context) {
    context.read<EntryBloc>().add(EntryFetchParentEvent(
          debitAccount: widget.entry.debitAccount,
          creditAccount: widget.entry.creditAccount,
        ));
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: const Text('Lançamentos Contábeis')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: BlocListener<EntryBloc, EntryState>(
              listener: (context, state) {
                if (state is EntryFailedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }

                if (state is EntryLoadedState) {
                  Navigator.of(context)
                      .popUntil(ModalRoute.withName(AppRoutes.home));
                }
              },
              child: BlocBuilder<EntryBloc, EntryState>(
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Conta de Débito ',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: widget
                                              .entry.debitAccount.code
                                              .substring(0, 1),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: state is EntryFetchedState
                                              ? state.parents['debit']![0]
                                              : '',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: widget
                                              .entry.debitAccount.code
                                              .substring(0, 2),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: state is EntryFetchedState
                                              ? state.parents['debit']![1]
                                              : '',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: widget
                                              .entry.debitAccount.code
                                              .substring(0, 3),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: state is EntryFetchedState
                                              ? state.parents['debit']![2]
                                              : '',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText:
                                              widget.entry.debitAccount.code,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText:
                                              widget.entry.debitAccount.name,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Conta de Crédito',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: widget
                                              .entry.creditAccount.code
                                              .substring(0, 1),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: state is EntryFetchedState
                                              ? state.parents['credit']![0]
                                              : '',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: widget
                                              .entry.creditAccount.code
                                              .substring(0, 2),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: state is EntryFetchedState
                                              ? state.parents['credit']![1]
                                              : '',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: widget
                                              .entry.creditAccount.code
                                              .substring(0, 3),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: state is EntryFetchedState
                                              ? state.parents['credit']![2]
                                              : '',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText:
                                              widget.entry.creditAccount.code,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText:
                                              widget.entry.creditAccount.name,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: TextFormField(
                                        controller: _ecDate,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Data',
                                        ),
                                        validator: (text) {
                                          if (text == null ||
                                              text.trim().isEmpty) {
                                            return 'Campo Obrigatório';
                                          }
                                          return null;
                                        },
                                        readOnly: true,
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: _selectedDate,
                                            firstDate: DateTime(1950),
                                            lastDate: DateTime(2100),
                                          );

                                          if (pickedDate != null) {
                                            _selectedDate = pickedDate.toUtc();

                                            setState(() {
                                              _ecDate.text =
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(pickedDate);
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: TextFormField(
                                        controller: _ecValue,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Valor',
                                        ),
                                        validator: (text) {
                                          if (text == null ||
                                              text.trim().isEmpty) {
                                            return 'Campo Obrigatório';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: TextFormField(
                                controller: _ecDescription,
                                minLines: 2,
                                maxLines: 4,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Descrição',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<EntryBloc>().add(
                                      EntryCreateEvent(
                                        name: widget.entry.name,
                                        date: _selectedDate,
                                        value: double.parse(_ecValue.text),
                                        description: _ecDescription.text,
                                        debitAccountCode:
                                            widget.entry.debitAccount.code,
                                        creditAccountCode:
                                            widget.entry.creditAccount.code,
                                        organizationId:
                                            widget.entry.organization.id,
                                      ),
                                    );
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 16.0,
                              ),
                              child: Text(
                                'SALVAR',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

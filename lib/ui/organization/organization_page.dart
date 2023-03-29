import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import 'organization.dart';

class OrganizationPage extends StatefulWidget {
  final UserModel user;

  const OrganizationPage({
    required this.user,
    super.key,
  });

  static Route route(RouteSettings settings) {
    final user = settings.arguments == null
        ? UserModel.empty()
        : settings.arguments as UserModel;

    return MaterialPageRoute(
      settings: settings,
      builder: (_) => OrganizationPage(user: user),
    );
  }

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _ecName;
  late TextEditingController _ecAlias;
  late TextEditingController _ecSocialId;
  late TextEditingController _ecZip;

  late TextEditingController _ecStreet;
  late TextEditingController _ecNumber;
  late TextEditingController _ecNeighborhood;

  late List<StateModel?> _statesList;
  StateModel? _selectedState;
  late List<CityModel?> _citiesList;
  CityModel? _selectedCity;

  @override
  void initState() {
    final organization = widget.user.organization;

    _formKey = GlobalKey<FormState>();
    _ecName = TextEditingController(text: organization.name);
    _ecAlias = TextEditingController(text: organization.alias);
    _ecSocialId = TextEditingController(text: organization.socialId);
    _ecZip = TextEditingController(text: organization.address.zip);
    _ecStreet = TextEditingController(text: organization.address.street);
    _ecNumber = TextEditingController(text: organization.address.number);
    _ecNeighborhood =
        TextEditingController(text: organization.address.neighborhood);
    _selectedCity = organization.address.city;
    _selectedState = organization.address.city.state;
    _statesList = [];
    _citiesList = [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<OrganizationBloc>().add(OrganizationFetchStatesEvent());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Empresa'),
        actions: widget.user.organization.name.isNotEmpty
            ? [
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Alerta de Exclusão'),
                          content: Text(
                              'A empresa `${widget.user.organization.name}` será excluída permanentemente. Deseja continuar?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Não'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Sim'),
                            ),
                          ],
                        ),
                      ).then((isConfirmed) {
                        if (isConfirmed ?? false) {
                          context
                              .read<OrganizationBloc>()
                              .add(OrganizationDeleteEvent(
                                organization: widget.user.organization,
                              ));
                        }
                      });
                    })
              ]
            : null,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: BlocListener<OrganizationBloc, OrganizationState>(
              listener: (context, state) {
                if (state is OrganizationFailedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }

                if (state is OrganizationLoadedState) {
                  Navigator.of(context).pop(OrganizationModel(
                    id: state.organization.id,
                    name: state.organization.name,
                    alias: state.organization.alias,
                    socialId: state.organization.socialId,
                    address: state.organization.address,
                  ));
                }

                if (state is OrganizationFetchedStatesState) {
                  _statesList = state.states;
                  _selectedState ??= _statesList.first;

                  if (state.states.isNotEmpty) {
                    context
                        .read<OrganizationBloc>()
                        .add(OrganizationFetchCitiesEvent(
                          state: state.states.first,
                        ));
                  }
                }

                if (state is OrganizationFetchedCitiesState) {
                  _citiesList = state.cities;
                  _selectedCity ??= _citiesList.first;
                }
              },
              child: BlocBuilder<OrganizationBloc, OrganizationState>(
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                              child: TextFormField(
                                controller: _ecName,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Razão Social',
                                ),
                                validator: (text) {
                                  if (text == null || text.trim().isEmpty) {
                                    return 'Campo obrigatório';
                                  }

                                  if (text.trim().length < 2) {
                                    return 'O nome deve conter ao menos 2 caracteres';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: TextFormField(
                                controller: _ecAlias,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nome Fantasia',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                controller: _ecSocialId,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'CNPJ',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Campo Obrigatório';
                                  }

                                  if (!RegExp(r'^(\d+)$').hasMatch(value)) {
                                    return 'Somente Números';
                                  }
                                  return null;
                                },
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
                              child: TextFormField(
                                controller: _ecZip,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'CEP',
                                ),
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Campo Obrigatório';
                                  }

                                  if (!RegExp(r'^(\d+)$').hasMatch(value)) {
                                    return 'Somente Números';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: DropdownSearch<StateModel?>(
                                        popupProps: const PopupProps.menu(
                                          fit: FlexFit.loose,
                                        ),
                                        itemAsString: (e) => e!.code,
                                        items: _statesList,
                                        dropdownDecoratorProps:
                                            const DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            labelText: 'Estado',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        selectedItem: _selectedState,
                                        onChanged: (value) {
                                          if (value?.code !=
                                              _selectedState?.code) {
                                            _selectedState = value;
                                            _selectedCity = null;
                                            context
                                                .read<OrganizationBloc>()
                                                .add(
                                                  OrganizationFetchCitiesEvent(
                                                    state: value!,
                                                  ),
                                                );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: DropdownSearch<CityModel?>(
                                        popupProps: const PopupProps.menu(
                                          fit: FlexFit.loose,
                                        ),
                                        itemAsString: (e) => e!.name,
                                        items: _citiesList,
                                        dropdownDecoratorProps:
                                            const DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            labelText: 'Cidade',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        selectedItem: _selectedCity,
                                        onChanged: (value) =>
                                            _selectedCity = value,
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
                                controller: _ecStreet,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Endereço',
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Campo Obrigatório';
                                  }

                                  if (text.trim().length < 2) {
                                    return 'O endereço deve conter ao menos 2 caracteres';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: TextFormField(
                                        controller: _ecNumber,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Número',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: TextFormField(
                                        controller: _ecNeighborhood,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Bairro',
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                widget.user.organization.name.isEmpty
                                    ? context.read<OrganizationBloc>().add(
                                          OrganizationCreateEvent(
                                            userId: widget.user.id,
                                            name: _ecName.text,
                                            alias: _ecAlias.text,
                                            socialId: _ecSocialId.text,
                                            type: 1,
                                            street: _ecStreet.text,
                                            number: _ecNumber.text,
                                            neighborhood: _ecNeighborhood.text,
                                            zip: _ecZip.text,
                                            cityId: _selectedCity!.id,
                                          ),
                                        )
                                    : context.read<OrganizationBloc>().add(
                                          OrganizationEditEvent(
                                            organization:
                                                widget.user.organization,
                                            userId: widget.user.id,
                                            name: _ecName.text,
                                            alias: _ecAlias.text,
                                            socialId: _ecSocialId.text,
                                            type: 1,
                                            street: _ecStreet.text,
                                            number: _ecNumber.text,
                                            neighborhood: _ecNeighborhood.text,
                                            zip: _ecZip.text,
                                            cityId: _selectedCity!.id,
                                          ),
                                        );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 16.0,
                              ),
                              child: widget.user.organization.name.isEmpty
                                  ? const Text(
                                      'SALVAR',
                                      style: TextStyle(fontSize: 18),
                                    )
                                  : const Text(
                                      'ALTERAR',
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

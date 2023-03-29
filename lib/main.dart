import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/config.dart';
import 'data/repositories/repositories.dart';
import 'ui/balance_sheet/balance_sheet.dart';
import 'ui/coa/coa.dart';
import 'ui/entry/entry.dart';
import 'ui/home/home.dart';
import 'ui/income_statement/income_statement_bloc.dart';
import 'ui/journal/journal.dart';
import 'ui/organization/organization.dart';
import 'ui/profile/profile.dart';
import 'ui/signin/signin.dart';
import 'ui/signup/signup.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<CacheRepository>(
          create: (context) => CacheRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(
            cacheRepository: context.read<CacheRepository>(),
          ),
        ),
        RepositoryProvider<FinancialStatementsRepository>(
          create: (context) => FinancialStatementsRepository(
            cacheRepository: context.read<CacheRepository>(),
          ),
        ),
        RepositoryProvider<AccountRepository>(
          create: (context) => AccountRepository(
            cacheRepository: context.read<CacheRepository>(),
          ),
        ),
        RepositoryProvider<EntryRepository>(
          create: (context) => EntryRepository(
            cacheRepository: context.read<CacheRepository>(),
          ),
        ),
        RepositoryProvider<OrganizationRepository>(
          create: (context) => OrganizationRepository(
            cacheRepository: context.read<CacheRepository>(),
          ),
        ),
        RepositoryProvider<LocationRepository>(
          create: (context) => LocationRepository(
            cacheRepository: context.read<CacheRepository>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(
              authRepository: context.read<AuthRepository>(),
              cacheRepository: context.read<CacheRepository>(),
            ),
          ),
          BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(
              authRepository: context.read<AuthRepository>(),
              cacheRepository: context.read<CacheRepository>(),
            ),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              cacheRepository: context.read<CacheRepository>(),
            ),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              userRepository: context.read<UserRepository>(),
              cacheRepository: context.read<CacheRepository>(),
            ),
          ),
          BlocProvider<BalanceSheetBloc>(
            create: (context) => BalanceSheetBloc(
              financialStatementsRepository:
                  context.read<FinancialStatementsRepository>(),
            ),
          ),
          BlocProvider<IncomeStatementBloc>(
            create: (context) => IncomeStatementBloc(
              financialStatementsRepository:
                  context.read<FinancialStatementsRepository>(),
            ),
          ),
          BlocProvider<CoaBloc>(
            create: (context) => CoaBloc(
              accountRepository: context.read<AccountRepository>(),
            ),
          ),
          BlocProvider<JournalBloc>(
            create: (context) => JournalBloc(
              entryRepository: context.read<EntryRepository>(),
            ),
          ),
          BlocProvider<OrganizationBloc>(
            create: (context) => OrganizationBloc(
              organizationRepository: context.read<OrganizationRepository>(),
              locationRepository: context.read<LocationRepository>(),
            ),
          ),
          BlocProvider<EntryBloc>(
            create: (context) => EntryBloc(
              entryRepository: context.read<EntryRepository>(),
              accountRepository: context.read<AccountRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'μGesCon',
          theme: AppTheme.light,
          initialRoute: AppRoutes.signIn,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        ),
      ),
    );
  }
}

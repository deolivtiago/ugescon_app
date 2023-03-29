import 'dart:convert';

import 'package:equatable/equatable.dart';

// class FinancialStatementsModel implements Equatable {
//   final List<FinancialStatementRowModel> rows;

//   const FinancialStatementsModel({required this.rows});

//   @override
//   List<Object?> get props => [rows];

//   @override
//   bool? get stringify => true;

//   factory FinancialStatementsModel.empty() => FinancialStatementsModel(
//         rows: [
//           ...balanceSheetRows(),
//           ...incomeStatementRows(),
//         ],
//       );

//   List<Map<String, dynamic>> toMap() {
//     return rows.map((r) => r.toMap()).toList();
//   }

//   factory FinancialStatementsModel.fromMap(Map<String, dynamic> map) {
//     return FinancialStatementsModel(
//       rows: List<FinancialStatementRowModel>.from(
//         (map as List).map<FinancialStatementRowModel>(
//           (r) => FinancialStatementRowModel.fromMap(r as Map<String, dynamic>),
//         ),
//       ),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory FinancialStatementsModel.fromJson(String source) =>
//       FinancialStatementsModel.fromMap(
//           json.decode(source) as Map<String, dynamic>);

//   List<FinancialStatementRowModel> get balanceSheet => rows
//       .where((r) => r.code.startsWith('1') || r.code.startsWith('2'))
//       .toList();

//   List<FinancialStatementRowModel> get incomeStatement => rows
//       .where((r) =>
//           r.code.startsWith('3') ||
//           r.code.startsWith('4') ||
//           r.code.startsWith('5'))
//       .toList();

//   static List<FinancialStatementRowModel> balanceSheetRows() => const [
//         {"level": 1, "code": "1", "name": "ATIVO", "total": 3925.09},
//         {
//           "level": 2,
//           "code": "11",
//           "name": "ATIVO CIRCULANTE",
//           "total": 3925.09
//         },
//         {
//           "level": 3,
//           "code": "111",
//           "name": "DISPONIBILIDADES",
//           "total": 648.92
//         },
//         {"code": "11101", "name": "Caixa", "total": 684.11},
//         {"code": "11102", "name": "Bancos", "total": 264.81},
//         {"level": 3, "code": "112", "name": "ESTOQUES", "total": 2976.17},
//         {"code": "11201", "name": "Mercadorias para Revenda", "total": 1991.83},
//         {"code": "11202", "name": "Materiais para Consumo", "total": 0.0},
//         {"code": "11203", "name": "Matérias Prima", "total": 984.34},
//         {"level": 3, "code": "113", "name": "CRÉDITOS", "total": 1502.85},
//         {"code": "11301", "name": "Contas a Receber", "total": 1502.85},
//         {"code": "11302", "name": "Créditos e Adiantamentos", "total": 0.0},
//         {
//           "level": 2,
//           "code": "12",
//           "name": "ATIVO NÃO CIRCULANTE",
//           "total": 0.0
//         },
//         {"level": 3, "code": "121", "name": "IMOBILIZADO", "total": 0.0},
//         {"code": "12101", "name": "Máquinas e Equipamentos", "total": 0.0},
//         {"code": "12102", "name": "Móveis e Utensílios", "total": 0.0},
//         {"code": "12103", "name": "Veículos", "total": 0.0},
//         {"code": "12104", "name": "Imóveis", "total": 0.0},
//         {"level": 1, "code": "2", "name": "PASSIVO", "total": 0.0},
//         {"level": 2, "code": "21", "name": "PASSIVO CIRCULANTE", "total": 0.0},
//         {
//           "level": 3,
//           "code": "211",
//           "name": "OBRIGAÇÕES DE CURTO PRAZO",
//           "total": 0.0
//         },
//         {"code": "21101", "name": "Fornecedores", "total": 0.0},
//         {
//           "level": 3,
//           "code": "212",
//           "name": "OBRIGAÇÕES DE LONGO PRAZO",
//           "total": 0.0
//         },
//         {"code": "21201", "name": "Empréstimos e Financiamentos", "total": 0.0},
//         {"code": "21202", "name": "Obrigações Trabalhistas", "total": 0.0},
//         {"code": "21203", "name": "Obrigações Tributárias", "total": 0.0},
//         {"code": "21204", "name": "Outras Obrigações", "total": 0.0},
//         {"level": 2, "code": "23", "name": "PATRIMÔNIO LÍQUIDO", "total": 0.0},
//         {"level": 3, "code": "231", "name": "CAPITAL SOCIAL", "total": 0.0},
//         {"code": "23101", "name": "Capital Social Integralizado", "total": 0.0},
//         {
//           "level": 3,
//           "code": "232",
//           "name": "RESULTADOS DE EXERCÍCIOS ANTERIORES",
//           "total": 0.0
//         },
//         {
//           "code": "23201",
//           "name": "Lucros ou Prejuízos Acumulados",
//           "total": 0.0
//         }
//       ].map((r) => FinancialStatementRowModel.fromMap(r)).toList();

//   static List<FinancialStatementRowModel> incomeStatementRows() => const [
//         {"level": 1, "code": "3", "name": "RECEITAS", "total": 2451.77},
//         {
//           "level": 2,
//           "code": "31",
//           "name": "RECEITA OPERACIONAL",
//           "total": 2290.45
//         },
//         {
//           "level": 3,
//           "code": "311",
//           "name": "RECEITA DE COMERCIALIZAÇÃO",
//           "total": 948.92
//         },
//         {"code": "31101", "name": "Revenda de Mercadorias", "total": 948.92},
//         {
//           "level": 3,
//           "code": "312",
//           "name": "RECEITA DE INDUSTRIALIZAÇÃO",
//           "total": 1354.48
//         },
//         {
//           "code": "31201",
//           "name": "Venda de Produtos Industrializados",
//           "total": 1354.48
//         },
//         {
//           "level": 3,
//           "code": "313",
//           "name": "RECEITA DE PRESTAÇÃO DE SERVIÇOS",
//           "total": 148.37
//         },
//         {"code": "31301", "name": "Serviços Prestados", "total": 148.37},
//         {
//           "level": 2,
//           "code": "32",
//           "name": "DEDUÇÕES DA RECEITA",
//           "total": -161.32
//         },
//         {"level": 3, "code": "321", "name": "TRIBUTOS", "total": -161.32},
//         {"code": "32101", "name": "Impostos e Contribuições", "total": -161.32},
//         {"code": "32102", "name": "Descontos e Devoluções", "total": 0.0},
//         {"level": 1, "code": "4", "name": "CUSTOS", "total": -106.48},
//         {
//           "level": 2,
//           "code": "41",
//           "name": "CUSTO OPERACIONAL",
//           "total": -106.48
//         },
//         {
//           "level": 3,
//           "code": "411",
//           "name": "CUSTO DA MERCADORIA VENDIDA",
//           "total": -106.48
//         },
//         {
//           "code": "41101",
//           "name": "Custo de Aquisição de Mercadorias",
//           "total": -106.48
//         },
//         {
//           "level": 3,
//           "code": "412",
//           "name": "CUSTO DO PRODUTO INDUSTRIALIZADO",
//           "total": 0.0
//         },
//         {
//           "code": "41201",
//           "name": "Custo de Aquisição de Insumos",
//           "total": 0.0
//         },
//         {"code": "33202", "name": "Custos de Mão de Obra", "total": 0.0},
//         {
//           "code": "33203",
//           "name": "Custos Indiretos de Fabricação",
//           "total": 0.0
//         },
//         {"code": "333", "name": "CUSTO DOS SERVIÇOS PRESTADOS", "total": 0.0},
//         {
//           "code": "33301",
//           "name": "Custo de Aquisição de Materiais",
//           "total": 0.0
//         },
//         {"code": "33302", "name": "Custos de Mão de Obra", "total": 0.0},
//         {
//           "code": "33303",
//           "name": "Custos Indiretos de Prestação de Serviço",
//           "total": 0.0
//         },
//         {"code": "34", "name": "DESPESAS", "total": 0.0},
//         {"code": "341", "name": "DESPESA OPERACIONAL", "total": 0.0},
//         {"code": "34101", "name": "Despesas Comerciais", "total": 0.0},
//         {"code": "34102", "name": "Despesas Administrativas", "total": 0.0},
//         {"code": "34103", "name": "Bonificações e Brindes", "total": 0.0},
//         {"code": "35", "name": "APURAÇÃO DE RESULTADO", "total": 0.0},
//         {"code": "351", "name": "ENCERRAMENTO DE EXERCÍCIO", "total": 0.0},
//         {
//           "code": "35101",
//           "name": "Apuração de Resultado do Exercício",
//           "total": 0.0
//         }
//       ].map((r) => FinancialStatementRowModel.fromMap(r)).toList();
// }

class FinancialStatementRowModel implements Equatable {
  final int level;
  final String code;
  final String accountName;
  final double total;

  const FinancialStatementRowModel({
    this.level = 0,
    required this.code,
    required this.accountName,
    required this.total,
  });

  @override
  List<Object?> get props => [code, accountName, total];

  @override
  bool? get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'level': level,
      'code': code,
      'name': accountName,
      'total': total,
    };
  }

  factory FinancialStatementRowModel.fromMap(Map<String, dynamic> map) {
    return FinancialStatementRowModel(
      level: map['level'] ?? 0,
      code: map['code'] as String,
      accountName: map['name'] as String,
      total: map['total'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinancialStatementRowModel.fromJson(String source) =>
      FinancialStatementRowModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FinancialStatementRowModel(level: $level, code: $code, accountName: $accountName, total: $total)';
  }
}

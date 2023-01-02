import 'package:flutter/material.dart';
import 'package:system_finances/constants/app_text_styles.dart';
import 'package:system_finances/controllers/simulator_controller.dart';
import 'package:system_finances/models/valor_simulado.dart';
import 'package:system_finances/repositories/auth_repository_imp.dart';
import 'package:system_finances/repositories/simulator_repository_imp.dart';
import 'package:system_finances/state/simulator_state.dart';

import '../../constants/app_colors.dart';
import '../../models/valor_futuro.dart';

class SimulatorPage extends StatefulWidget {
  const SimulatorPage({super.key});

  @override
  State<SimulatorPage> createState() => _SimulatorPageState();
}

class _SimulatorPageState extends State<SimulatorPage> {
  final SimulatorController _simulatorController =
      SimulatorController(SimulatorRepositoryImp(), AuthRepositoryImp());

  double get riskValue => _simulatorController.riskValue;
  String get riskLabel => _simulatorController.riskLabel;
  String get year => _simulatorController.year;

  ValorFuturo? get valorFuturo => _simulatorController.valorFuturo.value;
  ValorSimulado? get valorSimulado => _simulatorController.valorSimulado.value;

  double get balance => _simulatorController.balance;

  @override
  void initState() {
    super.initState();
    _simulatorController.valorSimulado.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _simulatorController.valorFuturo.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _init();
  }

  _init() async {
    await _simulatorController.fetchSimulator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black38,
      ),
      backgroundColor: AppColors.black38,
      body: ValueListenableBuilder<SimulatorState>(
        valueListenable: _simulatorController,
        builder: ((context, state, _) {
          if (state is SimulatorLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SimulatorErrorState) {
            return Center(
              child: TextButton(
                  onPressed: () {}, child: const Text('Tentar novamente')),
            );
          }
          if (state is SimulatorSucessState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(children: [
                      const Text('Simule o seu futuro',
                          style: AppTextStyles.largeCaption),
                      const SizedBox(height: 32, width: 32),
                      const Text(
                          textAlign: TextAlign.center,
                          style: AppTextStyles.label,
                          'Veja como podemos ajudar seu patrimônio a crescer muito mais.'),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Nível de Risco: ',
                            style: AppTextStyles.profileData,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            riskLabel,
                            style: AppTextStyles.profileData
                                .copyWith(color: Colors.green.shade400),
                          ),
                        ],
                      ),
                      Center(
                        child: Slider(
                          divisions: 2,
                          max: 2.0,
                          min: 0.0,
                          activeColor: AppColors.primary,
                          label: riskLabel,
                          value: riskValue,
                          onChanged: (double value) {
                            _simulatorController.changeRisk(value);
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Depósito Inicial: ',
                            style: AppTextStyles.profileData,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'R\$ ${valorSimulado?.initialValue.round().toStringAsFixed(2)}',
                            style: AppTextStyles.profileData
                                .copyWith(color: AppColors.primaryShade400),
                          ),
                        ],
                      ),
                      Center(
                        child: Slider(
                            divisions: 5,
                            max: 2000,
                            min: 0.0,
                            semanticFormatterCallback: (double value) {
                              return '${value.round().toStringAsFixed(2)} reais';
                            },
                            activeColor: AppColors.primary,
                            label:
                                valorSimulado?.initialValue.round().toString(),
                            value: valorSimulado?.initialValue ?? 0,
                            onChanged: (double value) {
                              _simulatorController.changeInitialValue;
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Depósito Mensal: ',
                            style: AppTextStyles.profileData,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'R\$ ${valorSimulado?.mounthValue.round()}',
                            style: AppTextStyles.profileData
                                .copyWith(color: Colors.green.shade400),
                          ),
                        ],
                      ),
                      Center(
                        child: Slider(
                            divisions: 5,
                            max: 200,
                            min: 0.0,
                            semanticFormatterCallback: (double value) {
                              return '${value.round()} reais';
                            },
                            activeColor: AppColors.primary,
                            label: '${valorSimulado?.mounthValue.round()}',
                            value: valorSimulado?.mounthValue ?? 0,
                            onChanged: (double value) {
                              _simulatorController.changeMonthValue(value);
                            }),
                      ),
                    ]),
                  ),
                  Container(
                    padding: const EdgeInsetsDirectional.all(32),
                    color: AppColors.white,
                    child: Column(children: [
                      Text('Em $year, você terá:',
                          style: AppTextStyles.blackCaption),
                      const SizedBox(height: 16),
                      Text('R\$ ${balance.toStringAsFixed(2)}',
                          style: AppTextStyles.blackCaption
                              .copyWith(color: AppColors.primary)),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Prazo:', style: AppTextStyles.blackLabel),
                          SizedBox(width: 8),
                          Text('Rendimento:', style: AppTextStyles.blackLabel),
                          SizedBox(width: 8),
                          Text('Taxa:', style: AppTextStyles.blackLabel),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${valorSimulado?.month} meses',
                              style: AppTextStyles.blackLabel),
                          valorFuturo == null
                              ? const Text('--')
                              : Text(
                                  'R\$ ${valorFuturo?.rendimentoTotal.toStringAsFixed(2)}',
                                  style: AppTextStyles.blackLabel),
                          Text('${valorSimulado!.taxaAA.toStringAsFixed(2)} %',
                              style: AppTextStyles.blackLabel),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Text('Faça seu dinheiro render de verdade!',
                          style: AppTextStyles.blackLabel),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () async {
                          await _simulatorController.addOrUpdateSimulator(
                            valorSimulado?.initialValue ?? 0,
                            valorSimulado?.mounthValue ?? 0,
                            valorSimulado!.month,
                            valorSimulado!.taxaAA,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Adicionar'),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20)
                    ]),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}

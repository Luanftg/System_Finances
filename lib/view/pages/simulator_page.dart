import 'package:flutter/material.dart';
import 'package:system_finances/constants/app_text_styles.dart';
import 'package:system_finances/controllers/simulator_controller.dart';
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

  ValueNotifier<double> currentValue = ValueNotifier(0.0);
  double monthValue = 0;
  double riskValue = 0;
  String riskLabel = 'Conservador - 1 ano';
  int mounth = 0;
  int ano = DateTime.now().year;
  String year = '';
  ValorFuturo? valorFuturo;
  double taxaAA = 12.0;
  double balance = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    _simulatorController.getList().then((value) {
      monthValue = value.mounthValue;
      currentValue.value = value.initialValue;
      mounth = value.mounth;
      valorFuturo = SimulatorController.pegaValorFuturoERendimentoTotal(
          currentValue.value, monthValue, value.taxaAA, mounth);
      balance = valorFuturo!.totalValorFuturo;
      if (mounth == 12) {
        riskValue = 0;
        riskLabel = 'Conservador - 1 ano';
      } else if (mounth == 60) {
        riskValue = 1;
        riskLabel = 'Estrategista - 5 anos';
      } else {
        riskValue = 2;
        riskLabel = 'Arriscado - 10 anos';
      }
      taxaAA = value.taxaAA;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black38,
      ),
      backgroundColor: AppColors.black38,
      body: ValueListenableBuilder<SimulatorState>(
        valueListenable: _simulatorController.notifier,
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
                            setState(() {
                              riskValue = value;
                              if (riskValue == 0) {
                                riskLabel = 'Conservador - 1 ano';
                                mounth = 12;
                                valorFuturo = SimulatorController
                                    .pegaValorFuturoERendimentoTotal(
                                        currentValue.value,
                                        monthValue,
                                        taxaAA,
                                        mounth);
                                balance = valorFuturo!.totalValorFuturo;
                                year = (ano + mounth / 12).toStringAsFixed(0);
                              } else if (riskValue == 1) {
                                riskLabel = 'Estrategista - 5 anos';
                                mounth = 60;
                                valorFuturo = SimulatorController
                                    .pegaValorFuturoERendimentoTotal(
                                        currentValue.value,
                                        monthValue,
                                        taxaAA,
                                        mounth);
                                balance = valorFuturo!.totalValorFuturo;
                                year = (ano + mounth / 12).toStringAsFixed(0);
                              } else {
                                riskLabel = 'Arriscado - 10 anos';
                                mounth = 120;
                                valorFuturo = SimulatorController
                                    .pegaValorFuturoERendimentoTotal(
                                        currentValue.value,
                                        monthValue,
                                        taxaAA,
                                        mounth);
                                balance = valorFuturo!.totalValorFuturo;
                                year = (ano + mounth / 12).toStringAsFixed(0);
                              }
                            });
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
                            'R\$ ${currentValue.value.round().toStringAsFixed(2)}',
                            style: AppTextStyles.profileData
                                .copyWith(color: Colors.green.shade400),
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
                            label: currentValue.value.round().toString(),
                            value: currentValue.value,
                            onChanged: (double value) {
                              setState(() {
                                currentValue.value = value;
                                valorFuturo = SimulatorController
                                    .pegaValorFuturoERendimentoTotal(
                                        currentValue.value,
                                        monthValue,
                                        taxaAA,
                                        mounth);
                                balance = valorFuturo!.totalValorFuturo;
                                year = (ano + mounth / 12).toStringAsFixed(0);
                              });
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
                            'R\$ ${monthValue.round()}',
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
                            label: monthValue.round().toString(),
                            value: monthValue,
                            onChanged: (double value) {
                              setState(() {
                                monthValue = value;
                                valorFuturo = SimulatorController
                                    .pegaValorFuturoERendimentoTotal(
                                        currentValue.value,
                                        monthValue,
                                        taxaAA,
                                        mounth);
                                balance = valorFuturo!.totalValorFuturo;
                                year = (ano + mounth / 12).toStringAsFixed(0);
                              });
                            }),
                      ),
                    ]),
                  ),
                  Container(
                    padding: const EdgeInsetsDirectional.all(32),
                    color: Colors.white,
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
                          Text('$mounth meses',
                              style: AppTextStyles.blackLabel),
                          valorFuturo == null
                              ? const Text('--')
                              : Text(
                                  'R\$ ${valorFuturo!.rendimentoTotal.toStringAsFixed(2)}',
                                  style: AppTextStyles.blackLabel),
                          Text('${taxaAA.toStringAsFixed(2)} %',
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
                            currentValue.value,
                            monthValue,
                            mounth,
                            taxaAA,
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

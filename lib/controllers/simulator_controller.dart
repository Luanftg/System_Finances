import 'dart:math';

import 'package:flutter/material.dart';
import 'package:system_finances/repositories/auth_repository.dart';
import 'package:system_finances/repositories/simulator_repository.dart';
import 'package:system_finances/state/simulator_state.dart';

import '../models/valor_futuro.dart';
import '../models/valor_simulado.dart';

class SimulatorController extends ValueNotifier<SimulatorState> {
  final SimulatorRepository _simulatorRepository;
  final AuthRepository _authRepository;

  SimulatorController(this._simulatorRepository, this._authRepository)
      : super(SimulatorInitialState());

  ValueNotifier<ValorFuturo?> valorFuturo = ValueNotifier(null);
  ValueNotifier<ValorSimulado?> valorSimulado = ValueNotifier(null);
  String riskLabel = '';
  double riskValue = 0;
  String year = '';
  double balance = 0;
  int ano = DateTime.now().year;

  SimulatorState get state => value;

  Future<void> addOrUpdateSimulator(
    double initialValue,
    double mounthValue,
    int mounth,
    double taxaAA,
  ) async {
    value = SimulatorLoadingState();
    final userId = _authRepository.currentUser?.uid;
    final valorSimulado = ValorSimulado(
      initialValue: initialValue,
      mounthValue: mounthValue,
      month: mounth,
      taxaAA: taxaAA,
      userId: userId ?? '',
    );
    await _simulatorRepository.addOrUpdateSimulatorValue(valorSimulado);
    value = SimulatorSucessState(valorSimulado);
  }

  Future<void> fetchSimulator() async {
    value = SimulatorLoadingState();
    final userId = _authRepository.currentUser?.uid;
    final result = await _simulatorRepository.getList(userId ?? '');
    if (result.isNotEmpty) {
      this.valorSimulado.value = result.first;
      setRisk(this.valorSimulado.value?.month ?? 12);
      setFutureValue();
      value = SimulatorSucessState(this.valorSimulado.value!);
    }

    var valorSimulado = ValorSimulado(
        initialValue: 0,
        mounthValue: 0,
        month: 12,
        taxaAA: 13.5,
        userId: userId!);
    value = SimulatorSucessState(valorSimulado);
  }

  static double valorFuturoDosAportesMensais(
      double aportesMensais, double taxaAoMes, int prazoAoMes) {
    double taxaAM = taxaAoMes / 100;
    double fator = (pow((1 + taxaAM), prazoAoMes) - 1).toDouble();
    double result = aportesMensais * (1 + taxaAM) * (fator / taxaAM);
    return result;
  }

  static double valorFuturoDoAporteInicial(
      double aporteInicial, double taxaAoMes, int prazoAoMes) {
    return aporteInicial * pow((1 + taxaAoMes / 100), prazoAoMes).toDouble();
  }

  static double converteTaxaAnualParaMensal(double taxaAnual) {
    var result =
        ((pow((1 + (taxaAnual / 100)), ((1 / 12))) - 1) * 100).toDouble();
    return result;
  }

  static ValorFuturo pegaValorFuturoERendimentoTotal(double aporteInicial,
      double aportesMensais, double taxaAoAno, int prazoMeses) {
    final taxaConvertidaAoMes = converteTaxaAnualParaMensal(taxaAoAno);
    final vFAM = valorFuturoDosAportesMensais(
        aportesMensais, taxaConvertidaAoMes, prazoMeses);
    final vFAI = valorFuturoDoAporteInicial(
        aporteInicial, taxaConvertidaAoMes, prazoMeses);
    final totalValorFuturo = vFAI + vFAM;
    final rendimentoTotal =
        (vFAI - aporteInicial) + (vFAM - aportesMensais * prazoMeses);
    return ValorFuturo(
      valorFuturoAportesMensais: vFAM,
      valorFuturoAporteInicial: vFAI,
      totalValorFuturo: totalValorFuturo,
      rendimentoTotal: rendimentoTotal,
    );
  }

  void setRisk(int month) {
    switch (month) {
      case 12:
        riskLabel = 'Conservador - 1 ano';
        riskValue = 0;
        break;
      case 60:
        riskLabel = 'Moderado - 5 anos';
        riskValue = 1;
        break;
      case 120:
        riskLabel = 'Arriscado - 10 anos';
        riskValue = 2;
        break;
      default:
        break;
    }
  }

  void changeRisk(double value) {
    riskValue = value;
    var valorSimuladoController = valorSimulado.value!;
    if (riskValue == 0) {
      riskLabel = 'Conservador - 1 ano';
      valorSimuladoController.month = 12;
      setFutureValue();
      year = (ano + valorSimuladoController.month / 12).toStringAsFixed(0);
    } else if (riskValue == 1) {
      riskLabel = 'Moderado - 5 anos';
      valorSimuladoController.month = 60;
      setFutureValue();
      year = (ano + valorSimuladoController.month / 12).toStringAsFixed(0);
    } else {
      riskLabel = 'Arriscado - 10 anos';
      valorSimuladoController.month = 120;
      setFutureValue();
      year = (ano + valorSimuladoController.month / 12).toStringAsFixed(0);
    }
  }

  void changeInitialValue(double value) {
    valorSimulado.value?.initialValue = value;
    setFutureValue();
  }

  void changeMonthValue(double value) {
    valorSimulado.value?.mounthValue = value;
    setFutureValue();
  }

  void setFutureValue() {
    valorFuturo.value = SimulatorController.pegaValorFuturoERendimentoTotal(
        valorSimulado.value?.initialValue ?? 0,
        valorSimulado.value?.mounthValue ?? 0,
        valorSimulado.value?.taxaAA ?? 0,
        valorSimulado.value?.month ?? 0);
    balance = valorFuturo.value?.totalValorFuturo ?? 0;
  }
}

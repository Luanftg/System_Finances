import 'dart:math';

import 'package:flutter/material.dart';
import 'package:system_finances/repositories/auth_repository.dart';
import 'package:system_finances/repositories/simulator_repository.dart';
import 'package:system_finances/state/simulator_state.dart';

import '../models/valor_futuro.dart';
import '../models/valor_simulado.dart';

class SimulatorController {
  final SimulatorRepository _simulatorRepository;
  final AuthRepository _authRepository;
  SimulatorController(this._simulatorRepository, this._authRepository);

  final notifier = ValueNotifier<SimulatorState>(SimulatorInitialState());
  SimulatorState get state => notifier.value;

  Future<void> addSimulator(
    double initialValue,
    double mounthValue,
    int mounth,
    double taxaAA,
  ) async {
    notifier.value = SimulatorLoadingState();
    final userId = _authRepository.currentUser?.uid;
    final valorSimulado = ValorSimulado(
      initialValue: initialValue,
      mounthValue: mounthValue,
      mounth: mounth,
      taxaAA: taxaAA,
      userId: userId ?? '',
    );
    await _simulatorRepository.addSimulatorValue(valorSimulado);
    notifier.value = SimulatorSucessState(valorSimulado);
  }

  Future<ValorSimulado> getList() async {
    notifier.value = SimulatorLoadingState();
    final userId = _authRepository.currentUser?.uid;
    final result = await _simulatorRepository.getList(userId ?? '');
    notifier.value = SimulatorSucessState(result.first);
    return result.first;
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
}

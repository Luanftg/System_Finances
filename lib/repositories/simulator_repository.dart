import '../models/valor_simulado.dart';

abstract class SimulatorRepository {
  Future<List<ValorSimulado>> getList(String userId);
  Future<void> addSimulatorValue(ValorSimulado valorSimulado);
}

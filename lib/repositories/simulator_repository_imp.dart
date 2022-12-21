import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:system_finances/repositories/simulator_repository.dart';

import '../models/valor_simulado.dart';

class SimulatorRepositoryImp implements SimulatorRepository {
  FirebaseFirestore get storage => FirebaseFirestore.instance;

  @override
  Future<List<ValorSimulado>> getList(String userId) async {
    final result = await storage
        .collection('simulator')
        .where('userId', isEqualTo: userId)
        .get();

    final List<ValorSimulado> simulatorList = List.from(
        result.docs.map((document) => ValorSimulado.fromMap(document.data())));

    return simulatorList;
  }

  @override
  Future<void> addSimulatorValue(ValorSimulado valorSimulado) async {
    await storage.collection('simulator').add(valorSimulado.toMap());
  }
}

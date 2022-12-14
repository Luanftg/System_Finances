import 'package:flutter/material.dart';
import 'package:system_finances/constants/app_text_styles.dart';

import '../../constants/app_colors.dart';

class SimulatorPage extends StatefulWidget {
  const SimulatorPage({super.key});

  @override
  State<SimulatorPage> createState() => _SimulatorPageState();
}

class _SimulatorPageState extends State<SimulatorPage> {
  ValueNotifier<double> currentValue = ValueNotifier(0.0);
  double monthValue = 0;
  double riskValue = 0;
  String riskLabel = 'Conservador';
  String year = '2024';
  double totalPoupanca = 0;
  double totalSelic = 0;
  double balance = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black38,
      ),
      backgroundColor: AppColors.black38,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            //const SizedBox(height: 8),
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
                    return '${value.round()} reais';
                  },
                  activeColor: AppColors.primary,
                  label: currentValue.value.round().toString(),
                  value: currentValue.value,
                  onChanged: (double value) {
                    setState(() {
                      currentValue.value = value;
                      balance = value;
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
                    });
                  }),
            ),
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
                        riskLabel = 'Conservador';
                      } else if (riskValue == 1) {
                        riskLabel = 'Estrategista';
                      } else {
                        riskLabel = 'Arriscado';
                      }
                    });
                  }),
            ),
            const SizedBox(
              height: 96,
            ),
            Text('Em $year, você terá:', style: AppTextStyles.whiteCaption),
            Text('R\$ $balance', style: AppTextStyles.largeCaption),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Poupança:', style: AppTextStyles.whiteLabel),
                SizedBox(
                  width: 8,
                ),
                Text('Tesouro Selic:', style: AppTextStyles.whiteLabel),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('R\$ $totalPoupanca', style: AppTextStyles.whiteLabel),
                Text('R\$ $totalSelic', style: AppTextStyles.whiteLabel),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Faça seu dinheiro render de verdade!',
                style: AppTextStyles.whiteLabel),
            const SizedBox(height: 32),
            ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Adicionar'),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.arrow_forward))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

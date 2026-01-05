import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:nuestra_app/features/stats/models/stat_card_model.dart';
import 'package:gap/gap.dart';

void main() {
  initializeDateFormatting('es_ES', '').then((_) => runApp(const MyApp()));
}

final List<StatCardModel> statCards = [
  StatCardModel(
    type: "date-from",
    date: DateTime(2024, 12, 20),
    title: "Aniversario",
    id: "2",
  ),
  StatCardModel(
    type: "date-to",
    date: DateTime(2025, 3, 8),
    title: "Cumple Benja",
    id: "1",
  ),
  StatCardModel(type: "amount", amount: 1000, title: "Salidas", id: "3"),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nuestra App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Nuestra App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: Text("Stats :)"),
          ),
          const Gap(12),
          SizedBox(
            height: 120,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemCount: statCards.length,
              itemBuilder: (context, index) {
                final statCard = statCards[index];
                return StatCard(statCard: statCard);
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final StatCardModel statCard;
  const StatCard({super.key, required this.statCard});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(statCard.title),
            const Gap(8),
            if (statCard.type == "date-from")
              Text(statCard.date?.toString() ?? "No date"),
            if (statCard.type == "date-to")
              Text(statCard.date?.toString() ?? "No date"),
            if (statCard.type == "amount")
              Text(statCard.amount?.toString() ?? "No amount"),
          ],
        ),
      ),
    );
  }
}

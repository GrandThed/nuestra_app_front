import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';

/// Calendar screen - Unified timeline and calendar
class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.calendar),
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              // TODO: Go to today
            },
          ),
          IconButton(
            icon: const Icon(Icons.view_agenda_outlined),
            onPressed: () {
              // TODO: Toggle view (calendar/timeline)
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: 64,
              color: AppColors.calendar,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.emptyEvents,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text('Agrega tu primer evento'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add event
        },
        backgroundColor: AppColors.calendar,
        child: const Icon(Icons.add),
      ),
    );
  }
}

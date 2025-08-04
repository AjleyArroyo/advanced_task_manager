import 'package:advanced_task_manager/countries/presentation/providers/countries_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountryListPage extends ConsumerWidget {
  const CountryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countriesAsync = ref.watch(countryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Países', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: countriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (countries) => ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, index) {
            final country = countries[index];
            return ListTile(
              leading: Text(country.emoji, style: TextStyle(fontSize: 40)),
              title: Text(country.name),
              subtitle: Text(country.code),
            );
          },
        ),
      ),
    );
  }
}

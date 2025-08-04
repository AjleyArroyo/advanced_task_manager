import 'package:advanced_task_manager/countries/domain/entities/countries_entities.dart';
import 'package:advanced_task_manager/countries/presentation/pages/countries_list_page.dart';
import 'package:advanced_task_manager/countries/presentation/providers/countries_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('CountryListPage muestra lista de países', (tester) async {
    // Datos de prueba
    final mockCountries = [
      Country(emoji: '🇧🇴', name: 'Bolivia', code: 'BO'),
      Country(emoji: '🇨🇱', name: 'Chile', code: 'CL'),
    ];

    // Override para el provider que retorna la lista mock
    final overrideProvider = countryProvider.overrideWith(
      (ref) async => mockCountries,
    );

    // Construir widget con ProviderScope y el override
    await tester.pumpWidget(
      ProviderScope(
        overrides: [overrideProvider],
        child: const MaterialApp(home: CountryListPage()),
      ),
    );

    await tester.pumpAndSettle();

    // Validar que aparezcan los datos mock
    expect(find.text('🇧🇴'), findsOneWidget);
    expect(find.text('🇨🇱'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(2));
  });

  testWidgets('CountryListPage muestra loading mientras carga', (tester) async {
    final overrideProvider = countryProvider.overrideWith(
      (ref) => Future.delayed(const Duration(seconds: 1), () => <Country>[]),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [overrideProvider],
        child: const MaterialApp(home: CountryListPage()),
      ),
    );

    // Pump solo una vez para que inicie la carga pero no termine
    await tester.pump();

    // Validar que se muestre el indicador de carga
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('CountryListPage muestra error si falla', (tester) async {
    final overrideProvider = countryProvider.overrideWith(
      (ref) => Future.error(Exception('Error de prueba')),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [overrideProvider],
        child: const MaterialApp(home: CountryListPage()),
      ),
    );

    // Esperar que se actualice el widget tras el error
    await tester.pumpAndSettle();

    // Validar que se muestre el mensaje de error
    expect(find.textContaining('Error'), findsOneWidget);
  });
}

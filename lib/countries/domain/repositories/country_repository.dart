import 'package:advanced_task_manager/countries/domain/entities/countries_entities.dart';

abstract class CountryRepository {
  Future<List<Country>> getCountries();
}

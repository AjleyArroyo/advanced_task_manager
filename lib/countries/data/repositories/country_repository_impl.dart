import 'package:advanced_task_manager/countries/data/datasources/countries_datasources.dart';
import 'package:advanced_task_manager/countries/domain/entities/countries_entities.dart';
import 'package:advanced_task_manager/countries/domain/repositories/countries_repositories.dart';

class CountryRepositoryImpl implements CountryRepository {
  final CountryGraphDataSource remote;

  CountryRepositoryImpl(this.remote);

  @override
  Future<List<Country>> getCountries() => remote.getCountries();
}

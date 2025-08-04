import 'package:advanced_task_manager/config/graphql/graphql_client.dart';
import 'package:advanced_task_manager/countries/data/datasources/country_graph_datasource.dart';
import 'package:advanced_task_manager/countries/data/repositories/countries_data_repositories.dart';
import 'package:advanced_task_manager/countries/domain/entities/countries_entities.dart';
import 'package:advanced_task_manager/countries/domain/repositories/countries_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final graphqlClientProvider = Provider<GraphQLClient>((ref) {
  return getGraphQLClient();
});

final countryRemoteDataSourceProvider = Provider<CountryGraphDataSource>((ref) {
  final client = ref.watch(graphqlClientProvider);
  return CountryRemoteDataSourceImpl(client);
});

final countryRepositoryProvider = Provider<CountryRepository>((ref) {
  final remote = ref.watch(countryRemoteDataSourceProvider);
  return CountryRepositoryImpl(remote);
});

final countryProvider = FutureProvider<List<Country>>((ref) async {
  final repo = ref.watch(countryRepositoryProvider);
  return await repo.getCountries();
});

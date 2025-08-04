import 'package:advanced_task_manager/countries/data/models/countries_models.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class CountryGraphDataSource {
  Future<List<CountryModel>> getCountries();
}

class CountryRemoteDataSourceImpl implements CountryGraphDataSource {
  final GraphQLClient client;

  CountryRemoteDataSourceImpl(this.client);

  @override
  Future<List<CountryModel>> getCountries() async {
    const query = '''
      query {
        countries {
          code
          name
          emoji
        }
      }
    ''';

    final result = await client.query(QueryOptions(document: gql(query)));

    if (result.hasException) throw Exception(result.exception.toString());

    final List countries = result.data?['countries'] ?? [];

    return countries.map((json) => CountryModel.fromJson(json)).toList();
  }
}

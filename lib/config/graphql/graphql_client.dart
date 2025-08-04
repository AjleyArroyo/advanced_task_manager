import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLClient getGraphQLClient() {
  final httpLink = HttpLink('https://countries.trevorblades.com');

  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );
}

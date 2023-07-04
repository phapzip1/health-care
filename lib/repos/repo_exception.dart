class GenericDBException implements Exception {}
class QueryDBException implements Exception {
  final String message;
  const QueryDBException(this.message);
}
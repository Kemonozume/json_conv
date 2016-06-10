part of json_god;

class ValidationError implements Exception {
  final Schema schema;
  final invalidData;
  final String cause;

  const ValidationError(String this.cause, this.invalidData,
      Schema this.schema);
}
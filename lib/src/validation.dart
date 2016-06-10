part of json_god;

class JsonValidationError implements Exception {
  final Schema schema;
  final invalidData;
  final String cause;

  const JsonValidationError(String this.cause, this.invalidData,
      Schema this.schema);
}

class WithSchema {
  final Map schema;

  const WithSchema(Map this.schema);
}

class WithSchemaUrl {
  final String schemaUrl;

  const WithSchemaUrl(String this.schemaUrl);
}
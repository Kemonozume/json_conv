part of json_god;

deserialize(String json, {Type outputType, Schema schema, bool deserializeDates: true}) {
  var deserialized = JSON.decode(json);

  if (debug)
    print("Deserializing the following data: $deserialized");

  if (schema != null) {

  }
}
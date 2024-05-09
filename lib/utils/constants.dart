class Environment {

  static Uri baseUrl = Uri.http("192.168.1.23:8000");
  static Uri baseApi = baseUrl.resolve("api");

  static Map<String, dynamic> database = {
    "host": "192.168.1.23",
    "port": 3306,
    "userName": "root",
    "password": "root",
    "databaseName": "tricountdb"
  };
}
class Environment {
  static Map<String, String> auth = {
    "url": "https://tcejenenitesxncyxdxe.supabase.co",
    "anonKey": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRjZWplbmVuaXRlc3huY3l4ZHhlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk2OTU1MDAsImV4cCI6MjAxNTI3MTUwMH0.2ZYwrcJEwtcBxP5Wggb5ggE6wZ5iGzWNRSzlkjaWgPY"
  };

  static Uri baseUrl = Uri.http("192.168.1.23:8000", "/api");

  static Map<String, dynamic> database = {
    "host": "192.168.1.28",
    "port": 3306,
    "userName": "root",
    "password": "root",
    "databaseName": "tricountdb"
  };
}
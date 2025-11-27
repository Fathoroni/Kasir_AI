class ApiClient {
  final String baseUrl;

  ApiClient({this.baseUrl = 'https://api.example.com'});

  Future<dynamic> get(String endpoint) async {
    // Placeholder for GET request
    await Future.delayed(const Duration(milliseconds: 500));
    return null;
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    // Placeholder for POST request
    await Future.delayed(const Duration(milliseconds: 500));
    return null;
  }
}

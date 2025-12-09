import 'api_client.dart';

class TransactionService {
  final ApiClient _apiClient = ApiClient();

  Future<bool> createTransaction(Map<String, dynamic> data) async {
    try {
      // In a real app, we would check the response status
      await _apiClient.post('/transactions', data);
      return true;
    } catch (e) {
      // Handle error logging here
      return false;
    }
  }
}

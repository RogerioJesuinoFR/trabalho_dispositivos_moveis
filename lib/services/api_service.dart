import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<String> fetchHealthTip() async {
    try {
      // Exemplo fictício (não existe realmente essa URL)
      final response = await http.get(Uri.parse('https://api.adviceslip.com/advice'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Exemplo de estrutura esperada da API: {"slip":{"advice":"Dica de saúde aqui"}}
        return data['slip']['advice'] ?? 'Mantenha-se saudável!';
      }
      return 'Falha ao carregar dica.';
    } catch (e) {
      return 'Erro ao buscar dica.';
    }
  }
}

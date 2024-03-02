import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class FileStorage {
  final String host;

  FileStorage(this.host);

  Future<String> upload(File file) async {
    var request = http.MultipartRequest('POST', Uri.parse('$host/upload.php'));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    var response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('File upload failed with status ${response.statusCode}.');
    }
    String filename = basename(file.path);
    return getUrl(filename);
  }

  Future<String> getUrl(String filename) async {
    var response = await http.get(Uri.parse('$host/geturl.php?filename=$filename'));
    if (response.statusCode != 200) {
      throw Exception('Failed to get URL with status ${response.statusCode}.');
    }
    return jsonDecode(response.body);
  }
}

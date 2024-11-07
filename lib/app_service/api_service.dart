import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../app_helpers/api_helper.dart';
import '../app_helpers/constant.dart';

class ApiService {




   retrieveTask(String phoneNumber, BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/task?phone_number=$phoneNumber'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
       return data;
      } else {
        _showError(context, 'Failed to retrieve task. Status: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      _handleException(context, e, stackTrace);
    }
  }

  Future<void> _requestPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
    status = await Permission.photos.status;
    if (!status.isGranted) {
      await Permission.photos.request();
    }
  }


   storeTask(String taskName, String description,File image, BuildContext context) async {
    try {
      // Request permissions if needed
      await _requestPermission();



      if (image == null) {
        _showError(context, "No image selected.");
        return;
      }


      if (!image.path.endsWith('.jpg') && !image.path.endsWith('.png')) {
        _showError(context, "Please select a JPG or PNG image.");
        return;
      }

      // Prepare the HTTP request
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/task/store'));
      request.fields['user_name'] = "ibadkhan";
      request.fields['phone_number'] = "03109598751";
      request.fields['task_name'] = taskName;
      request.fields['description'] = description;

      // Add the image to the request
      request.files.add(await http.MultipartFile.fromPath('images[]', image.path));

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // Handle response
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);


     return json;




      } else {
        _showError(context, 'Failed to store task. Status: ${response.statusCode}');
      }
    } catch (e, stackTrace) {

      _handleException(context, e, stackTrace);
    }
  }


  updateStatus(int taskId, bool isComplete, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/task/status-update/$taskId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'is_complete': isComplete ? 1 : 0}),
      );

      if (response.statusCode == 200) {
        // Handle successful response

        return jsonDecode(response.body);

      } else {
        _showError(context, 'Failed to update task status. Status: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      _handleException(context, e, stackTrace);
    }
  }

    deleteTask(int taskId, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/task/delete/$taskId'),
      );

      if (response.statusCode == 200) {
         return jsonDecode(response.body);
      } else {
        _showError(context, 'Failed to delete task. Status: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      _handleException(context, e, stackTrace);
    }
  }

  void _handleException(BuildContext context, Object e, StackTrace stackTrace) {
    if (e is SocketException) {
      _showError(context, 'Network error. Please check your internet connection.');
    } else if (e is FormatException) {
      _showError(context, 'Response format error. Unable to process data.');
    } else if (e is HttpException) {
      _showError(context, 'Server error. Please try again later.');
    } else {
      _showError(context, 'Unexpected error: $e');
      // Optionally, you could log the stack trace or send it to a logging service
      print(stackTrace);
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

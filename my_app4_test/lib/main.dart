import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Maps Photos'),
        ),
        body: PhotoWidget(),
      ),
    );
  }
}

class PhotoWidget extends StatefulWidget {
  @override
  _PhotoWidgetState createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  final String apiKey = 'MY API KEY'; // 替換為你的API Key
  String? photoUrl;

  @override
  void initState() {
    super.initState();
    fetchPhoto();
  }

  Future<void> fetchPhoto() async {
    final String location = '24.443930,118.432010'; // 地點經緯度
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=Tourist%20Attraction&inputtype=textquery&locationbias=circle:2000@$location&fields=photos&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final photos = data['candidates'][0]['photos'];
      if (photos != null && photos.isNotEmpty) {
        String photoReference = photos[0]['photo_reference'];
        String photoUrl = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$apiKey';
        setState(() {
          this.photoUrl = photoUrl;
        });
      }
    } else {
      throw Exception('Failed to load photo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: photoUrl != null
          ? Image.network(photoUrl!)
          : CircularProgressIndicator(), // 如果正在加載，則顯示進度指示器
    );
  }
}

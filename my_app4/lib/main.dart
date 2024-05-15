import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class DataManager {
  final client = http.Client();
  final String url =
      "https://media.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json";

  Future<dynamic> fetchData() async {
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // 尝试使用 Utf8Decoder 来解码响应体
      final utf8decoder = Utf8Decoder();
      final body = utf8decoder.convert(response.bodyBytes);
      return json.decode(body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class MyApp extends StatelessWidget {
  final DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Data Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('API Data Example'),
        ),
        body: Center(
          child: FutureBuilder(
            future: dataManager.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('正在加载数据...'); // 添加调试语句
                return CircularProgressIndicator(); // 加载中的UI
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // 错误时的UI
              } else {
                print('数据加载完成: ${snapshot.data}'); // 如果数据成功加载，将数据显示出来
                final dynamic data = snapshot.data; // 将数据保存在dynamic变量中

                if (data != null) {
                  final List<dynamic> dataList = data['XML_Head']['Infos']['Info'];
                  return ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      final Map<String, dynamic> item = dataList[index];
                      return ListTile(
                        title: Text(item['Region']+'-'+item['Name'] ?? ''),
                        subtitle: Text(item['Toldescribe'] ?? ''),
                      );
                    },
                  );
                } else {
                  return Text('No data available');
                }
              }
            },
          ),
        ),
      ),
    );
  }
}

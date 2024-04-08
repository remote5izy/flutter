import 'dart:math'; // 導入 Random 類
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CheckBoxPage(),
    );
  }
}

class CheckBoxPage extends StatefulWidget {
  @override
  _CheckBoxPageState createState() => _CheckBoxPageState();
}

class _CheckBoxPageState extends State<CheckBoxPage> {
  String? selectedActivity; // 用於保存選中的活動類型
  List<String> allItems = ['研討會', '成果論壇', '新生說明會'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CheckBox Demo'), // 標題欄標題
      ),
      body: ListView.builder(
        itemCount: allItems.length,
        itemBuilder: (context, index) {
          return RadioListTile(
            title: Text(allItems[index]), // 顯示每個選項的標題
            value: allItems[index],
            groupValue: selectedActivity,
            onChanged: (value) {
              setState(() {
                selectedActivity = value as String?;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedActivity != null) {
            // 只有在選中了一個活動類型時才能跳轉
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticlePage(
                  selectedActivity: selectedActivity!,
                  articleContent: getArticleContent(selectedActivity!),
                ),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('請選擇一個活動類型'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('確定'),
                  ),
                ],
              ),
            );
          }
        },
        child: Icon(Icons.arrow_forward), // 浮動按鈕上的圖標
      ),
    );
  }

  String getArticleContent(String selectedActivity) {
    final Random random = Random();
    String articleContent = "各位";

    if (selectedActivity == '研討會') {
      final randomIndex = random.nextInt(2); // 隨機生成 0 或 1
      if (randomIndex == 0) {
        articleContent += "貴賓/先進";
      } else {
        articleContent += "貴賓/學者";
      }
    } else if (selectedActivity == '成果論壇') {
      articleContent += "貴賓/師長/同學";
    } else if (selectedActivity == '新生說明會') {
      articleContent += "師長/學弟妹";
    }

    articleContent += "，大家好!";
    return articleContent;
  }
}

class ArticlePage extends StatelessWidget {
  final String selectedActivity;
  final String articleContent;

  ArticlePage({required this.selectedActivity, required this.articleContent});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('文章'), // 文章頁面標題
        ),
        body: Row(
          children: [
            Expanded(
              child: ListTile(
                title: Container(
                  child: Text(selectedActivity), // 在这里显示选中的活动类型
                ),
                subtitle: Container(
                  child: Text('9:00~10:00'),
                ),
              ),
            ),
            VerticalDivider(
              color: Colors.black, // 垂直分隔线颜色
              thickness: 2.0, // 垂直分隔线厚度
              width: 0.0, // 垂直分隔线宽度
            ),
            Expanded(
              flex: 3,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    child: ListTile(
                      title: Container(
                        child: Text('項目 ${index + 1}'),
                      ),
                      subtitle: Container(
                        child: Text(articleContent), // 在这里显示文章内容
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  // 在這裡建構分隔符
                  return Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                  );
                },
                itemCount: 10, // 假設有10個項目
              ),
            ),
          ],
        ),
      ),
    );
  }
}

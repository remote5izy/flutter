import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: 'Roboto', // 使用Roboto字體
      ),
      home: CheckBoxPage(),
    );
  }
}

class CheckBoxPage extends StatefulWidget {
  @override
  _CheckBoxPageState createState() => _CheckBoxPageState();
}

class _CheckBoxPageState extends State<CheckBoxPage> {
  String? selectedActivity;
  List<String> selectedOptions = [];
  Map<String, List<String>> activityOptions = {
    '校慶': ['催場', '表演', '開場', '介紹貴賓', '致詞', '大合照', '頒獎', '結束'],
    '研討會/成果論壇': ['催場', '開場', '介紹貴賓', '致詞', '大合照', '專題演講', '中場休息', '頒獎', '結束'],
    '新生說明會': ['催場', '表演', '開場', '致詞', '大合照', '中場休息', '結束']
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('司儀稿範例生成'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              children: activityOptions.keys.map((String value) {
                return TextButton(
                  onPressed: () {
                    setState(() {
                      selectedActivity = value;
                      selectedOptions.clear();
                    });
                  },
                  child: Text(
                    value,
                    style: TextStyle(
                      color: selectedActivity == value ? Colors.purple : null,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) =>
                          selectedActivity == value ? Colors.orange[500] : null,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20), // 增加垂直間距
            if (selectedActivity != null)
              Expanded(
                child: ListView.builder(
                  itemCount: activityOptions[selectedActivity!]!.length,
                  itemBuilder: (context, index) {
                    String option = activityOptions[selectedActivity!]![index];
                    return CheckboxListTile(
                      title: Text(option),
                      value: selectedOptions.contains(option),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value ?? false) {
                            selectedOptions.add(option);
                          } else {
                            selectedOptions.remove(option);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedActivity != null && selectedOptions.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticlePage(
                  selectedActivity: selectedActivity!,
                  selectedOptions: selectedOptions,
                  articleContent: getArticleContent(selectedOptions),
                ),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('請選擇活動類型和司儀稿要呈現的內容'),
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
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  List<String> getArticleContent(List<String> selectedOptions) {
    List<String> articleContentList = [];
    for (String option in selectedOptions) {
      if (option == '催場') {
        articleContentList.add("尊敬的各位貴賓，歡迎蒞臨「[活動名稱]」。請留意，我們即將於[時間]後正式開始活動。在活動開始之前，請您注意以下重要事項...");
      } else if (option == '表演') {
        articleContentList.add("尊敬的各位貴賓，現在請您欣賞我們為大家精心準備的開場表演。今天，我們有幸邀請到了一個令人驚嘆的表演，由一群充滿熱情和才華的藝術家呈現。首先，我們將帶來一段動人心弦的音樂表演。請大家準備好感受音符的魔力，讓我們一起沉浸在美妙的音樂中。接下來，我們將欣賞一場令人目眩神迷的舞蹈表演。這將是一場充滿活力和靈感的舞蹈，帶給大家無限的驚喜和感動。讓我們用熱烈的掌聲歡迎我們的表演者，讓他們感受到我們的熱情和支持。現在，請讓我們將目光聚焦在舞台上，準備享受這場精彩絕倫的開場表演！讓音樂與舞蹈在這一刻開啟我們活動的序幕！");
      } else if (option == '開場') {
        articleContentList.add("尊敬的各位貴賓，歡迎蒞臨[活動名稱]，活動現在正式開始。");
      } else if (option == '介紹貴賓') {
        articleContentList.add("接下來介紹與會貴賓，首先歡迎OOO");
      } else if (option == '致詞') {
        articleContentList.add("貴賓致詞，首先用熱烈的掌聲歡迎OOO上台為我們致詞，謝謝OOO");
      } else if (option == '大合照') {
        articleContentList.add("接下來是大合照時間，讓我們攜手合影，共同留下這個難忘的時刻。3、2、1！非常感謝各位貴賓的配合，讓我們共同留下這個珍貴的瞬間。祝大家都能保持美好的笑容！");
      } else if (option == '專題演講') {
        articleContentList.add("首先第一場專題演講，讓我們有請OOO為我們擔任引言人，掌聲歡迎OOO");
      } else if (option == '中場休息') {
        articleContentList.add("上午[活動]圓滿告一段落，中午為貴賓準備餐盒，工作人員會招呼各位貴賓前往領餐...謝謝您的配合。");
      } else if (option == '頒獎') {
        articleContentList.add("現在，請頒獎人上台，為我們的得獎者頒獎。同時，請得獎者上台接受殊榮。");
      } else if (option == '結束') {
        articleContentList.add("感謝各位貴賓的熱情參與，今天的活動已經圓滿結束。讓我們一起為所有的演講者和得獎者送上最熱烈的掌聲！希望大家在這次活動中有所收穫，期待再次相聚。祝大家一路順風，再見！");
      }
    }
    return articleContentList;
  }
}

class ArticlePage extends StatelessWidget {
  final String selectedActivity;
  final List<String> selectedOptions;
  final List<String> articleContent;

  ArticlePage({
    required this.selectedActivity,
    required this.selectedOptions,
    required this.articleContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedActivity),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: selectedOptions.length,
                itemBuilder: (context, index) {
                  String option = selectedOptions[index];
                  return Text(option);
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                  );
                },
              ),
            ),
            VerticalDivider(
              color: Colors.black,
              thickness: 2.0,
            ),
            Expanded(
              flex: 3,
              child: ListView.separated(
                itemCount: articleContent.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    subtitle: Text(
                      articleContent[index],
                      style: TextStyle(fontSize: 16.0),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

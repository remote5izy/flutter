import 'package:flutter/material.dart';

void main() {
  runApp(MainPageApp());
}

class MainPageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '待辦事項',
      theme: ThemeData(
        primarySwatch: Colors.red,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          accentColor: Colors.black, 
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的待辦事項'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.notifications),
                Icon(Icons.access_alarm),
                Icon(Icons.notifications),
                Icon(Icons.access_alarm),
                Icon(Icons.notifications),
                Icon(Icons.access_alarm),
                Icon(Icons.notifications),
                Icon(Icons.access_alarm),
              ],
            ),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  color: Colors.grey,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 4,
                      color: Theme.of(context).colorScheme.secondary,
                      child: ListTile(
                        title: Text(
                          '3/22 帶領查經: 約翰福音21:15-25',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JohnIntroductionPage(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 4,
                      color: Theme.of(context).colorScheme.secondary,
                      child: ListTile(
                        title: Text(
                          '3/26 CPE考試',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Cpe(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 4,
                      color: Theme.of(context).colorScheme.secondary,
                      child: ListTile(
                        title: Text(
                          '4/14 舞蹈編排展示: 祢使我雙腳跳舞',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChoreographyPage(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 4,
                      color: Theme.of(context).colorScheme.secondary,
                      child: ListTile(
                        title: Text(
                          '5/25、26 外語領隊導遊考試: 口試',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TourGuideExam(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class JohnIntroductionPage extends StatefulWidget {
  @override
  _JohnIntroductionPageState createState() => _JohnIntroductionPageState();
}

class _JohnIntroductionPageState extends State<JohnIntroductionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3/22 帶領查經'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: '中文'),
            Tab(text: 'Bilingual'),
            Tab(text: '介紹'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          JohnIntroductionChinesePage(),
          JohnIntroductionBilingualPage(),
          JohnIntroduction(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class JohnIntroductionChinesePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '约翰福音 21:15-25',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            '15 耶穌對西門彼得說：“約翰的兒子西門，你愛我比這些更深吗？”彼得說：“主啊，是的，你知道我愛你。”耶穌對他說：“你喂養我的羊。”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '16 耶穌第二次又對他說：“約翰的兒子西門，你愛我吗？”彼得說：“主啊，是的，你知道我愛你。”耶穌說：“你牧養我的羊。”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '17 第三次對他說：“約翰的兒子西門，你愛我吗？”彼得因為耶穌第三次對他說“你愛我吗”，就愁煩，對耶穌說：“主啊，你是無所不知的，你知道我愛你。”耶穌對他說：“你喂養我的羊。”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '18 “我實實在在地告訴你，你年少的時候自己束上帶子，隨意往來，但年老的時候，你要伸出手來，別人要把你束上，帶你到不願意去的地方。”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '19 耶穌說這話，是指著彼得要怎樣死，榮耀　神。說了這話，就對他說：“你跟從我吧。”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '20 彼得轉過來，看見耶穌所愛的那門徒跟著，就是在晚饭的時候，靠著耶穌胸膛說：“主啊，賣你的是誰？”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '21 彼得看見他，就問耶穌說：“主啊，這人將來如何？”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '22 耶穌對他說：“我若要他等到我來的時候，與你何干？你跟從我吧！”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '23 於是這話傳在弟兄中間，說那門徒不死。其實耶穌不是說他不死，乃是說：“我若要他等到我來的時候，與你何干？”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '24 為這些事作見證，並且記載這些事的，就是這門徒。我們也知道他的見證是真的。',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '25 耶穌所行的事還有許多，若是一一地都寫出來，我想所寫的書，就是世界也容不下了。',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class JohnIntroductionBilingualPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'John 21:15-25',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            '15 耶穌對西門彼得說：“約翰的兒子西門，你愛我比這些更深吗？”彼得說：“主啊，是的，你知道我愛你。”耶穌對他說：“你喂養我的羊。”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '15 When they had finished breakfast, Jesus said to Simon Peter, “Simon, son of John, do you love me more than these?” He said to him, “Yes, Lord; you know that I love you.” He said to him, “Feed my lambs.”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '16 耶穌第二次又對他說：“約翰的兒子西門，你愛我吗？”彼得說：“主啊，是的，你知道我愛你。”耶穌說：“你牧養我的羊。”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '16 He said to him a second time, “Simon, son of John, do you love me?” He said to him, “Yes, Lord; you know that I love you.” He said to him, “Tend my sheep.”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '17 第三次對他說：“約翰的兒子西門，你愛我吗？”彼得因為耶穌第三次對他說“你愛我吗”，就愁煩，對耶穌說：“主啊，你是無所不知的，你知道我愛你。”耶穌對他說：“你喂養我的羊。”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '17 He said to him the third time, “Simon, son of John, do you love me?” Peter was grieved because he said to him the third time, “Do you love me?” and he said to him, “Lord, you know everything; you know that I love you.” Jesus said to him, “Feed my sheep.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '18 “我實實在在地告訴你，你年少的時候自己束上帶子，隨意往來，但年老的時候，你要伸出手來，別人要把你束上，帶你到不願意去的地方。”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '18 “Truly, truly, I say to you, when you were young, you used to dress yourself and walk wherever you wanted, but when you are old, you will stretch out your hands, and another will dress you and carry you where you do not want to go.”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '19 耶穌說這話，是指著彼得要怎樣死，榮耀　神。說了這話，就對他說：“你跟從我吧。”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '19 (This he said to show by what kind of death he was to glorify God.) And after saying this he said to him, “Follow me.”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '20 彼得轉過來，看見耶穌所愛的那門徒跟著，就是在晚餐的時候靠著耶穌胸膛說：“主啊，賣你的是誰？”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '20 Peter turned and saw the disciple whom Jesus loved following them, the one who also had leaned back against him during the supper and had said, “Lord, who is it that is going to betray you?”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '21 彼得看見他，就問耶穌：“主啊，這人將來如何？”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '21 When Peter saw him, he said to Jesus, “Lord, what about this man?”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '22 耶穌對他說：“我若要他等到我來的時候，與你何干？你跟從我吧！”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '22 Jesus said to him, “If it is my will that he remain until I come, what is that to you? You follow me!”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '23 於是這話傳在弟兄中間，說那門徒不死。其實耶穌不是說他不死，乃是說：“我若要他等到我來的時候，與你何干？”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '23 So the saying spread abroad among the brothers that this disciple was not to die; yet Jesus did not say to him that he was not to die, but, “If it is my will that he remain until I come, what is that to you?”',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '24 為這些事作見證的，並且記載這些事的，就是這門徒。我們也知道他的見證是真的。',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '24 This is the disciple who is bearing witness about these things, and who has Written these things, and we know that his testimony is true.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '25 耶穌所行的事，還有許多。若是一一地都寫出來，我想所寫的書，就是世界也容不下了。',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '25 Now there are also many other things that Jesus did. Were every one of them to be Written, I suppose that the world itself could not contain the books that would be Written.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class JohnIntroduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            '這是耶穌和門徒吃完早餐時的對話。祂來到彼得面前，問彼得一個問題：「你愛這些比我更深嗎？」這是一個愛的比較。這裡說的「這些」是什麼呢？沒有講，不過假如從上下文來看，非常直接的讓我們想到，那就是彼得不是帶著其他六個人去打魚嗎？耶穌可能問的就是「你愛去打魚，重操舊業，還是愛我更深呢？」彼得回答：「主啊，我愛祢。」如此這般問了三次。',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '為什麼問三次？好多聖經學者都幾乎同意，因為在「炭火」這個場景，不要忘記喔，「炭火」這個場景在《約翰福音》只出現在彼得三次不認主，和彼得吃早餐之後，這個三次問彼得愛不愛耶穌的對話之中。就在這個劈劈啪啪炭火在燃燒的時候，耶穌再一次問彼得，我相信彼得一定回想到他也在炭火之前否認耶穌三次。',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '假如用這個場景的相連來看的話，那麼耶穌問彼得說「你愛我比這些更深嗎？」的這個「這些」，那涵意就更廣闊了，就不只是重操舊業去打魚了，而是包括彼得在否認主的時候，他所把持住的東西，譬如自己的怯弱；譬如自己的膽小；譬如自己不敢面對現實的種種內心深處的反應。',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '主說：「你願意為我捨下這些嗎？」三次的回答讓我們看見，其實是主給彼得三次的機會，再一次自我肯定來到耶穌面前。彼得是一個奉獻的人，他曾經跟隨耶穌這麼久了，不過，這一次主再給他一個機會，不只給他一個機會，再次肯定跟從主的決心，其實主再一次呼召他，因為剛剛這個段落的最後，耶穌說：「你跟從我吧！」再一次呼召。',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '這個呼召不是第一次，曾經彼得在海邊打魚的時候，耶穌呼召他，於是他把網跟船都捨去了。那麼，一個人跟從主是在愛主的程度上不斷更新，而主對一個人的呼召也不斷的更新，就在這個雙方面不斷增強和更新的過程裡面，我們對主的跟隨就越來越緊密了。這是《約翰福音》二十一章，做一個後記非常重要的一個作用，那就是，讓我們學習更深的愛；更緊密的跟從；更喜樂的與主一起奔走。這是《約翰福音》整卷書最後的一個段落，這個段落當然是承接著上一集所講的內容，上一集講到在那個早餐的炭火之中，耶穌問彼得：「你愛我比這些更深嗎？」彼得回答：「是的，我愛祢。」耶穌就把餵養羊的責任交給彼得，就在這個對話過程結束之後，耶穌再次呼召彼得：「你跟從我。」',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '然後這時候出現了另外一個人，那個人是誰呢？那個人就是在最後晚餐的時候，靠在耶穌胸膛問「賣祢的人是誰？」的那個人。那麼，這卷書也是這個人寫的，那我們都知道了，這就是約翰。',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '換句話說，約翰出現在耶穌和彼得在那裡對話的場景之中，可能耶穌對著彼得講講講，約翰也吃飽了，就走過來了。彼得這個時候，非常的警覺，甚至是非常的敏銳，甚至過敏啊。他就問耶穌：「這個人將來怎麼樣？」',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '約翰將來怎麼樣，跟你什麼關係嗎？',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '所以耶穌就回答說了：「將來這個人，我假如要他等到我回來的時候，又怎麼樣呢？這人與你何干？你跟從我吧。」這就是成為耶穌再次呼召彼得的一句肯定的言語了。',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '彼得不只一次被耶穌呼召，剛剛那個段落還再一次呼召，而這個段落，耶穌再次肯定「你跟從我吧。」，不過這個呼召，是出在怎樣的場景，卻是值得我們今天好好想一想的。',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '這個場景是什麼呢？是彼得三次自我肯定愛主，其實也是三次回想自己曾經否認過主，就在這種心態之中，這是一個非常微妙的心態：一方面知道自己的失敗，一方面現在再次立志跟從主，主也把跟從祂的呼召再次發出。不過人在這個微妙的心態中，常常會落入一個試探，就是：跟人比較的試探。',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '所以當約翰跑出來的時候，彼得馬上問「這個人將來怎麼樣」，耶穌再次教導彼得。當然記載在《約翰福音》有一個重要目的，也是教導歷世歷代所有跟從耶穌的人：再次跟從主，不用比較。所以耶穌不是跟彼得說嗎？「那個人與你什麼關係啊，你跟從我吧。」',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '跟從耶穌是每個人對主的忠誠， 對主的專心，也是對主的仰望和依靠。別人能夠跟從，感謝主，我們為他們一起感謝。不過，每一個人的跟從，都不需要跟別人比較，當我們有這樣的心態的時候，我們才可能持續的跟從。',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class ChoreographyPage extends StatefulWidget {
  @override
  _ChoreographyPageState createState() => _ChoreographyPageState();
}

class _ChoreographyPageState extends State<ChoreographyPage>
    
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('4/14 舞蹈編排展示'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              '祢使我雙腳跳舞',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text(
              '全地都向耶和華發出大聲歡呼，\n用琴歌頌你，用詩歌齊聲讚美你，\n願海和其中所充滿的彭湃歡呼，\n願大水拍手，願諸山一同歡呼。\n你使我的雙腳跳舞，你使我靈歡唱，\n我要全心全意全人全力讚美你，\n你使我的雙腳跳舞，你使我靈歡唱，\n我要全心全意全人全力讚美你。',
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              '詩集：讚美之泉 08 - 讓愛走動，30',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class Cpe extends StatefulWidget {
  @override
  _CpeState createState() => _CpeState();
}

class _CpeState extends State<Cpe> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3/26 CPE考試'),
      ),
      body: Center(
        child: PageView(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '每日一題Leetcode挑戰',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20), 
                  Text(
                    '左右翻動',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Image.asset('assets/images/d1.png'),
            Image.asset('assets/images/d2.png'),
            Image.asset('assets/images/d3.png'),
            Image.asset('assets/images/d4.png'),
            Image.asset('assets/images/d5.png'),
            Image.asset('assets/images/d6.png'),
            Image.asset('assets/images/d7.png'),
          ],
        ),
      ),
    );
  }
}

class TourGuideExam extends StatefulWidget {
  @override
  _TourGuideExamState createState() => _TourGuideExamState();
}

class _TourGuideExamState extends State<TourGuideExam>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5/25、26 外語領隊導遊考試'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: '歷年筆試筆記(左右翻閱)'),
            Tab(text: '歷年口試題目'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Written(),
          Oral(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class Written extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          TourGuide109(),
          TourGuide108(),
          TourGuide107(),
          TourGuide106(),
          TourGuide105(),
        ],
      ),
    );
  }
}

class TourGuide109 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '109年導遊英語記錄',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Concourse - 大堂\n'
            'Lounge - (機場的)候機室\n'
            'Hub - 樞紐\n'
            'Vendor - 小販\n'
            'Valet - 代客泊車員\n'
            'Cashier - 出納員\n'
            'Retailer - 零售商\n'
            'Concierge - 櫃台人員\n'
            'Porter - 行李員\n'
            'Bellhop - (旅館)服務生\n'
            'Carousel - 行李運送袋(轉盤)\n'
            'In some restaurants, there may be a dress code. You cannot just turn up with your shorts and sandals.\n'
            'Is irritated by - 被...激怒\n'
            'Is dedicated to - 致力於\n'
            'I will keep you updated with the weather condition tomorrow. - 明天天氣情況我會隨時通知你。\n'
            'Aware (a.) - 察覺的\n'
            'e.g. keep you being aware of - 例如，讓你意識到\n'
            'People decorate their homes with plastic firecrackers to ward off bad luck. - 人們用塑料爆竹裝飾他們的家，以避免厄運。\n'
            'At the end of the tour, you\'ll see a souvenir shop with replicas of almost every item in the exhibit. - 在遊覽結束時，你會看到一個紀念品店，裡面幾乎每個展品都有仿製品。\n'
            'Inside the museum, flash photography is strictly prohibited. - 博物館內嚴禁使用閃光攝影。\n'
            'If you wish to return the product within 7 days, most stores will give you a refund with no questions asked. - 如果你希望在7天內退貨，大多數商店都會無條件退款。\n'
            'Usually the hotel offers guests with two bottles of drinking water free of charge. They are complimentary. - 通常酒店免費為客人提供兩瓶飲用水。它們是免費的。\n'
            'Soft piano tone - 柔和的鋼琴音\n'
            'Taiwan Railways Administration offers bento, the Japanese name for a boxed meal, transporting memories, nostalgia for home, and tales of goodness. - 臺灣鐵路管理局提供便當，這是一種盒裝餐食的日本名稱，帶著回憶、對家鄉的懷念和善良的故事。\n'
            'The procession for the goddess Mazu is a century-old tradition that embodies the collective memories of Taiwanese people. - 媽祖遶境是一項具有百年歷史的傳統，體現了臺灣人的集體記憶。\n'
            'The airport is a huge hub, a central area where many flights come and connect to other flights. - 機場是一個巨大的樞紐，是許多航班來往並連接其他航班的中心區域。\n'
            'If you drove to a hotel, there might be a valet, who will help you organize a local tour, make a restaurant reservation, buy tickets to the theatre or sports games-anything you want to do outside the hotel. - 如果你開車去酒店，可能會有代客泊車員，他將幫助你組織當地旅遊，預訂餐廳，購買劇院或體育比賽的門票 - 任何你想在酒店外做的事情。\n'
            'In addition to your passport, you need a boarding pass that lets you pass through security and into the airport. - 除了護照外，你還需要一張登機證，讓你通過安檢進入機場。\n'
            'Before entering the museum, please check in all valuables and bags at the cloakroom. - 進入博物館前，請在衣帽間存放所有貴重物品和包裹。\n'
            'Concessions=lower price - 特許權=低價\n'
            'May I have immigration card and custom declaration card? - 我可以拿移民卡和海關申報卡嗎？\n'
            'Please fasten your seatbelt and remain seated. - 請系好安全帶，保持座位。\n'
            'We are now crossing a zone of turbulence. - 我們現在正在穿越一個氣流紊亂區。\n'
            'My suitcase didn\'t appear on the carousel. - 我的手提箱沒有出現在行李轉盤上。\n'
            'The doctor gave him a prescription for his cold. - 醫生給了他感冒的處方。\n'
            'That will be all. - 就這些了。\n'
            'Your driver\'s license and vehicle registration card, please. - 請出示你的駕照和車輛登記證明。',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class TourGuide108 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '108年導遊英語記錄',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'The arrival lounge - 貴賓休息室\n'
            'Customs - 海關\n'
            'Baggage claim area - 行李領取處\n'
            'Lost and found counter - 失物招領櫃台\n'
            'Passport control - 護照檢查處\n'
            'Windsurfing - 風帆衝浪\n'
            'Snorkeling - 浮潛\n'
            'Hang gliding - 懸掛式滑翔運動\n'
            'Scuba diving - 水肺潛水\n'
            'Diabetes - 糖尿病\n'
            'Hypertension - 高血壓\n'
            'Diarrhea - 腹瀉\n'
            'Appendicitis - 闌尾炎\n'
            'Some airlines might give you toothpaste and other personal amenities when you took a long flight in the past. - 有些航空公司在您過去乘坐長途航班時可能會給您牙膏和其他個人用品。\n'
            'Let\'s go shopping at the Hilton hotel boutique. - 讓我們去希爾頓酒店精品店購物。\n'
            'I can\'t remember the taxi company\'s phone number. You\'d better look in the directory. - 我忘記了出租車公司的電話號碼。你最好查一下電話簿。\n'
            'It\'s faster and less expensive to take the shuttle from the airport to the hotel. - 從機場到酒店搭乘接駁車更快，更便宜。\n'
            'The service was terrible at the restaurant, so we didn\'t leave a gratuity. - 餐廳的服務很糟糕，所以我們沒有留小費。\n'
            'For my entree, I will have the T-bone steak, please. - 我的主菜，請給我一份T骨牛排。\n'
            'After taking in the rock formations of the Northeast Coast, it\'s time to head to the legendary gold mining town of Jinguashi. - 在欣賞完東北海岸的岩石地形後，現在是時候前往傳奇的金礦鎮金瓜石了。\n'
            'Our next stop is to Jiufen to enjoy the hillside town\'s famous cuisine and laid back atmosphere. - 我們的下一站是九份，享受這個山坡小鎮的著名美食和悠閒的氛圍。\n'
            'In Taiwan, there are many extinct or dormant volcanoes, which provide hot water for Taiwan\'s health-promoting hot springs. - 在台灣，有許多已滅絕或休眠的火山，為台灣的促進健康的溫泉提供熱水。\n'
            'On the MRT of Taiwan, visitors carrying bicycles can get on and off the train only at designated stations. - 在台灣的捷運上，攜帶自行車的遊客只能在指定的車站上下車。\n'
            'Launched in 2017, a new government sponsored TV station provides a variety of indigenous programming on fold music, dance, handicraft, and so on. - 2017年推出的一家新的政府贊助的電視台提供了各種本土節目，包括民間音樂、舞蹈、手工藝等。\n'
            'The statue of divinity, dancing lions and dragons, performing teams, and exploding firecrackers all form a big part of religious pilgrimage processions in Taiwan. - 在台灣的宗教朝聖遊行中，神像、舞獅和舞龍、表演隊伍以及爆竹都是很重要的一部分。\n'
            'Please put your suitcase on the scale. - 請將您的手提箱放在磅秤上。\n'
            'For some passengers, browsing the duty-free catalogue during the flight is a highlight of the journey. - 對於一些乘客來說，在飛行途中瀏覽免稅目錄是旅程的一大亮點。\n'
            'If you want to cash your traveler\'s checks, you must pay a handling charge. - 如果您想兌換旅行支票，您必須支付手續費。\n'
            'The tofu is left in fermented milk and some ingredients for months, making it pungent and tasty. - 豆腐在發酵牛奶和一些配料中浸泡了數月，使其變得香濃可口。\n'
            'Since the cessation of the conflict over two decades ago, many people have visited the island, which boasts famous specialties and souvenirs. - 自兩十多年前停止衝突以來，許多人都參觀了這個島嶼，這個島嶼以著名的特產和紀念品而聞名。\n'
            'Taroko National Park is a well-known natural attracton. We will drive along the gorge road to enjoy the breathtaking beauty of this marble canyon. - 太魯閣國家公園是一個著名的自然景點。我們將沿著峽谷公路行駛，欣賞這個大理石峽谷的令人驚嘆的美景。',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class TourGuide107 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '107導遊英文紀錄',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'In hotel terminology, twin rooms refer to those which provide two beds. - 在酒店術語中，雙人房指的是提供兩張床的房間。\n'
            'You will have to plan where the tour goes and what is seen by the passengers if you are in charge of the tour. - 如果你負責旅行，你必須計劃旅行的路線以及乘客所看到的內容。\n'
            'Taiwan allows visa-free entry for certain passport holders. To be approved for visa-free entry, the passport should have at least six months of validity remaining. - 臺灣允許某些護照持有者免簽入境。要獲得免簽入境的批准，護照應至少剩餘六個月的有效期。\n'
            'All the tour group members are upstairs. - 所有的旅行團成員都在樓上。\n'
            'Let‘s call it a day, shall we? - 我們今天就這樣吧，好嗎？\n'
            'If all of us travel to Penghu by ferry as opposed to flying, we could save up to ten thousand dollars. - 如果我們所有人都乘坐渡輪前往澎湖，而不是飛行，我們可以省下一萬美元。\n'
            'Plan your itinerary - 旅程;路線\n'
            'Pull off - 成功完成\n'
            'Pull over - 行駛到路邊\n'
            'Nature reserves - 自然保護區',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class TourGuide106 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '106導遊英文紀錄',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Mobile apparatus - 行動裝置\n'
            'Transact - 交易\n'
            'Faulty brakes - 缺陷煞車\n'
            'Discreet - 慎重的\n'
            'Help to alleviate this problem - 緩解\n'
            'Exacerbate his asthma - 惡化他的氣喘\n'
            'Aggravate - 增劇\n'
            'Internet poll - 投票\n'
            'Revolve to be tender - 決心成為溫柔的\n'
            'The recent mutation of the flu virus - 流感病毒最近的突變\n'
            'The ticket is refundable. - 票是可退款的\n'
            'Is estimated to be - 估計\n'
            'Transgress into the area - 越過進入該地區\n'
            'Has soared so drastically - 大幅增加\n'
            'They took a great pleasure in teaching the children. - 他們在教孩子方面感到非常愉快。\n'
            'There have been more than thirty reported cases of vandalism. - 已有三十多起故意破壞公物的行為報告。\n'
            'Rinse it with cold water before you eat it. - 在吃之前用冷水沖洗它。\n'
            'Indigenous plants - 原生植物\n'
            'Refrain from talking when someone is giving a lecture on a stage. - 當有人在舞台上講演時，請不要講話。\n'
            'That country is on the verge of civil war. - 那個國家正處於內戰的邊緣。\n'
            'Have a panoramic view of the New York City. - 欣賞紐約市的全景。\n'
            'Have severe repercussions for the tourism industry. - 對旅遊業造成嚴重後果。\n'
            'Can reasonably account for the formation of this type of landscapes. - 可以合理解釋這種景觀的形成。',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class TourGuide105 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '105導遊英文紀錄',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Board an international flight - 登上國際航班\n'
            'Sketch out your itinerary well - 好好草擬你的旅行計畫\n'
            'Aisle seat - 走道座位\n'
            'Breathe life into their relationship - 注入活力到他們的關係中\n'
            'Opt out of rock climbing - 決定不參加攀岩\n'
            'Auspices - 援助\n'
            'Leisurely tour - 悠閒的遊覽\n'
            'The intertidal zone - 潮間帶的區域\n'
            'Sugar refineries - 製糖廠\n'
            'Little room for drivers\' errors - 使駕駛僅有些微的誤差空間\n'
            'Competition venue - 發生地;場地\n'
            'Craft - 精巧地製作\n'
            'Have been renovated into - 更新成\n'
            'The torrents of the waterfall cascade - 瀑布洪流落下\n'
            'To alleviate crowding problems - 減輕擁擠問題\n'
            'Paddy fields - 稻田\n'
            'Boulder - 卵石\n'
            'Rotten - 腐爛的\n'
            'Fallow - 休耕田\n'
            'Can frolic around water fountains - 可以在噴泉周圍嬉戲\n'
            'Are you checking in any bags today? - 你今天要托運行李嗎？\n'
            'Bilingual - 雙語的\n'
            'Trilingual - 三語言的\n'
            'Biculture - 兩種不同文化混合的',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class Oral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          OralExamQuestionsPage(),
        ],
      ),
    );
  }
}

class OralExamQuestionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '110(2023)外語導遊考試考題／英語語系',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            '介紹新冠肺炎疫情下的觀光／介紹台北松菸文創\n'
            '介紹台灣的大學教育制度／介紹台灣滷肉飯\n'
            '介紹台灣KTV文化／介紹八里十三行博物館\n'
            '介紹台灣麻將文化／介紹台北西門町\n'
            '介紹台灣婚喪喜慶文化／介紹烏來風景區\n'
            '介紹台灣國球棒球文化／介紹清境農場\n'
            '介紹台灣建築形式居住習慣／介紹奮起湖特色美食\n'
            '介紹行天宮收驚文化／介紹台南美食小吃\n'
            '介紹原住民豐年祭／介紹台灣鐵路特色\n'
            '介紹臭豆腐小吃文化／介紹炸寒單特色',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '109(2020)外語導遊考試考題／其他語系',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            '介紹台灣同性婚姻／介紹高雄旗津旅遊\n'
            '介紹台灣廟宇文化／介紹宜蘭地區名產\n'
            '介紹台灣教育制度／介紹淡水老街旅遊\n'
            '介紹便利商店文化／介紹九份特色與美食\n'
            '介紹新年放鞭炮與舞獅／介紹花蓮七星潭\n'
            '外國文化對台灣影響衝擊／介紹奇美博物館\n'
            '介紹客家油紙傘／介紹台東知本溫泉\n'
            '介紹防疫新生活措施／介紹中元節習俗活動\n'
            '介紹台灣國家公園／介紹自行車道旅遊\n'
            '介紹台鐵普悠瑪號／介紹金門地區旅遊',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '108(2019)外語導遊考試考題／英語語系',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            '介紹台灣的地震／介紹東北角宜蘭海岸國家風景區\n'
            '介紹台灣佛教文化／介紹台江國家公園\n'
            '介紹台灣水果王國／介紹日月潭國家風景區\n'
            '介紹台灣三月媽祖繞境活動／介紹三種庶民美食\n'
            '介紹台灣溫泉旅遊／介紹台灣三種雞肉料理\n'
            '介紹台灣檳榔文化／介紹台灣端午節習俗活動\n'
            '介紹台灣傳統美食／介紹屏東燒王船祭典\n'
            '介紹台灣元宵節活動／介紹客家美食\n'
            '介紹客家民俗信仰／介紹澎湖玄武岩地形\n'
            '介紹美麗台灣福爾摩沙／介紹宜蘭搶孤習俗活動',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '108(2019)外語導遊考試考題／其他語系',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            '介紹台灣小吃獨特性／介紹台南鹽水蜂炮\n'
            '介紹台灣清明節潤餅／介紹大安森林公園\n'
            '介紹台灣早餐文化／介紹國父紀念館\n'
            '介紹台灣燈會文化／介紹故宮博物院\n'
            '介紹台灣手搖茶珍奶文化／介紹陽明山國家公園\n'
            '介紹台灣總舖師辦桌文化／介紹自行車環島旅遊\n'
            '介紹台灣廟宇擲茭活動／介紹台灣休閒農場\n'
            '介紹台灣獨特機車文化／介紹馬祖地區旅遊\n'
            '介紹台灣特色小鎮旅行／介紹台灣森林遊樂區\n'
            '介紹台灣公共腳踏車／介紹台灣生態旅遊',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '107(2018)外語導遊考試考題／英語語系',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            '介紹外籍旅客購物退稅／介紹鐵路便當\n'
            '介紹台灣觀光老街／介紹台灣麵食餐點\n'
            '介紹台灣宗教現況／介紹台灣知名夜市\n'
            '介紹台灣知名高山／介紹台灣中秋節\n'
            '介紹台灣高速鐵路／介紹台灣的地質公園\n'
            '介紹台灣高科技產業／介紹日月潭環潭自行車道\n'
            '介紹台灣氣候與颱風／介紹台灣候鳥生態\n'
            '介紹台灣知名伴手禮／介紹921地震園區\n'
            '介紹台灣布袋戲／介紹熱氣球嘉年華\n'
            '介紹台灣原住民祭典／介紹台灣的小籠包',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '107(2018)外語導遊考試考題／其他語系',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            '介紹台灣新年／介紹台灣米食文化\n'
            '介紹台灣觀光安全性／介紹台灣特色歷史建築\n'
            '介紹台灣四季變化／介紹台灣都會公園\n'
            '介紹台北捷運／介紹太魯閣國家公園\n'
            '介紹台灣宗教現況／介紹阿里山國家風景區\n'
            '介紹台灣觀光現況／介紹台灣平溪天燈\n'
            '介紹台灣知名夜市／介紹台灣溫泉嘉年華\n'
            '介紹電音三太子／介紹離島觀光\n'
            '介紹珍珠奶茶／介紹台灣中醫治療\n'
            '介紹台灣特色美食小吃／介紹台灣原住民概況',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class StackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stack Demo'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.blue,
            ),
            Positioned(
              top: 50,
              left: 50,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: Center(child: Text('Top Left')),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 50,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.green,
                child: Center(child: Text('Bottom Right')),
              ),
            ),
            Positioned(
              top: 100,
              right: 100,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.yellow,
                child: Center(child: Text('Top Right')),
              ),
            ),
            Positioned(
              bottom: 100,
              left: 100,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.orange,
                child: Center(child: Text('Bottom Left')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

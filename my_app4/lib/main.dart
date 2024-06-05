// Import libraries for asynchronous programming, json decoding, and building the user interface
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Main function to run the app
void main() {
  runApp(MyApp());
}

// Class to manage data fetching
class DataManager {
  // Create a http client for making network requests
  final client = http.Client();

  // Define the URL of the scenic spot data API
  final String url =
      "https://media.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json";

  // Function to fetch scenic spot data asynchronously
  Future<dynamic> fetchData() async {
    // Make a GET request to the API endpoint
    final response = await client.get(
      Uri.parse(url),
      // Set the Content-Type header to application/json
      headers: {'Content-Type': 'application/json'},
    );

    // Check if the response status code is 200 (success)
    if (response.statusCode == 200) {
      // Decode the response body using UTF8 decoder
      final utf8decoder = Utf8Decoder();
      final body = utf8decoder.convert(response.bodyBytes);

      // Parse the decoded JSON body
      return json.decode(body);
    } else {
      // Throw an exception if the request fails
      throw Exception('Failed to load data');
    }
  }
}

// Main app class
class MyApp extends StatelessWidget {
  // Create an instance of DataManager
  final DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Set the app title
      title: 'Scenic Spots',
      // Define the app theme
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set the home screen of the app
      home: ScenicSpotsScreen(dataManager: dataManager),
    );
  }
}








// class PhotoWidget extends StatefulWidget {
//   final double latitude;
//   final double longitude;

//   PhotoWidget({required this.latitude, required this.longitude});

//   @override
//   _PhotoWidgetState createState() => _PhotoWidgetState();
// }

// class _PhotoWidgetState extends State<PhotoWidget> {
//   final String apiKey = 'AIzaSyBfQONUXMNXHE1vya-TkNKtSNERVhewpjk'; // 替換為你的API Key
//   String? photoUrl;

//   @override
//   void initState() {
//     super.initState();
//     fetchPhoto();
//   }

//   Future<void> fetchPhoto() async {
//     final String location = '${widget.latitude},${widget.longitude}';
//     final String url =
//         'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=Tourist%20Attraction&inputtype=textquery&locationbias=circle:2000@$location&fields=photos&key=$apiKey';

//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final photos = data['candidates'][0]['photos'];
//       if (photos != null && photos.isNotEmpty) {
//         String photoReference = photos[0]['photo_reference'];
//         String photoUrl = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$apiKey';
//         setState(() {
//           this.photoUrl = photoUrl;
//         });
//       }
//     } else {
//       throw Exception('Failed to load photo');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: photoUrl != null
//           ? Image.network(photoUrl!)
//           : CircularProgressIndicator(), // 如果正在加載，則顯示進度指示器
//     );
//   }
// }
class PhotoWidget extends StatefulWidget {
  final String placeName; // 定義 placeName 參數


  PhotoWidget({required this.placeName});

  @override
  _PhotoWidgetState createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  final String apiKey = 'MY_API_KEY'; // 替換為你的API Key
  String? photoUrl;

  @override
  void initState() {
    super.initState();
    fetchPhoto(widget.placeName); // 在初始化時調用 fetchPhoto，傳遞地點名稱
  }

  Future<void> fetchPhoto(String placeName) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$placeName&inputtype=textquery&fields=photos&key=$apiKey';

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
    return photoUrl != null
        ? Image.network(photoUrl!)
        : SizedBox.shrink(); // 如果查不到圖片，返回一個空的 SizedBox
  }
}













// Class representing the scenic spots screen
class ScenicSpotsScreen extends StatefulWidget {
  // DataManager instance passed to the screen
  final DataManager dataManager;

  ScenicSpotsScreen({required this.dataManager});

  @override
  _ScenicSpotsScreenState createState() => _ScenicSpotsScreenState();
}

class _ScenicSpotsScreenState extends State<ScenicSpotsScreen> {
  // Define variables for future data, debounce timer, data list, filtered data list, and search controller
  late Future<dynamic> _futureData;
  late Timer _debounce;
  List<dynamic> _dataList = [];
  List<dynamic> _filteredDataList = [];
  TextEditingController _searchController = TextEditingController();

  // Initialize state when the widget is built
  @override
  void initState() {
    super.initState();
    // Fetch data initially
    _futureData = widget.dataManager.fetchData();
    // Create a debounce timer to avoid excessive filtering on every character typed
    _debounce = Timer(const Duration(milliseconds: 500), () {});

    // Add listener to the search controller to trigger filtering on text changes
    _searchController.addListener(() {
      // Cancel any existing debounce timer
      if (_debounce.isActive) _debounce.cancel();
      // Create a new debounce timer to wait for 500 milliseconds before filtering
      _debounce = Timer(const Duration(milliseconds: 500), () {
        _filterData();
      });
    });
  }

  // Dispose of resources when the widget is disposed
  @override
  void dispose() {
    _searchController.dispose();
    _debounce.cancel();
    super.dispose();
  }

  // Function to filter the data list based on the search query
  void _filterData() {
    final query = _searchController.text;

    setState(() {
      if (query.isEmpty) {
        // If the query is empty, show all data
        _filteredDataList = _dataList;
      } else {
        // Filter data by searching in name and description
        _filteredDataList = _dataList.where((item) {
          final name = item['Name'] ?? '';
          final toldescribe = item['Toldescribe'] ?? '';
          return name.contains(query) || toldescribe.contains(query);
        }).toList();
      }

    });
  }

// Function to refresh the data by refetching it and updating the UI
Future<void> _refreshData() async {
  // Update the state to indicate that data is being fetched
  setState(() {
    _futureData = widget.dataManager.fetchData();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scenic Spots'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder(
          future: _futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final dynamic data = snapshot.data;

              if (data != null) {
                _dataList = data['XML_Head']['Infos']['Info'];
                _filteredDataList = _dataList;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                labelText: '按名稱搜索',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('搜索'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _filteredDataList.length,
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> item =
                              _filteredDataList[index];
                          return Card(
                            margin: EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text((item['Region'] ?? '')+
                                  '-' +
                                  (item['Name'] ?? '')),
                              subtitle: Text(item['Toldescribe'] ?? ''),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ScenicSpotDetailScreen(item: item),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: Text('No data available'));
              }
            }
          },
        ),
      ),
    );
  }
}

// Widget representing the detailed screen for a scenic spot
class ScenicSpotDetailScreen extends StatelessWidget {
  // Map containing the scenic spot information
  final Map<String, dynamic> item;

  ScenicSpotDetailScreen({required this.item});







  @override
  Widget build(BuildContext context) {
//     double? px = double.tryParse(item['Px'].toString());
// double? py = double.tryParse(item['Py'].toString());

    return Scaffold(
      // Set the app bar title to the scenic spot name
      appBar: AppBar(
        title: Text((item['Name'])?? ''),
      ),
      body:

      SingleChildScrollView(
      child: Padding(
        // Add padding to the body content
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Align the column content to the start
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

// if (photoUrl != null)
//                 Image.network(photoUrl!),
//               SizedBox(height: 10),



            // Display the scenic spot name and region with bold styling
            Text(
              (item['Region']?? '') + '-' + (item['Name'] ?? ''),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Display the scenic spot description
            Text(item['Toldescribe'] ?? '', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
//Add Px Py
            Text(
              'Address: ' + (item['Add'] ?? 'N/A')+' (' + (item['Px'].toString() ?? 'N/A')+ ', ' + (item['Py'].toString() ?? 'N/A') + ')' ,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
//Opentime
            item['Opentime'] != null && item['Opentime'].isNotEmpty
              ? Text(
                  'Open Time: ' + item['Opentime'],
                  style: TextStyle(fontSize: 16),
                )
              : SizedBox.shrink(),
//Travellinginfo
            item['Travellinginfo'] != null && item['Travellinginfo'].isNotEmpty
              ? Text(
                  'Travellinginfo: ' + item['Travellinginfo'],
                  style: TextStyle(fontSize: 16),
                )
              : SizedBox.shrink(),
//Ticketinfo
            item['Ticketinfo'] != null && item['Ticketinfo'].isNotEmpty
              ? Text(
                  'Ticketinfo: ' + item['Ticketinfo'],
                  style: TextStyle(fontSize: 16),
                )
              : SizedBox.shrink(),

            // Display the phone number with label
            Text(
              'Tel: ' + (item['Tel'] ?? 'N/A'),
              style: TextStyle(fontSize: 16),
            ),

            //Changetime
            item['Changetime'] != null && item['Changetime'].isNotEmpty
              ? Text(
                  'Changetime: ' + item['Changetime'],
                  style: TextStyle(fontSize: 16),
                )
              : SizedBox.shrink(),



// if (px != null && py != null)
//   PhotoWidget(latitude: py, longitude: px),
PhotoWidget(placeName: item['Name']?? 'N/A'),
PhotoWidget(placeName: item['Add']?? 'N/A'),


          ],
        ),
      ),

)
    );
  }
}

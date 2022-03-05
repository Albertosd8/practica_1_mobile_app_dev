/*import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:ui';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
} 

class _MyAppState extends State<MyApp> {
  String random_img_Url = "https://picsum.photos/200/300/?blur";
  int _currentIndex = 0;
  String quote = "";
  //String random_img_Url = "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg";  
  late Future<Phrase> futurePhrase;

  @override
  void initState() {
    super.initState();
    futurePhrase = fetchPhrase();
  }
  
  Future<Phrase> fetchPhrase() async {
    final response = await http
    .get(Uri.parse('https://zenquotes.io/api/random'));

    if(response.statusCode == 200){
      return Phrase.fromJson(jsonDecode(response.body)[0]);
    }else{
      throw Exception('Failed to load phrase');
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      title: 'Material App',
      home: BackdropScaffold(
        appBar: BackdropAppBar(
          centerTitle: false,
          title: Text("La frase diaria"),
          actions: <Widget>[
            BackdropToggleButton(
              icon: AnimatedIcons.list_view,
            )
          ],
        ),
        stickyFrontLayer: true,
        backLayer: 
          BackdropNavigationBackLayer(
            items: [
              ListTile(
                leading: Image(image: NetworkImage("https://flagcdn.com/16x12/mx.png")),
                title: Text("México")
                ),
              ListTile(
                leading: Image(image: NetworkImage("https://flagcdn.com/16x12/ad.png")),
                title: Text("Andorra")
                ),
              ListTile(
                leading: Image(image: NetworkImage("https://flagcdn.com/16x12/ae.png")),
                title: Text("United Arab Emirates")
                ),
            ],
        ),
        frontLayer: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(random_img_Url),
                fit: BoxFit.cover,
                colorFilter: 
                  ColorFilter.mode(Colors.black.withOpacity(0.8), 
                  BlendMode.srcOver),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Mexico", 
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          "10:40:10", 
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("El ITESO, Universidad Jesuita de Guadalajara, es una universidad privada ubicada en la Zona Metropolitana de Guadalajara, Jalisco, México, fundada en el año 1957."
                  ,textAlign: TextAlign.justify, style: TextStyle(color: Colors.white)
                )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(quote
                  ,textAlign: TextAlign.justify, style: TextStyle(color: Colors.white)
                )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: 
                  FutureBuilder<Phrase>(
                    future: futurePhrase,
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        return Column(children: [
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(random_img_Url),
                                  fit: BoxFit.cover,
                                  colorFilter: 
                                    ColorFilter.mode(Colors.black.withOpacity(0.8), 
                                    BlendMode.srcOver),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Mexico", 
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                          ),
                                          Text(
                                            "10:40:10", 
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: Colors.white),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: 
                                    Column(
                                      children:[
                                        Text((snapshot.data!.q)
                                        //Text('-'+snapshot.data!.a),
                                        ,textAlign: TextAlign.justify, style: TextStyle(color: Colors.white)),
                                        Text(('-'+snapshot.data!.a)
                                        ,textAlign: TextAlign.justify, style: TextStyle(color: Colors.white)),
                                      ]
                                    )
                                  ),
                                ],
                              )  
                            )
                          )
                        ],);
                      }else if (snapshot.hasError){
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    }
                  )
                ),
              ],
            )  
          )
        )
      )
    );
  }
}

Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('https://zenquotes.io/api/random'));
}


class Phrase {
  final String q;
  final String a;

  const Phrase({
    required this.q,
    required this.a
  });

  factory Phrase.fromJson(Map<String, dynamic> json) {
    return Phrase(
      q: json['q'],
      a: json['a']
      );
  }
}

/*Future<List<Widget>> _country_list() async {
  final countriesResponseModel = await HttpHelper.getPopular();
  //countriesResponseModel != null
  return countriesResponseModel.countries.map((m) => ListTile(
    title: Text(m.title)
  ))
}*/

*/
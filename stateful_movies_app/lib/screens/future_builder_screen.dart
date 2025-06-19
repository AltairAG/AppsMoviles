import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class FutureBuilderScreen extends StatefulWidget {
  const FutureBuilderScreen({super.key});

  @override
  State<FutureBuilderScreen> createState() => _FutureBuilderScreenState();
}

class _FutureBuilderScreenState extends State<FutureBuilderScreen> {
  late Future<NowPlayingResponse?> response;

  @override
  void initState() {
    super.initState();
    response = getNowPlaying();
  }

  Future<NowPlayingResponse?> getNowPlaying() async {
    var url = Uri.https('api.themoviedb.org', '/3/movie/now_playing', {
      'q': '{http}',
      'api_key': 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
      'language': 'es-MX',
      'page': '1',
    });

    var response = await http.get(url);
    // Se obtuvo una respuesta favorable.
    await Future<String>.delayed(const Duration(seconds: 3), () => 'Data Loaded');
    if (response.statusCode == 200) {
      return NowPlayingResponse.fromJson(response.body);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: const Text('Aplicación Películas')),
      body: FutureBuilder(
        future: response,
        builder: (BuildContext context, AsyncSnapshot<NowPlayingResponse?> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = _widgetHasData(EdgeInsets.only(top: 16), snapshot);
          } else if (snapshot.hasError) {
            children = _widgetError(EdgeInsets.only(top: 16), snapshot);
          } else {
            children = _widgetProgressIndicator(EdgeInsets.only(top: 16));
          }
          return Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: children),
          );
        },
      ),
    );
  }

  List<Widget> _widgetHasData(EdgeInsets edgeInsets, AsyncSnapshot<NowPlayingResponse?> snapshot) {
    final textStyle = Theme.of(context).textTheme.headlineMedium;

    return <Widget>[
      const Icon(Icons.check_circle_outline, color: Colors.green, size: 60),
      Padding(
        padding: edgeInsets,
        child: Text('No. de Resultados: ${snapshot.data!.totalResults}', style: textStyle),
      ),
    ];
  }

  List<Widget> _widgetError(EdgeInsets edgeInsets, AsyncSnapshot<NowPlayingResponse?> snapshot) {
    final textStyle = Theme.of(context).textTheme.headlineMedium;
    return <Widget>[
      const Icon(Icons.error_outline, color: Colors.red, size: 60),
      Padding(
        padding: edgeInsets,
        child: Text('Error: ${snapshot.error}', style: textStyle),
      ),
    ];
  }

  List<Widget> _widgetProgressIndicator(EdgeInsets edgeInsets) {
    final textStyle = Theme.of(context).textTheme.headlineMedium;

    return <Widget>[
      const SizedBox(width: 60, height: 60, child: CircularProgressIndicator()),
      Padding(
        padding: edgeInsets,
        child: Text('Esperando resultados...', style: textStyle),
      ),
    ];
  }
}

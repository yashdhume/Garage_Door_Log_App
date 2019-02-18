import 'package:flutter/material.dart';
import 'package:garage_door_log/JsonFetcher.dart';
import 'package:garage_door_log/Link.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Log extends StatefulWidget {
  _Log createState() => _Log();
}

class _Log extends State<Log> {
  List<JsonFetcher> list = List();
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(link);
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new JsonFetcher.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
        list = list.reversed.toList();
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1),
          title: new Text("Garage Log"),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: ()=>_fetchData(),
                child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text(list[index].garageDoor),
                          new Text(list[index].openClose),
                          new Text(list[index].dateTime),
                        ],
                      ));
                },
              )));
  }
}

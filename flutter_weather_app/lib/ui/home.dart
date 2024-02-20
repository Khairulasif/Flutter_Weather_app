import 'package:flutter/material.dart';
import 'package:flutter_weather_app/model/weather_model.dart';
import 'package:flutter_weather_app/service/api_service.dart';
import 'package:flutter_weather_app/ui/components/future_forcast_listItem.dart';
import 'package:flutter_weather_app/ui/components/hourly_weather_listItem.dart';
import 'package:flutter_weather_app/ui/components/todays_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  final textFieldController = TextEditingController();
  String searchText = "auto:ip";

  showTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Search Location"),
          content: TextField(
            controller: textFieldController,
            decoration:
                InputDecoration(hintText: "Search by city, zip, lat, lang"),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (textFieldController.text.isEmpty) {
                  return;
                }

                Navigator.pop(context, textFieldController.text);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Flutter Weather App",
          style: TextStyle(color: Colors.white60),
        ),
        backgroundColor: Colors.black12,
        elevation: 10.0,
        actions: [
          IconButton(
            color: Colors.white60,
            onPressed: () async {
              textFieldController.clear();
              String text = await showTextInputDialog(context);
              setState(() {
                searchText = text;
              });
            },
            icon: Icon(Icons.search_rounded),
          ),
          IconButton(
            color: Colors.white60,
            onPressed: () async {
              searchText = "auto:ip";
              setState(() {});
            },
            icon: Icon(Icons.my_location_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: apiService.getWeatherData(searchText),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModel? weatherModel = snapshot.data;
              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    TodaysWeather(
                      weatherModel: weatherModel,
                    ),
                    Text(
                      "Weather by Hours",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Hour? hour = weatherModel
                              ?.forecast?.forecastday?[0].hour?[index];

                          return HourlyWeatherListItem(
                            hour: hour,
                          );
                        },
                        itemCount: weatherModel
                            ?.forecast?.forecastday?[0].hour?.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Next 7 days weather",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Forecastday? forcastDay =
                              weatherModel?.forecast?.forecastday?[index];
                          return FutureForcastListItem(
                            forcastDay: forcastDay,
                          );
                        },
                        itemCount: weatherModel?.forecast?.forecastday?.length,
                      ),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error has occured"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

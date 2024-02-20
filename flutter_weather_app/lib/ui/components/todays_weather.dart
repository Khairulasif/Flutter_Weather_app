import 'package:flutter/material.dart';
import 'package:flutter_weather_app/model/weather_model.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';

class TodaysWeather extends StatelessWidget {
  final WeatherModel? weatherModel;

  const TodaysWeather({super.key, required this.weatherModel});

  WeatherType getWeatherType(Current? current) {

    if(current?.isDay == 1) {
      if(current?.condition?.text == "Sunny") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Overcast"){
        return WeatherType.overcast;
      }else if (current?.condition?.text == "Partly Cloudy"){
        return WeatherType.cloudy;
      }else if (current?.condition?.text == "Cloudy"){
        return WeatherType.cloudy;
      }else if (current?.condition?.text == "Mist"){
        return WeatherType.lightSnow;
      }else if (current!.condition!.text!.contains("Thunder")){
        return WeatherType.thunder;
      }else if (current!.condition!.text!.contains("rain")) {
        return WeatherType.heavyRainy;
      }else if (current!.condition!.text!.contains("shours")) {
        return WeatherType.middleSnow;
      }else if (current?.condition?.text == "Clear"){
        return WeatherType.sunny;
      }
    }else {
      if(current?.condition?.text == "Sunny") {
        return WeatherType.sunny;
      }else if (current?.condition?.text == "Clear"){
        return WeatherType.sunnyNight;
      } else if (current?.condition?.text == "Overcast"){
        return WeatherType.overcast;
      }else if (current?.condition?.text == "Partly Cloudy"){
        return WeatherType.cloudy;
      }else if (current?.condition?.text == "Cloudy"){
        return WeatherType.cloudyNight;
      }else if (current?.condition?.text == "Mist"){
        return WeatherType.lightSnow;
      }else if (current!.condition!.text!.contains("Thunder")){
        return WeatherType.thunder;
      }else if (current!.condition!.text!.contains("rain")) {
        return WeatherType.heavyRainy;
      }else if (current!.condition!.text!.contains("showers")) {
        return WeatherType.middleSnow;
      }
    }
    return WeatherType.cloudyNight;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherBg(
          weatherType: getWeatherType(weatherModel?.current),
          width: MediaQuery.of(context).size.width,
          height: 320,
        ),
        SizedBox(
          width: double.infinity,
          height: 350,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Text(
                      weatherModel?.location?.name ?? "",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMEEEEd().format(
                        DateTime.parse(
                            weatherModel?.current?.lastUpdated.toString() ??
                                ''),
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white10,
                    ),
                    child: Image.network(
                        "https:${weatherModel?.current?.condition?.icon ?? ""}"),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            weatherModel?.current?.tempC?.round().toString() ??
                                "",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            "o",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ],
                      ),
                      Text(
                        weatherModel?.current?.condition?.text ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Feels Like",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              weatherModel?.current?.feelslikeC
                                      ?.round()
                                      .toString() ??
                                  "",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Wind",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${weatherModel?.current?.windKph?.round()} km/h",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Humidity",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${weatherModel?.current?.humidity}%",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Visibility",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${weatherModel?.current?.visKm?.round()} km",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/weather_model.dart';

class HourlyWeatherListItem extends StatelessWidget {
  final Hour? hour;

  const HourlyWeatherListItem({super.key, required this.hour});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  hour?.tempC?.round().toString() ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Text(
                "o",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            height: 50,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
            child: Image.network("https:${hour?.condition?.icon.toString()}"),
          ),
          Text(
            DateFormat.j().format(
              DateTime.parse(hour?.time?.toString() ?? ""),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

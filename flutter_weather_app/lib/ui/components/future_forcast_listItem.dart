import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/weather_model.dart';

class FutureForcastListItem extends StatelessWidget {
  final Forecastday? forcastDay;

  const FutureForcastListItem({super.key, this.forcastDay});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(vertical: 8),
      margin: EdgeInsets.all(8),
      width: double.infinity,
      child: Row(
        children: [
          Image.network(
            "https:${forcastDay?.day?.condition?.icon ?? ""}",
          ),
          Expanded(
            child: Text(
              DateFormat.MMMEd().format(
                DateTime.parse(forcastDay?.date.toString() ?? ""),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Text(
             forcastDay?.day?.condition?.text.toString() ?? "",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "^${forcastDay?.day?.maxtempC?.round()}/${forcastDay?.day?.mintempC?.round()}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

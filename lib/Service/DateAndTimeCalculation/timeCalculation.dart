class TimeCalculation {
  static List calculateTimeSlots(
    String startHour,
    String startMin,
    String stopHour,
    String stopMin,
    int serviceTime,
  ) {
    String startTimeHour = startHour;
    String startTimeMin = startMin;

    String stopTimeMin = stopMin;
    String stopTimeHour = stopHour;

    List<String> timeSlots = [];

    timeSlots.add(startTimeHour + ":" + startTimeMin);
    //print("startTimeHour: $startTimeHour " + "startTimeMin: $startTimeMin");

    while (int.parse(startTimeHour) <= int.parse(stopTimeHour)) {
      //  print("startTimeHour: $startTimeHour " + "startTimeMin: $startTimeMin");

      var res =
          TimeCalculation.addTime("$startTimeHour:$startTimeMin", serviceTime);

      var res2 = TimeCalculation.addTime(
          res.substring(0, 2) + ":" + res.substring(3, 5), serviceTime);

      if (int.parse(res2.substring(0, 2)) > int.parse(stopTimeHour)) {
        break;
      } else if (int.parse(res2.substring(0, 2)) == int.parse(stopTimeHour) &&
          int.parse(res2.substring(3, 5)) > int.parse(stopTimeMin)) {
        break;
      } else {
        timeSlots.add(res);

        startTimeHour = res.substring(0, 2);
        startTimeMin = res.substring(3, 5);
      }
    }

    // print("//////////////////////////////////" + "$timeSlots");
    return timeSlots;
  }

  static List reCalculateTimeSlots(
      List tlots,
      List bookedTimeSlots,
      var selectedDate,
      String closingTimeHour,
      String closingTimeMin,
      int selctedServiceTime) {
    var timeSlots = tlots;
    bookedTimeSlots.forEach((element) {
      for (int i = 0; i < timeSlots.length - 1; i++) {
        String afterTime =
            TimeCalculation.addTime(timeSlots[i], selctedServiceTime);
        String bookedTime =
            TimeCalculation.addTime(element["bookedTime"], element["forMin"]);

        if (bookedTime.substring(0, 2) == timeSlots[i].substring(0, 2) &&
            bookedTime.substring(0, 2) == afterTime.substring(0, 2) &&
            int.parse(bookedTime.substring(3, 5)) >
                int.parse(timeSlots[i].substring(3, 5)) &&
            int.parse(bookedTime.substring(3, 5)) <
                int.parse(afterTime.substring(3, 5))) {
          // print(
          //     "^^^^^^^^^^^^^^^^^^^^^$afterTime^^^^^^^^^^^^^^^^^^^^^^^66 ${timeSlots[i]}");
          timeSlots[i + 1] = bookedTime;

          timeSlots.removeRange(i + 2, timeSlots.length);
          //   print("TTTTTTTTTTTTTTTTTTTTTTTTTTTT $timeSlots");

          while (true) {
            var j = i + 1;
            var newTime =
                TimeCalculation.addTime(timeSlots[j], selctedServiceTime);
            var newTime2 = TimeCalculation.addTime(newTime, selctedServiceTime);
            if (int.parse(newTime2.substring(0, 2)) >
                int.parse(closingTimeHour)) {
              break;
            } else if (int.parse(newTime2.substring(0, 2)) ==
                    int.parse(closingTimeHour) &&
                int.parse(newTime2.substring(3, 5)) >
                    int.parse(closingTimeMin)) {
              break;
            } else {
              timeSlots.add(newTime);
            }
            i++;
          }
        } else if (bookedTime.substring(0, 2) == timeSlots[i].substring(0, 2) &&
            int.parse(bookedTime.substring(3, 5)) >
                int.parse(timeSlots[i].substring(3, 5)) &&
            int.parse(bookedTime.substring(0, 2)) <
                int.parse(afterTime.substring(0, 2))) {
          // print(
          //     "+++++++++++ $bookedTime ++++++++++++++++$afterTime^^^^^^^^^^^^^^^^^^^^^^^66 ${timeSlots[i]}");
          timeSlots[i + 1] = bookedTime;

          timeSlots.removeRange(i + 2, timeSlots.length);
          //   print("TTTTTTTTTTTTTTTTTTTTTTTTTTTT $timeSlots");

          while (true) {
            var j = i + 1;
            var newTime =
                TimeCalculation.addTime(timeSlots[j], selctedServiceTime);
            var newTime2 = TimeCalculation.addTime(newTime, selctedServiceTime);
            if (int.parse(newTime2.substring(0, 2)) >
                int.parse(closingTimeHour)) {
              break;
            } else if (int.parse(newTime2.substring(0, 2)) ==
                    int.parse(closingTimeHour) &&
                int.parse(newTime2.substring(3, 5)) >
                    int.parse(closingTimeMin)) {
              break;
            } else {
              timeSlots.add(newTime);
            }
            i++;
          }
        } else if (int.parse(bookedTime.substring(0, 2)) >
                int.parse(timeSlots[i].substring(0, 2)) &&
            int.parse(bookedTime.substring(0, 2)) <
                int.parse(afterTime.substring(0, 2))) {
          // print(
          //     "---------------------------------$afterTime^^^^^^^^^^^^^^^^^^^^^^^ ${timeSlots[i]}");
          timeSlots[i + 1] = bookedTime;

          timeSlots.removeRange(i + 2, timeSlots.length);
          //   print("TTTTTTTTTTTTTTTTTTTTTTTTTTTT $timeSlots");

          while (true) {
            var j = i + 1;
            var newTime =
                TimeCalculation.addTime(timeSlots[j], selctedServiceTime);
            var newTime2 = TimeCalculation.addTime(newTime, selctedServiceTime);
            if (int.parse(newTime2.substring(0, 2)) >
                int.parse(closingTimeHour)) {
              break;
            } else if (int.parse(newTime2.substring(0, 2)) ==
                    int.parse(closingTimeHour) &&
                int.parse(newTime2.substring(3, 5)) >
                    int.parse(closingTimeMin)) {
              break;
            } else {
              timeSlots.add(newTime);
            }
            i++;
          }
        } else if (int.parse(bookedTime.substring(0, 2)) >
                int.parse(timeSlots[i].substring(0, 2)) &&
            int.parse(bookedTime.substring(0, 2)) ==
                int.parse(afterTime.substring(0, 2)) &&
            int.parse(bookedTime.substring(3, 5)) <
                int.parse(afterTime.substring(3, 5))) {
          timeSlots[i + 1] = bookedTime;

          timeSlots.removeRange(i + 2, timeSlots.length);
          //   print("TTTTTTTTTTTTTTTTTTTTTTTTTTTT $timeSlots");

          while (true) {
            var j = i + 1;
            var newTime =
                TimeCalculation.addTime(timeSlots[j], selctedServiceTime);
            var newTime2 = TimeCalculation.addTime(newTime, selctedServiceTime);
            if (int.parse(newTime2.substring(0, 2)) >
                int.parse(closingTimeHour)) {
              break;
            } else if (int.parse(newTime2.substring(0, 2)) ==
                    int.parse(closingTimeHour) &&
                int.parse(newTime2.substring(3, 5)) >
                    int.parse(closingTimeMin)) {
              break;
            } else {
              timeSlots.add(newTime);
            }
            i++;
          }
        }
      }
    });
    return timeSlots;
  }

  static addTime(String time, int addMin) {
    //print("time: $time " + "addMin: $addMin");
    String returnTime;
    int hour = addMin ~/ 60;
    int min = addMin % 60;

    min = int.parse(time.substring(3, 5)) + min;

    if (min < 60 && min >= 10) {
      hour = int.parse(time.substring(0, 2)) + hour;
      returnTime = "$hour" + ":" + "$min";
    } else if (min > 60) {
      hour = int.parse(time.substring(0, 2)) + hour + 1;
      min = min - 60;
      if (min < 10)
        returnTime = "$hour" + ":" + "0" + "$min";
      else
        returnTime = "$hour" + ":" + "$min";
    } else if (min == 60) {
      hour = int.parse(time.substring(0, 2)) + hour + 1;
      min = 0;
      returnTime = "$hour" + ":" + "0" + "$min";
    } else {
      hour = int.parse(time.substring(0, 2)) + hour;
      returnTime = "$hour" + ":" + "0" + "$min";
      print("3 $returnTime");
    }
    if (returnTime.substring(0, 2).contains(":"))
      returnTime =
          "0${returnTime.substring(0, 1)}:${returnTime.substring(2, 4)}";

    return returnTime;
  }

  static subtractime(String time, int subMin) {
    String returnTime;
    int hour = subMin ~/ 60;
    int min = subMin % 60;

    min = int.parse(time.substring(3, 5)) - min;
    if (min > 0) {
      hour = int.parse(time.substring(0, 2)) - hour;
      if (min < 10)
        returnTime = "$hour" + ":" + "0" + "$min";
      else
        returnTime = "$hour" + ":" + "$min";
    } else if (min < 0 && min != 0) {
      hour = int.parse(time.substring(0, 2)) - hour - 1;
      min = min + 60;
      if (min < 10)
        returnTime = "$hour" + ":" + "0" + "$min";
      else
        returnTime = "$hour" + ":" + "$min";
    } else if (min == 0) {
      hour = int.parse(time.substring(0, 2)) - hour;
      min = 0;
      returnTime = "$hour" + ":" + "0" + "$min";
    }
    if (returnTime.substring(0, 2).contains(":"))
      returnTime =
          "0${returnTime.substring(0, 1)}:${returnTime.substring(2, 4)}";

    return returnTime;
  }

  static List calculateBookedTime(
      String time, List bookedTime, int serviceTimeMin) {
    List<String> bookedTimeSlots = [];
    bookedTime.forEach((element) {
      //     print("addd" + _addTime(element["bookedTime"], element["forMin"]));
      // print("subtract" + _subtractime(element["bookedTime"], serviceTimeMin));
      String afterTime =
          TimeCalculation.addTime(element["bookedTime"], element["forMin"]);
      String beforeTime =
          TimeCalculation.subtractime(element["bookedTime"], serviceTimeMin);

      if (int.parse(time.substring(0, 2)) >
              int.parse(beforeTime.substring(0, 2)) &&
          int.parse(time.substring(0, 2)) <
              int.parse(afterTime.substring(0, 2))) {
        bookedTimeSlots.add(time);
        //   print("$time CCCCCCCCCC");
      } else if (int.parse(time.substring(0, 2)) >
              int.parse(beforeTime.substring(0, 2)) &&
          int.parse(time.substring(0, 2)) ==
              int.parse(afterTime.substring(0, 2)) &&
          int.parse(time.substring(3, 5)) <
              int.parse(afterTime.substring(3, 5))) {
        bookedTimeSlots.add(time);
        //   print("$time DDDDDDDDDDDDD");
      } else if (int.parse(time.substring(0, 2)) ==
              int.parse(beforeTime.substring(0, 2)) &&
          int.parse(time.substring(0, 2)) !=
              int.parse(afterTime.substring(0, 2)) &&
          int.parse(time.substring(3, 5)) >
              int.parse(beforeTime.substring(3, 5))) {
        bookedTimeSlots.add(time);
        //   print("$time AAAAAAAAAAAA");
      } else if (int.parse(time.substring(0, 2)) ==
              int.parse(beforeTime.substring(0, 2)) &&
          int.parse(time.substring(0, 2)) ==
              int.parse(afterTime.substring(0, 2)) &&
          int.parse(time.substring(3, 5)) >
              int.parse(beforeTime.substring(3, 5)) &&
          int.parse(time.substring(3, 5)) <
              int.parse(afterTime.substring(3, 5))) {
        bookedTimeSlots.add(time);
        //   print("$time BBBBBBBBBB");
      }
    });
    return bookedTimeSlots;
  }
}

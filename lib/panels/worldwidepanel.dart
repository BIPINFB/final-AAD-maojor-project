import 'package:flutter/material.dart';

class WorldwidePanel extends StatelessWidget {
  final Map worldData;

  const WorldwidePanel({Key? key, required this.worldData}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2,),
        children: <Widget>[
          Tooltip(
            message: 'WORLDWIDE CONFIRMED CASES',
            child: StatusPanel(


                    title: 'TOTAL CASES',
                    panelColor: Colors.blue.shade50,
                    textColor: Colors.blue.shade900,
                    count: worldData['cases'].toString(),

            ),
          ),
          Tooltip(
            message: 'WORLDWIDE ACTIVE CASES',
            child: StatusPanel(
              title: 'ACTIVE',
              panelColor: Colors.blue.shade50,
              textColor: Colors.blue.shade900,
              count: worldData['active'].toString(),
            ),
          ),
          Tooltip(
            message: 'WORLDWIDE RECOVERY NUMBER',
            child: StatusPanel(
              title: 'RECOVERED',
              panelColor: Colors.blue.shade50,
              textColor: Colors.blue.shade900,
              count: worldData['recovered'].toString(),
            ),
          ),
          Tooltip(
            message: 'WORLDWIDE DEATHS',
            child: StatusPanel(
              title: 'DEATHS',
              panelColor: Colors.blue.shade50,
              textColor: Colors.blue.shade900,
              count: worldData['deaths'].toString(),
            ),
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel(
      {Key? key,required this.panelColor, required this.textColor,required this.title,required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Card(
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(100),
      ),
      shadowColor: Colors.redAccent,
      color: panelColor,
      child: Container(

        margin: EdgeInsets.all(10),
        height: 80,
        width: width / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
            ),
            Text(
              count,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
            )
          ],
        ),
      ),
    );
  }
}

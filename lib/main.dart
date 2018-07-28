import 'package:flutter/material.dart';
import 'package:flutter_video_timelapse/activeScreen.dart';
import 'package:flutter_video_timelapse/menuController.dart';
import 'package:flutter_video_timelapse/menuScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {



  @override
  MyAppState createState() {
    return new MyAppState();
  }

}

class MyAppState extends State<MyApp> with TickerProviderStateMixin{
  Offset dragStart;

  MenuController menuController;
  _onHorizontalDragStart(DragStartDetails details){
    print(details);
    dragStart = details.globalPosition;
  }

  _onHorizontalDragUpdate(DragUpdateDetails details){
    print(details);
    (details.globalPosition.dx - dragStart.dx) > 50
        ? menuController.open()
        :   (details.globalPosition.dx - dragStart.dx) > - 50
            ? menuController.close():null;
  }

  _onHorizontalDragEnd(DragEndDetails details){
    print(details);
    dragStart = null;
  }


  @override
  void initState() {
    super.initState();
    menuController = new MenuController(vsync: this)..addListener((){
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
   return new MaterialApp(
     debugShowCheckedModeBanner: false,
     home: Scaffold(
       floatingActionButton: FloatingActionButton(
         onPressed: (){
           menuController.toggle();
         },
       backgroundColor: Colors.orange,
         child: Icon(Icons.map,color: Colors.white,),
       ),
        body:Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF213163),const Color(0xFF6b7ba3)],
                  begin: FractionalOffset.topLeft,
                  end:  FractionalOffset.bottomRight
                )
              ),
            ),
            new Positioned(
              top:0.0,
              left:0.0,
              right: 0.0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  'TOFIND',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.gps_fixed,color: Colors.white,size: 30.0),
                    onPressed: (){

                    },
                  )
                ],
                leading: IconButton(
                  icon:Icon(Icons.search,color:Colors.white,size:30.0),
                  onPressed: (){

                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top:55.0),
              child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragEnd: _onHorizontalDragEnd,
              onHorizontalDragUpdate: _onHorizontalDragUpdate,
              onHorizontalDragStart: _onHorizontalDragStart,
                child: Stack(
                  children: <Widget>[
                    MenuScreen(),
                    Transform(
                      transform: Matrix4.translationValues(190.0,0.0,0.0),
                      child: ActiveScreen(
                        menuController: menuController,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
     ),
   );
  }
}

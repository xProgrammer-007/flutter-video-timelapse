import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  @override
  MenuScreenState createState() {
    return new MenuScreenState();
  }
}

class MenuScreenState extends State<MenuScreen> {
  List<MenuItem> defaultMenuItems = [
    MenuItem(
      text: 'Landmarks',
      visible: true,
    ),
    MenuItem(
      text: 'City',
      visible: true,
    ),
    MenuItem(
      text: 'Street',
      visible: true,
    ),
    MenuItem(
      text: 'Recommended',
      visible: true,
    ),
    MenuItem(
      text: 'Popular',
      visible: true,
    ),
  ];

  List<Widget> _buildMenuItems(){
     return defaultMenuItems.map((MenuItem menuItem){
       return MenuItem(
         text: menuItem.text,
         visible: menuItem.visible,
         onTap: (String text){
           removeItem(text);
         },
       );
     }).toList();
  }

  removeItem(String text){
    print('entered $text');
    var _newList = defaultMenuItems.where((MenuItem menuItem)=> menuItem.text != text);
    setState(() {
      defaultMenuItems = [];
      _newList.forEach((x) => defaultMenuItems.add(x));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(15.0,70.0,0.0),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Text(
                    'FILTER',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight:FontWeight.bold,
                        fontSize: 30.0
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left:10.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:Colors.white.withOpacity(0.3)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.sort,color: Colors.white,),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top:20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildMenuItems(),
                  ) ,
                  Container(
                    margin: EdgeInsets.only(top:50.0),
                    width: double.infinity,
                    height: 1.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.grey,Colors.transparent],
                        begin: FractionalOffset.centerLeft,
                        end: FractionalOffset.centerRight,
                      )
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top:30.0),
                    width: 100.0,
                    decoration: BoxDecoration(
                        color:Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(30.0)
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            defaultMenuItems = [
                              MenuItem(
                                text: 'Landmarks',
                                visible: true,
                              ),
                              MenuItem(
                                text: 'City',
                                visible: true,
                              ),
                              MenuItem(
                                text: 'Street',
                                visible: true,
                              ),
                              MenuItem(
                                text: 'Recommended',
                                visible: true,
                              ),
                              MenuItem(
                                text: 'Popular',
                                visible: true,
                              ),
                            ];
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left:5.0),
                                child: Text(
                                  'Add',
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.1
                                  ),
                                ),
                              ),
                              Expanded(child: Container(),),
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top:70.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.person,color: Colors.white,size: 30.0,),
                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Text(
                            'ACCOUNT',
                            style: TextStyle(
                              color: Colors.white,
                                fontSize: 18.0
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}




class MenuItem extends StatelessWidget {
  final String text;
  final bool visible;
  final Function(String text) onTap;
  MenuItem({
    this.text = '',
    this.visible,
    this.onTap
  });
  @override
  Widget build(BuildContext context) {
    return !visible ? Container() : Container(
      margin: EdgeInsets.symmetric(vertical:5.0),
      padding: EdgeInsets.symmetric(vertical:3.0,horizontal:7.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: Colors.black.withOpacity(0.2),
      ),
      child: GestureDetector(
        onTap: (){
          onTap(text);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal:5.0),
              width: 1.0,
              height: 30.0,
              color: const Color(0x446b7ba3),
            ),
            GestureDetector(
              onTap: (){
                onTap(text);
                print(text);
              },
              child: Icon(
                Icons.close,
                color: const Color(0x446b7ba3)
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_video_timelapse/menuController.dart';
import 'package:video_player/video_player.dart';


List<CardModel> cardList = [

  CardModel(
      url:'https://www.videvo.net/videvo_files/converted/2014_07/preview/Run_5_wo_metadata_h264420_720p_UHQ.mp446798.webm',
      title: 'GUILDHALL\n LONDON , UK',
      icon: Icons.directions_bus,
      imageAssetUrl: 'assets/town4.jpg',
      index: '01',
      videoAsset:'assets/video4.webm'
  ),
  CardModel(
      url: 'https://www.videvo.net/videvo_files/converted/2016_10/preview/160929_133_London_TowerBridgeTimeLapse_1080p.mp439600.webm',
      title: 'THE ISLAND \n EUROPE, FINLAND',
      icon: Icons.directions_walk,
      imageAssetUrl: 'assets/town3.jpg',
      index: '02',
      videoAsset:'assets/video3.webm'
  ),
  CardModel(
      url: 'https://www.videvo.net/videvo_files/converted/2016_06/preview/160606_MontBlanc_Timelapse1_1080p.mov63233.webm',
      title: 'CATHEDRAL \n ITALY , EUROPE',
      icon: Icons.directions_car,
      imageAssetUrl: 'assets/town2.jpg',
      index: '03',
      videoAsset:'assets/video2.webm'
  ),
  CardModel(
      url: 'https://www.videvo.net/videvo_files/converted/2016_09/preview/160820_277_NYC_DowntownSunsetTimeLapse_1080p.mp466348.webm',
      title: 'PARIS \n ST HALL , FRENCH',
      icon: Icons.directions_car,
      imageAssetUrl: 'assets/town1.jpg',
      index: '04',
      videoAsset:'assets/video1.webm'
  ),
];

class ActiveScreen extends StatefulWidget {
  MenuController menuController;

  ActiveScreen({
    this.menuController
  });

  @override
  _ActiveScreenState createState() => _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen> with SingleTickerProviderStateMixin{



  @override
  void initState() {
    super.initState();
    widget.menuController.addListener((){
      setState(() {

      });
    });
    }



 List<Widget> _buildCards(){

    int _index = 0;
    return cardList.map((item){
      final delay = 0.1;
      final animTime = 0.5;
      final begin = delay * _index++;
      final end = begin + animTime;

    return AnimatedCard(
      duration: const Duration(milliseconds: 700),
      child: LocationCard(
          cardModel: item,
      ),
      curve: Interval(begin,end,curve:Curves.ease),
      menuState: widget.menuController.menuState,
    );
    }).toList();

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ListView(
          children: _buildCards()
        ),
      ],
    );
  }
}


class LocationCard extends StatefulWidget {
  CardModel cardModel;
  LocationCard({
    this.cardModel
  });
  @override
  LocationCardState createState() {
    return new LocationCardState();
  }
}

class LocationCardState extends State<LocationCard> {
  VideoPlayerController videoController;
  bool _isPlaying = true;


  @override
  void initState() {
    super.initState();
    videoController = new VideoPlayerController.asset(widget.cardModel.videoAsset)
      ..setVolume(0.0)
      ..play()
      ..setLooping(true)
      ..addListener(() {
        final bool isPlaying = videoController.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal:4.0),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.cardModel.imageAssetUrl),
                fit: BoxFit.cover
              ),
              color: Colors.blueGrey,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2.0,
                    blurRadius: 5.0,
                    offset: Offset(0.0,-1.0)
                )
              ]
          ),
          width: double.infinity,
          height: 140.0,
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                child: videoController.value.initialized
                    ? AspectRatio(
                  aspectRatio:videoController.value.aspectRatio,
                  child: VideoPlayer(videoController),
                )
                    : Container(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex:2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                widget.cardModel.index,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.3
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text(
                                  widget.cardModel.title.toUpperCase(),
                                  style: TextStyle(
                                    color:Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(widget.cardModel.icon,color: Colors.white,size:67.0),
                          Text(
                            '14 2015 \n 08:32 AM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class AnimatedCard extends ImplicitlyAnimatedWidget {
  @override
  _AnimatedCardState createState() => _AnimatedCardState();
  final Curve curve;
  final MenuState menuState;
  final Duration duration;
  final Widget child;
  AnimatedCard({
    this.duration,
    this.curve,
    this.menuState,
    this.child
  }):super(duration:duration,curve:curve);
}

class _AnimatedCardState extends AnimatedWidgetBaseState<AnimatedCard> {
  Tween<double> _translate;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(_translate.evaluate(animation), 0.0, 0.0),
      child: widget.child,
    );
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    double _translateVal;
    switch(widget.menuState){
      case MenuState.closed:
        _translateVal = -190.0;
        break;
      case MenuState.closing:
        _translateVal = 0.0;
        break;
      case MenuState.open:
        _translateVal = 0.0;
        break;
      case MenuState.opening:
        _translateVal = 0.0;
        break;
    }

    _translate = visitor(
      _translate,
      _translateVal,
    (dynamic value) => Tween<double>(begin:value)
    );
    // TODO: implement forEachTween
  }
}



class CardModel{
  final String url;
  final String title;
  final String subTitle;
  final String imageAssetUrl;
  final IconData icon;
  final String index;
  final String videoAsset;
  CardModel({
    this.url = '',
    this.title = '',
    this.subTitle = '',
    this.icon,
    this.index = '',
    this.imageAssetUrl = '',
    this.videoAsset = ''
});
}
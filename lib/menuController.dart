

import 'package:flutter/material.dart';

class MenuController extends ChangeNotifier{
  final TickerProvider vsync;
  MenuState menuState = MenuState.closed;
  AnimationController slideAnimation;
  MenuController({
    this.vsync
  }): slideAnimation = AnimationController(
    vsync: vsync,
    duration: const Duration(milliseconds: 500)
  ){
    slideAnimation
      ..addListener((){
        notifyListeners();
      })..addStatusListener((AnimationStatus status){
       switch(status){
         case AnimationStatus.completed:
           menuState = MenuState.open;
           break;
         case AnimationStatus.forward:
           menuState = MenuState.opening;
           break;
         case AnimationStatus.reverse:
           menuState = MenuState.closing;
           break;
           case AnimationStatus.dismissed:
            menuState = MenuState.closed;
          break;
       }
       notifyListeners();
    });
  }


  get openPercent => slideAnimation.value;

  get isOpen => menuState == MenuState.open;

  get isClosed => menuState == MenuState.closed;

  open(){
    slideAnimation.forward();
  }

  close(){
    slideAnimation.reverse();
  }

  toggle(){
    if(isClosed){
      open();
    }else if(isOpen){
      close();
    }
  }

}


enum MenuState{
  closed,
  open,
  opening,
  closing
}
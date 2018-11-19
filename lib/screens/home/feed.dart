import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:youroccasions/models/category.dart';

import 'package:youroccasions/models/event.dart';
import 'package:youroccasions/screens/home/event_card.dart';
import 'package:youroccasions/controllers/event_controller.dart';
// import 'package:youroccasions/controllers/category_controller.dart';
import 'package:youroccasions/controllers/event_category_controller.dart';
import 'package:youroccasions/models/data.dart';

class FeedTabView extends StatefulWidget {
  @override
  _FeedTabView createState() => _FeedTabView();
}

class _FeedTabView extends State<FeedTabView> {
  // TODO Fix duplicate card issue. If there is multiple cards of the same event,
  // and 1 of them is interested, the other ones' interest status are not updated.
  List<Event> _upcomingEvents;
  List<Event> _trendingEvents;

  @override
  void initState() {
    super.initState();
    _upcomingEvents = FeedDataset.upcomingEvents.value;
    _trendingEvents = FeedDataset.trendingEvents.value;
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _upcomingEvents = null;
    _trendingEvents = null;
  }

  Future _refresh() async {
    // setState(() {
    //   FeedDataset.clearData();      
    // });
    await _getUpcomingEventData();
    await _getTrendingMusicData();
  }

  void loadData() async {
    await _refresh();
    // _upcomingEventsController.add(FeedDataset.upcomingEvents.value);

  }

  Future _getUpcomingEventData() async {
    EventController _eventController = EventController();
    var data = await _eventController.getEvent();
    FeedDataset.upcomingEvents.value = data;
    if(this.mounted) {
      setState(() {
        _upcomingEvents = FeedDataset.upcomingEvents.value;
      });
    }
    
  }

  Future _getTrendingMusicData() async {
    // TODO don't get past event
    EventController _ec = EventController();
    EventCategoryController _ecc = EventCategoryController();
    List<Event> temp = List<Event>();

    // print("DEBUG is getting trending music");

    var eventCategoryList = await _ecc.getEventCategory(category: Categories.music.name);
    // print(eventCategoryList);
    // print("DEBUG: eventCategoryList length ${eventCategoryList.length}");

    for(int i = 0 ; i < eventCategoryList.length ; i++ ) {
      // print("DEBUG: i = $i");
      var event = (await _ec.getEvent(id: eventCategoryList[i].eventId))[0];
      // print("DEBUG: $event");
      temp.add(event);
    }
    // print("DEBUG: temp: $temp");

    temp.sort((a,b) => a.views.compareTo(b.views));

    FeedDataset.trendingEvents.value = temp;
    if(this.mounted) {
      setState(() {
        _trendingEvents = FeedDataset.trendingEvents.value;
      });
    }
  }

  List<Widget> _buildUpcomingEventsCardList(int count) {
    List<Widget> cards = List<Widget>();
    int counter = 0;

    Widget e = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Text("Upcoming events", style: TextStyle(fontSize: 30.0, fontFamily: "Niramit")),
    );

    cards.add(e);

    _upcomingEvents.sort((b,a) => a.startTime.compareTo(b.startTime));
    _upcomingEvents.forEach((Event currentEvent) {
      counter++;
      if(counter > count) return cards;
      if(currentEvent.startTime.compareTo(DateTime.now()) > 0) {
        cards.insert(1, Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SmallEventCard(
            event: currentEvent,
            imageURL: currentEvent.picture,
            place: currentEvent.locationName ?? "Unname location",
            time: currentEvent.startTime ?? DateTime.now(),
            title: currentEvent.name ?? "Untitled event" ,
          ),
        ));
      }
    });

    return cards;
  }

  List<Widget> _buildTrendingMusicEventsCardList(int count) {
    List<Widget> cards = List<Widget>();

    int counter = 0;

    Widget e = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Text("Trending in Music", style: TextStyle(fontSize: 30.0, fontFamily: "Niramit")),
    );

    // print("DEBUG trending count : ${_trendingEventList.length}");

    // if(_trendingEventList.length == 0) {
    //   // print("DEBUG inside the if statement");
    //   _getTrendingMusicData();
    // }

    cards.add(e);

    if(_trendingEvents == null || _trendingEvents.length == 0) {
      cards.add(Center(child: CircularProgressIndicator()));
      return cards;
    }

    _trendingEvents.forEach((Event currentEvent) {
      counter++;
      if(counter > count) return cards;
      
      // print("DEBUG ${currentEvent.name} picture is ${currentEvent.picture}");
      // print("DEBUG ${currentEvent.name} description is ${currentEvent.description}");
      // print("DEBUG ${currentEvent.name} category is ${currentEvent.category}");
      // print("DEBUG ${currentEvent.name} location is ${currentEvent.locationName}");
      cards.add(Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SmallEventCard(
          event: currentEvent,
          imageURL: currentEvent.picture,
          place: currentEvent.locationName ?? "Unname location",
          time: currentEvent.startTime ?? DateTime.now(),
          title: currentEvent.name ?? "Untitled event" ,
        ),
      ));
    });

    return cards;
  }

  List<Widget> _buildListViewChildren() {
    // TO DO duplicate cards don't sync favorite status. 
    List<Widget> alist = List<Widget>();

    alist.addAll(_buildUpcomingEventsCardList(5));
    alist.addAll(_buildTrendingMusicEventsCardList(5));
    
    return alist;
  }

  void onDragDown(DragDownDetails details) {
    print(details.globalPosition);
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    var linearGradient = const BoxDecoration(
      gradient: const LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[
          // Colors.blue,
          Colors.blue,
          Colors.white,
        ],
      ),
    );

    return Material(
      child: new Container(
        // color: Colors.orange,
        // color: Colors.red,
        // padding: EdgeInsets.symmetric(horizontal: 10.0),
        // color: Colors.red,
        decoration: linearGradient,
        child: _upcomingEvents == null 
        ? const Center(child: const CircularProgressIndicator()) 
        : RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              addAutomaticKeepAlives: false, // Force to kill the Card
              children: _buildListViewChildren(),
            ),
          )
      ),
    );
  }



}

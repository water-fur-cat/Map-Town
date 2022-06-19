# Map Town
## Task: 
I create a map based application that will highlight Chicago landmarks.
<br>
The application make use of MapKit for displaying points of interest on the map and many Foundation classes for managing the data associated with each location and make use of adaptive layout techniques so that it can adjust to the users screen size and orientation. By using Adaptive Layouts, some of the views resize to take advantage of the different screen real estate.
<br>
It uses both Storyboards and programmatic interface design.
<br>
The heads up display contain two labels a star button. Toggle the star's appearance based on the selected state of the UIButton. It puts a prominent UIButton at the bottom of the screen. The button's title is "Favorite Places" and is floating on-top of the map. It annotates the map with points of interest in Chicago.
<br>

## User Interface:
Closed issues:
<br>
<img width="300" height="639" src="https://github.com/water-fur-cat/Map-Town/blob/main/user_interface.jpg"/>
<br>
Add favorite places:
<br>
<img width="300" height="639" src="https://github.com/water-fur-cat/Map-Town/blob/main/favorite_places.jpg"/>
<br>
Deatils:
<br>
<img width="300" height="639" src="https://github.com/water-fur-cat/Map-Town/blob/main/zooming.jpg"/>
<br>
Adaptive layout：
<br>
<img width="639" height="330" src="https://github.com/water-fur-cat/Map-Town/blob/main/left_turn.jpg"/>
<br>

## Process:
When a user taps on a table cell the following sequence of events should happen: <br>
1. The FavoritesViewController should send the information about the tapped cell to the MapViewController using a custom protocol and delegate. <br>
2. The FavoritesViewController should dismiss itself.  <br>
3. When the MapViewController appears, the map's region should animate to highlight the favorite place.  <br>
4. The map view's HUD display view should should the information for the selected favorite place.  <br>
 

## Reference：
- https://stackoverflow.com/questions/42106980/how-to-present-a-viewcontroller-on-half-screen
- https://sarunw.com/posts/how-to-read-plist-file/
- https://medium.com/ios-os-x-development/pass-data-with-delegation-in-swift-86f6bc5d0894
- https://sarunw.com/posts/how-to-read-plist-file/
- https://developer.apple.com/documentation/mapkit/mkmapview/1451988-deselectannotation
- https://abhimuralidharan.medium.com/all-about-protocols-in-swift-11a72d6ea354
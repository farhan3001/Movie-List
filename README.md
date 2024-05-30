# Movie-List

A Flutter mobile app to display movie lists using the https://api.themoviedb.org API

## Explanation

- Uses Clean Code Architecture for Flutter with BLoC as state management
  
- Data that's used only consists of 4 main items parsed from the API:
  -  title
  -  rating
  -  poster
  -  release date

- Testable on Android devices only (not iOS devices) due to a lack of testing resources (requires devices running with Apple OS)
  
- Have a custom splash screen and app icon
  
- Screenshots of all the use cases are located in the [screenshots](https://github.com/farhan3001/Movie-List/tree/master/screenshots) folder
    
- Flow:
  #### Fetch Data:
    - Get movies data from the API using MovieRepository
    - Parse the data into Movie data class by filtering the data to get only the necessary data (title, rating, poster, and release date)
  #### BLoC for Movie List View:
    Using BLoC pattern, fetch the data from Movie data class to suffice in all use cases:
  
    - Handle the movie list displayed on app start
    - Search Result Handling
    - Filter Result Handling
    - Filter + Search Result Handling
    - Error Result Handling
  #### Display:
    - Implemented using a specific UI design, display all the results for multiple cases handled in the BLoC
    - MovieListItem displays the information per movie item from the list of movies contained in Movie data class

## How to Install
- Clone this repository using the command: `git clone https://github.com/farhan3001/Movie-List.git`
- Go to the folder directory (or open through your favorite IDE)
- in terminal, run with the command: `flutter run`
    (make sure to have a mobile device or emulator ready and have flutter in your device)
    - See this [reference](https://docs.flutter.dev/get-started/install) to install flutter

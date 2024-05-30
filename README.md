# Movie-List

A Flutter mobile app to display movie list using https://api.themoviedb.org API

## Explanation

- Uses Clean Code Architecture for Flutter with BLoC as State Management
  
- Data that's used only consists of 4 main item parsed from the API:
  -  title,
  -  rating,
  -  poster,
  -  release date

- Testable in Android devices only (not IOS devices) due to lack of testing resource (requires devices running with Apple OS)
  
- Have a custom splash screen and app icon
  
- Screenshots of all the use cases are located in the [screenshots](https://github.com/farhan3001/Movie-List/tree/master/screenshots) folder
    
- Flow:
  #### Fetch Data:
    - Get the movies data from the API using MovieRepository
    - Parse the data into Movie data class by filtering the data to get only necessary data (title, rating, poster, and release date)
  #### BLoC for Movie List View:
    Using BLoC pattern, fetch the data from Movie data class to suffice all cases:
  
    - Handle display movie list on app start
    - Search Result Handling
    - Filter Result Handling
    - Filter + Search Result Handling
    - Error Result Handling
  #### Display:
     - Implemented using a specific UI design, display all the result for multiple cases handled in the BLoC
     - MovieListItem display the information per movie item from the list of movies consisted in Movie data class 

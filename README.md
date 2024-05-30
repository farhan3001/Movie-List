# Movie-List

A Flutter mobile app to list movies using https://api.themoviedb.org API

## Explanation

- Uses Clean Code Architecture for Flutter with BLoC as State Management
  
- Data that's used only consist of 4 main item:
  -  title,
  -  rating,
  -  poster,
  -  release date
    
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
     Implemented using a specific UI design, display all the result for multiple cases handled in the BLoC

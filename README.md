# user manage App Using BLoC with Clean Architecture
This is a Flutter built using the BLoC pattern and Clean Architecture. The app includes features such as user list, create offline and online user, movie list, and movie detail. It uses http for getting api data. GetIt is used for dependency injection.

## Features

- User List
- User create offline/online (the app should automatically sync the offline data when user connect to internet)
- Movie list
- Movie detail


## Folder Structure
```
lib/
├── blocs/
│   ├── user_list/
│   │   ├── user_list_bloc.dart
│   │   ├── user__list_event.dart
│   │   ├── user__list_state.dart
│   ├── movie_list/
│   │   ├── movie_list_bloc.dart
│   │   ├── movie_list_event.dart
│   │   ├── movie_list_state.dart
│   └── movie_details/
│       ├── movie_detail_bloc.dart
│       ├── movie_detail_event.dart
│       ├── movie_detail_state.dart
├── models/
│   ├── user_list_model.dart
│   ├── user_offline_model.dart
│   ├── user_offline_model.g.dart
│   ├── movie_list_model.dart
│   └── movie_detail_model.dart
├── repositories/
│   ├── user_list_repository.dart
│   └── movie_repository.dart
├── screens/
│   ├── user/
│   │   ├── user_list_screen.dart
│   │   ├── user_offline_add_screen.dart
│   ├── movie/
│   │   ├── movie_list_screen.dart
│   │   ├── movie_detail_screen.dart
├── widgets/
│   ├── helper.dart
├── services/
│   ├── hive_services.dart
│   └── offline_data_handle.dart
│   ├── het_it_dp.dart
├── utils/
│   ├── constants.dart
├── main.dart
```


## **For this Assignment below packages are use :**

Programming Language: Dart

● Architecture:  flutter_bloc: ^9.1.0

● Dependency Injection: get_it: ^8.0.3

● Networking:  http: ^1.3.0

● Local Storage: hive: ^2.2.3, hive_flutter: ^1.1.0
  
● Offline Handling: workmanager and for internet connectivity: connectivity_plus: ^6.1.4

● Pagination: Infinite scroll 

● Asynchronous Data Handling: Bloc

● Image Loading: cached_network_image: ^3.4.1




## **Below are screen wise functionality :**
**1. main.dart**

 make instance of getIt and Register all blocs class it will use for dependency injection, 

**2. User List Screen**

Fetch and Display Users

Use the http package to make a GET request to https://reqres.in/api/users?page={page}.
Create a User  model to represent user data.
Use a ListView.builder to display the list of users with their first name, last name, and avatar image.
Pagination with help ScrollController class

**3. Add User Functionality**

Floating Action Button on User list screen

Create User Screen

Use TextField widgets to input the name and job.
On submission, check for internet connectivity and either POST to the API or save to local storage into hive.

user Connectivity() class for internet connectivity and if user internet is active hive data sync to Post api with help of Workmanager



**4. Movie List Screen**

Fetch Movies

Make a GET request to https://api.themoviedb.org/3/trending/movie/day?language=en-US&page={page}&api_key=YOUR_API_KEY.
Display Movies

Use a ListView.builder to display each movie's poster, title, and release date.
Pagination with help ScrollController class

Implement pagination similar to the User List Screen.
Navigation

Navigate to the Movie Detail Screen on movie click.



**5. Movie Detail Screen**

Fetch Movie Details

Make a GET request to https://api.themoviedb.org/3/movie/{movie_id}?api_key=YOUR_API_KEY.
Display Details

Show the movie title, description, release date, and poster image.

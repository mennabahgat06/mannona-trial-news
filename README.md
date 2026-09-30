# Mannona News (Khaber)

News + weather app built with Flutter, Dio and a feature-first structure.

## Run
```
flutter pub get
flutter run
```
> The project has only the `web` platform folder. To run on a phone, add the
> platforms once: `flutter create --platforms=android,ios .`

## Screens (App flow)
1. Splash  ->  2. Welcome  ->  3. Location / Name  ->  Home shell with 4 tabs:
4. Home feed  5. Explore (+ Search results, Article details)  6. Bookmarks  7. Weather

## APIs (see `news.json`)
| Endpoint | Service | Used in |
|---|---|---|
| GET `newsapi.org/v2/top-headlines` | `NewsService.getTopHeadlines()` | Home (featured + Most Popular) |
| GET `newsapi.org/v2/everything` | `NewsService.getEverything()` | Explore categories + Search |
| GET `api.openweathermap.org/data/2.5/weather` | `WeatherService.getWeather()` | Home header + Weather screen |

## Structure (one class per file)
```
lib/
  main.dart
  core/
    network/   api_consumer, api_exception, dio_consumer, dio_factory, end_points
    storage/   bookmark_storage, user_storage
    utils/     app_colors, app_fonts, date_helper, weather_icon_helper
    widgets/   custom_txt_field, app_network_image, primary_button, loading_view, error_view
  features/
    splash_screen/    presentation/
    welcome_screen/   presentation/ (+ widgets)
    location_screen/  presentation/ (+ widgets)
    home_screen/      presentation/ (+ widgets)
    explore_screen/   data/ (models, services) + presentation/ (+ widgets)
    article_screen/   presentation/ (+ widgets)
    bookmark_screen/  presentation/ (+ widgets)
    weather_screen/   data/ (models, services) + presentation/ (+ widgets)
```

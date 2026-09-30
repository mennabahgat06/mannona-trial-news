# Review – Mannona News

## Screens (all 7 from the project guide are built and linked)
| # | Screen | File | Status |
|---|---|---|---|
| 1 | Splash ("Khaber", 2 s) | splash_screen/presentation/splash_screen.dart | Done. Skips Welcome if the name is already saved |
| 2 | Welcome (buildings + Explore) | welcome_screen/presentation/welcome_screen.dart | Done |
| 3 | Location / Name (map + Get Started) | location_screen/presentation/location_search_screen.dart | Fixed: name + picked location are now saved and used by Home/Weather |
| 4 | Home feed (greeting, weather, featured, Most Popular) | home_screen/presentation/home_screen.dart | Fixed: real name, real date, real weather condition |
| 5 | Explore (search, categories, hero, list) + Search results | explore_screen/presentation/ | Fixed: search field now works (press search / enter) |
| – | Article details (bookmark, share) | article_screen/presentation/article_detail_screen.dart | Fixed: share copies the link |
| 6 | Bookmarks (long press -> delete dialog) | bookmark_screen/presentation/bookmark_screen.dart | Fixed: updates live when you bookmark an article |
| 7 | Weather (details + change city) | weather_screen/presentation/weather_screen.dart | Fixed: text showed "${...}" instead of values |

## Bugs found and fixed
1. **Bottom nav never changed tabs** – `IndexedStack(index: 0)` was hard-coded.
2. **The project did not compile** – many imports used `../../../../core/...` (one level too many) and pointed to `core/constants` / old files.
3. **Values printed as text** – `const Text('\${weather.temp}')` escaped the `$`, so the screen showed `${_weather!.temp}` literally (Weather, Explore, Article).
4. **Duplicate classes** – two `ArticleDetailScreen`, two `BookmarkScreen`, two `LocationSearchScreen`, two `AppColors/AppFonts/AppAssets` (core/constants + core/utils). Old copies removed.
5. Old files used images that do not exist in assets (`Image.asset(...)` would crash) and fields that do not exist (`article.date`, `imagePath`).
6. API errors were swallowed (returned `[]`), so the user saw an empty screen. Now an error message + "Try again" is shown.
7. Weather: Kelvin-to-Celsius guess removed; the request now sends `units=metric`. Wind unit fixed (m/s).
8. Greeting / date / "Ahmed Saber" / "Sunny" were hard-coded.
9. Explore search field and Search results "x" button did nothing.
10. NewsAPI "content" ends with "[+1234 chars]" – now cleaned.

## APIs (news.json) – all linked
| Postman request | Code | Used by |
|---|---|---|
| everything | NewsService.getEverything | Explore categories, Search |
| top-headlines | NewsService.getTopHeadlines | Home |
| weather | WeatherService.getWeather (lat/lon or city) | Home header, Weather |

## Refactor
* One class per file (a StatefulWidget and its private `State` stay together – Flutter needs that).
* Big `build` methods split into small widgets: HomeHeader, NavBarItem, CategoriesBar,
  ExploreHeroCard, ArticleActionBar, WeatherSummary, WeatherStatsGrid, ChangeLocationDialog,
  BuildingsIllustration, WelcomeCard, LocationMap, NameInputBar.
* Shared widgets in core/widgets: AppNetworkImage, PrimaryButton, LoadingView, ErrorView.
* `BookmarkStorage` saves bookmarks only; name + location moved to `UserStorage`.

## Note
Only the `web` platform folder exists. To run on Android/iOS once: `flutter create --platforms=android,ios .`

// bloc/all_servicemen_location_and_cat_event.dart
abstract class AllServicemenLocationAndCatEvent {}

class FetchAllServicemenLocationAndCat extends AllServicemenLocationAndCatEvent {
  final String category;
  final String location;

  FetchAllServicemenLocationAndCat({required this.category, required this.location});
}

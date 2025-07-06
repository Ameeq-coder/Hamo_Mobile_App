abstract class AllServicemanEvent {}

class FetchAllServicemanByLocation extends AllServicemanEvent {
  final String location;

  FetchAllServicemanByLocation(this.location);
}
abstract class ServiceDetailEvent {}

class FetchServiceDetail extends ServiceDetailEvent {
  final String serviceManId;

  FetchServiceDetail(this.serviceManId);
}

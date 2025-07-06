abstract class HomeUserDetailEvent {}

class FetchUserDetail extends HomeUserDetailEvent {
  final String userId;

  FetchUserDetail(this.userId);
}

abstract class FavoriteEvent {}

class LoadFavorites extends FavoriteEvent {}

class AddToFavorites extends FavoriteEvent {
  final String productId;
  AddToFavorites({required this.productId});
}

class RemoveFromFavorites extends FavoriteEvent {
  final String productId;
  RemoveFromFavorites({required this.productId});
}

class CheckFavoriteStatus extends FavoriteEvent {
  final String productId;
  CheckFavoriteStatus({required this.productId});
}

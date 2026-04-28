import 'package:folbari/features/favorites/data/models/favorite_model.dart';

enum FavoriteStatus { initial, loading, loaded, error }

class FavoriteState {
  final FavoriteStatus status;
  final List<FavoriteModel> favorites;
  final Set<String> favoriteProductIds;
  final String? errorMessage;

  const FavoriteState({
    this.status = FavoriteStatus.initial,
    this.favorites = const [],
    this.favoriteProductIds = const {},
    this.errorMessage,
  });

  FavoriteState copyWith({
    FavoriteStatus? status,
    List<FavoriteModel>? favorites,
    Set<String>? favoriteProductIds,
    String? errorMessage,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      favoriteProductIds: favoriteProductIds ?? this.favoriteProductIds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool isFavorite(String productId) => favoriteProductIds.contains(productId);
}

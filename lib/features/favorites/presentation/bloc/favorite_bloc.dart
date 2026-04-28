import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/features/favorites/domain/usecases/favorite_usecases.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoritesUseCase getFavorites;
  final AddFavoriteUseCase addFavorite;
  final RemoveFavoriteUseCase removeFavorite;
  final CheckIsFavoriteUseCase checkIsFavorite;

  FavoriteBloc({
    required this.getFavorites,
    required this.addFavorite,
    required this.removeFavorite,
    required this.checkIsFavorite,
  }) : super(const FavoriteState()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
  }

  void _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(state.copyWith(status: FavoriteStatus.loading));

    try {
      final favorites = await getFavorites();
      final favoriteIds = favorites.map((f) => f.productId).toSet();

      emit(
        state.copyWith(
          status: FavoriteStatus.loaded,
          favorites: favorites,
          favoriteProductIds: favoriteIds,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FavoriteStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onAddToFavorites(
    AddToFavorites event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      await addFavorite(event.productId);
      final updatedIds = Set<String>.from(state.favoriteProductIds)
        ..add(event.productId);
      emit(state.copyWith(favoriteProductIds: updatedIds));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void _onRemoveFromFavorites(
    RemoveFromFavorites event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      await removeFavorite(event.productId);
      final updatedIds = Set<String>.from(state.favoriteProductIds)
        ..remove(event.productId);
      emit(state.copyWith(favoriteProductIds: updatedIds));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}

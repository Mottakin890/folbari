import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/features/basket/domain/usecases/basket_usecases.dart';
import 'package:folbari/features/basket/presentation/bloc/basket_event.dart';
import 'package:folbari/features/basket/presentation/bloc/basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final GetBasketItems getBasketItems;
  final AddToBasket addToBasket;
  final RemoveFromBasket removeFromBasket;
  final UpdateBasketQuantity updateBasketQuantity;

  BasketBloc({
    required this.getBasketItems,
    required this.addToBasket,
    required this.removeFromBasket,
    required this.updateBasketQuantity,
  }) : super(BasketState()) {
    on<LoadBasket>(_onLoadBasket);
    on<AddItemToBasket>(_onAddItemToBasket);
    on<RemoveItemFromBasket>(_onRemoveItemFromBasket);
    on<UpdateItemQuantity>(_onUpdateItemQuantity);
  }

  Future<void> _onLoadBasket(LoadBasket event, Emitter<BasketState> emit) async {
    emit(state.copyWith(isLoading: true));
    final items = await getBasketItems();
    emit(state.copyWith(items: items, isLoading: false));
  }

  Future<void> _onAddItemToBasket(AddItemToBasket event, Emitter<BasketState> emit) async {
    await addToBasket(event.item);
    add(LoadBasket());
  }

  Future<void> _onRemoveItemFromBasket(RemoveItemFromBasket event, Emitter<BasketState> emit) async {
    await removeFromBasket(event.itemId);
    add(LoadBasket());
  }

  Future<void> _onUpdateItemQuantity(UpdateItemQuantity event, Emitter<BasketState> emit) async {
    await updateBasketQuantity(event.itemId, event.quantity);
    add(LoadBasket());
  }
}

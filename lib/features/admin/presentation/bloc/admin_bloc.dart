import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/features/admin/domain/usecases/admin_usecases.dart';
import 'package:folbari/features/admin/presentation/bloc/admin_event.dart';
import 'package:folbari/features/admin/presentation/bloc/admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final GetAnalytics getAnalytics;
  final GetAllUsers getAllUsers;
  final DeleteUser deleteUser;
  final UpdateUserRole updateUserRole;
  final AddProduct addProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;

  AdminBloc({
    required this.getAnalytics,
    required this.getAllUsers,
    required this.deleteUser,
    required this.updateUserRole,
    required this.addProduct,
    required this.updateProduct,
    required this.deleteProduct,
  }) : super(const AdminState()) {
    on<LoadAdminDashboard>(_onLoadDashboard);
    on<LoadAllUsers>(_onLoadUsers);
    on<AdminDeleteUser>(_onDeleteUser);
    on<AdminUpdateUserRole>(_onUpdateUserRole);
    on<AdminAddProduct>(_onAddProduct);
    on<AdminUpdateProduct>(_onUpdateProduct);
    on<AdminDeleteProduct>(_onDeleteProduct);
  }

  Future<void> _onLoadDashboard(LoadAdminDashboard event, Emitter<AdminState> emit) async {
    emit(state.copyWith(status: AdminStatus.loading));
    try {
      final analytics = await getAnalytics();
      emit(state.copyWith(status: AdminStatus.loaded, analytics: analytics));
    } catch (e) {
      emit(state.copyWith(status: AdminStatus.error, error: e.toString()));
    }
  }

  Future<void> _onLoadUsers(LoadAllUsers event, Emitter<AdminState> emit) async {
    emit(state.copyWith(status: AdminStatus.loading));
    try {
      final users = await getAllUsers();
      emit(state.copyWith(status: AdminStatus.loaded, users: users));
    } catch (e) {
      emit(state.copyWith(status: AdminStatus.error, error: e.toString()));
    }
  }

  Future<void> _onDeleteUser(AdminDeleteUser event, Emitter<AdminState> emit) async {
    try {
      await deleteUser(event.userId);
      add(LoadAllUsers());
    } catch (e) {
      emit(state.copyWith(status: AdminStatus.error, error: e.toString()));
    }
  }

  Future<void> _onUpdateUserRole(AdminUpdateUserRole event, Emitter<AdminState> emit) async {
    try {
      await updateUserRole(event.userId, event.role);
      add(LoadAllUsers());
    } catch (e) {
      emit(state.copyWith(status: AdminStatus.error, error: e.toString()));
    }
  }

  Future<void> _onAddProduct(AdminAddProduct event, Emitter<AdminState> emit) async {
    try {
      await addProduct(event.product);
      // add(LoadProducts()); // If we had a load products event
    } catch (e) {
      emit(state.copyWith(status: AdminStatus.error, error: e.toString()));
    }
  }

  Future<void> _onUpdateProduct(AdminUpdateProduct event, Emitter<AdminState> emit) async {
    try {
      await updateProduct(event.product);
    } catch (e) {
      emit(state.copyWith(status: AdminStatus.error, error: e.toString()));
    }
  }

  Future<void> _onDeleteProduct(AdminDeleteProduct event, Emitter<AdminState> emit) async {
    try {
      await deleteProduct(event.productId);
    } catch (e) {
      emit(state.copyWith(status: AdminStatus.error, error: e.toString()));
    }
  }
}

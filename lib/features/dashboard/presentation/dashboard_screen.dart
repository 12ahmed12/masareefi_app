import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:masareefi/core/constants/dummy_data.dart';
import 'package:masareefi/core/di/service_locator.dart';
import 'package:masareefi/core/routing/routes.dart';
import 'package:masareefi/core/theming/colors.dart';
import 'package:masareefi/core/theming/styles.dart';
import 'package:masareefi/features/auth/cubit/auth_cubit.dart';
import 'package:masareefi/features/dashboard/logic/dashboard_cubit.dart';
import 'package:masareefi/features/dashboard/logic/dashboard_states.dart';
import 'package:masareefi/features/dashboard/presentation/widgets/empty_expenses.dart';
import 'package:masareefi/features/dashboard/presentation/widgets/expenses_card.dart';
import 'package:masareefi/features/dashboard/presentation/widgets/expenses_tile.dart';
import 'package:masareefi/features/dashboard/presentation/widgets/header.dart';
import 'package:masareefi/features/dashboard/presentation/widgets/loading_indicator.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/helpers/pdf_export_helper.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late ScrollController _scrollController;
  bool _isFilterLoading = false;
  bool _isInitialLoad = true;
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardCubit>().loadDashboardData();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll - 150 && !_isFetchingMore) {
      logger.w('⚠️ Triggering load more');
      _isFetchingMore = true;
      _loadMoreExpenses();
    }
  }

  void _loadMoreExpenses() {
    final currentState = context.read<DashboardCubit>().state;
    if (currentState is DashboardLoaded ||
        currentState is DashboardLoadMoreComplete) {
      context.read<DashboardCubit>().loadMoreExpenses();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) {
          if (state is DashboardLoadMoreComplete ||
              state is DashboardLoaded ||
              state is DashboardError) {
            _isFetchingMore = false;
          }

          if (state is DashboardLoadMoreComplete) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.hasMoreData
                      ? 'تم تحميل المزيد من البيانات'
                      : 'لا توجد المزيد من البيانات',
                ),
                backgroundColor: state.hasMoreData
                    ? AppColors.mainColor
                    : AppColors.secondaryText,
                duration: const Duration(seconds: 1),
              ),
            );
          }

          if (state is DashboardLoaded && _isFilterLoading) {
            setState(() => _isFilterLoading = false);
          }
        },
        builder: (context, state) {
          DashboardLoaded? loadedState;
          bool isLoadingMore = false;

          if (state is DashboardLoaded) {
            loadedState = state;
            _isInitialLoad = false;
          } else if (state is DashboardLoadingMore) {
            loadedState = state.currentState;
            isLoadingMore = true;
          } else if (state is DashboardLoadMoreComplete) {
            loadedState = state.updatedState;
            isLoadingMore = false;
          }

          final showInitialLoader = state is DashboardLoading && _isInitialLoad;

          return Column(
            children: [
              if (!showInitialLoader && loadedState != null)
                _buildFixedHeader(context, loadedState),
              Expanded(
                child: showInitialLoader
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.mainColor),
                      )
                    : (loadedState != null
                        ? _buildScrollableBody(
                            context, loadedState, isLoadingMore)
                        : const SizedBox.shrink()),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'pdfExport',
            onPressed: () async {
              final expenses = context.read<DashboardCubit>().currentExpenses;
              final file =
                  await PdfExportHelper.generateExpenseReport(expenses);
              await Share.shareXFiles([XFile(file.path)],
                  text: 'تقرير المصروفات');
            },
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.picture_as_pdf, color: Colors.white),
          ),
          SizedBox(height: 12.h),
          FloatingActionButton(
            heroTag: 'addExpense',
            onPressed: () {
              context.pushNamed(Routes.addExpense).then((value) {
                if (value == true) {
                  context.read<DashboardCubit>().refreshDashboard();
                }
              });
            },
            backgroundColor: AppColors.mainColor,
            child: Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildFixedHeader(BuildContext context, DashboardLoaded state) {
    return SizedBox(
      height: 240.h,
      child: Stack(
        children: [
          DashboardHeader(
            state: state,
            onFilterChanged: _onFilterChanged,
            onLogoutTapped: () => _showLogoutDialog(context),
          ),
          Positioned(
            top: 85.h,
            left: 24.w,
            right: 24.w,
            child: ExpenseCard(state: state),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableBody(
      BuildContext context, DashboardLoaded state, bool isLoadingMore) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _isInitialLoad = true;
          _isFetchingMore = false;
        });
        context.read<DashboardCubit>().refreshDashboard();
      },
      color: AppColors.mainColor,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _buildRecentExpensesHeader(context)),
          if (_isFilterLoading)
            const SliverToBoxAdapter(child: LoadingIndicatorWidget.filter())
          else if (state.recentExpenses.isEmpty)
            SliverToBoxAdapter(
              child: EmptyExpensesWidget(
                onActionTap: () => context.pushNamed(Routes.addExpense),
                actionText: 'إضافة أول مصروف',
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final expense = state.recentExpenses[index];
                  return ExpenseTile(
                    expense: expense,
                    categories: Dummy.kDefaultCategories,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تفاصيل مصروف: ${expense.categoryId}'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  );
                },
                childCount: state.recentExpenses.length,
              ),
            ),
          if (isLoadingMore)
            const SliverToBoxAdapter(child: LoadingIndicatorWidget.small()),
          SliverToBoxAdapter(child: SizedBox(height: 100.h)),
        ],
      ),
    );
  }

  Widget _buildRecentExpensesHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'المصروفات الأخيرة',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
            ),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('مشاهدة الكل - قريباً'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text(
              'مشاهدة الكل',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.mainColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onFilterChanged(String newFilter) {
    setState(() {
      _isFilterLoading = true;
      _isFetchingMore = false;
    });
    context.read<DashboardCubit>().changeFilterAndResetPagination(newFilter);
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        contentPadding: EdgeInsets.all(24.w),
        title: Column(
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: AppColors.errorColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.logout_rounded,
                  color: AppColors.errorColor, size: 30.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              'تأكيد تسجيل الخروج',
              style: TextStyles.font18DarkBlueBold.copyWith(fontSize: 20.sp),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Text(
          'هل أنت متأكد من أنك تريد تسجيل الخروج من التطبيق؟',
          style: TextStyles.font14DarkBlueMedium.copyWith(
            color: AppColors.secondaryText,
            fontSize: 15.sp,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => context.pop(),
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.borderColor,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text('إلغاء',
                      style: TextStyles.font14DarkBlueMedium
                          .copyWith(color: AppColors.primaryText)),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    context.pop();
                    _performLogout(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.errorColor,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text('تسجيل خروج',
                      style: TextStyles.font14DarkBlueMedium
                          .copyWith(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _performLogout(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: 20.w,
              height: 20.h,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
            SizedBox(width: 12.w),
            Text('جاري تسجيل الخروج...',
                style: TextStyles.font14DarkBlueMedium
                    .copyWith(color: Colors.white)),
          ],
        ),
        backgroundColor: AppColors.mainColor,
        duration: const Duration(seconds: 1),
      ),
    );

    Future.delayed(const Duration(milliseconds: 800), () {
      getIt<AuthCubit>().logout();
      context.go(Routes.loginScreen);
    });
  }
}

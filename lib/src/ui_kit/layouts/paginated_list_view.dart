import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PaginatedListView extends StatefulWidget {
  final int? maxAmount;
  final bool canLoadMore;
  final Widget? Function(BuildContext, int) itemBuilder;
  final List<dynamic>? uniqueIds;
  final int itemCount;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final Function()? onRefresh;
  final Function()? onLoad;
  final Widget? refreshIndicator;
  final Widget? loadIndicator;
  final FlutterListViewController? flutterListViewController;
  final Widget? emptyWidget;
  final double? itemExtent;

  const PaginatedListView({
    Key? key,
    this.maxAmount,
    this.canLoadMore = true,
    required this.itemBuilder,
    required this.itemCount,
    this.padding,
    this.onRefresh,
    this.onLoad,
    this.shrinkWrap = false,
    this.refreshIndicator,
    this.loadIndicator,
    this.uniqueIds,
    this.flutterListViewController,
    this.emptyWidget,
    this.itemExtent,
  }) : super(key: key);

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final RefreshController _emptyRefreshController =
      RefreshController(initialRefresh: false);

  late FlutterListViewController _listViewController;

  final ValueNotifier<bool> _showLoadIndicator = ValueNotifier(false);
  final ValueNotifier<bool> _showTopShadows = ValueNotifier(false);
  final ValueNotifier<bool> _showTopButton = ValueNotifier(false);

  @override
  void initState() {
    _listViewController =
        widget.flutterListViewController ?? FlutterListViewController();
    _listViewController.addListener(_listenScroll);
    super.initState();
  }

  @override
  void dispose() {
    _listViewController.removeListener(_listenScroll);

    super.dispose();
  }

  Widget get refreshIndicator =>
      widget.refreshIndicator ?? const CircularProgressIndicator();

  Widget get loadIndicator =>
      widget.loadIndicator ??
      const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 3),
      );

  void _listenScroll() {
    if (_listViewController.position.pixels > 0 && !_showTopShadows.value) {
      _showTopShadows.value = true;
    } else if (_listViewController.position.pixels == 0 &&
        _showTopShadows.value) {
      _showTopShadows.value = false;
    }
    if (_listViewController.position.pixels >
            MediaQuery.of(context).size.height &&
        !_showTopButton.value) {
      _showTopButton.value = true;
    } else if (_listViewController.position.pixels <=
            MediaQuery.of(context).size.height &&
        _showTopButton.value) {
      _showTopButton.value = false;
    }
    if (widget.maxAmount != null && widget.itemCount == widget.maxAmount) {
      return;
    }
    if (!widget.canLoadMore) return;
    if (!kIsWeb) return;
    if (_listViewController.position.maxScrollExtent -
            _listViewController.position.pixels <
        MediaQuery.of(context).size.height) {
      widget.onLoad?.call();
      _showLoadIndicator.value = true;
    }
  }

  void _onRefreshing() {
    widget.onRefresh?.call();
    _refreshController.refreshCompleted();
  }

  void _onLoading() {
    widget.onLoad?.call();
    _refreshController.loadComplete();
  }

  void _onEmptyRefreshing() {
    widget.onRefresh?.call();
    _emptyRefreshController.refreshCompleted();
  }

  void _onEmptyLoading() {
    widget.onLoad?.call();
    _emptyRefreshController.loadComplete();
  }

  @override
  void didUpdateWidget(PaginatedListView oldWidget) {
    _showLoadIndicator.value = false;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.itemCount == 0 ? _hasNoEntities() : _hasEntities(),
        ValueListenableBuilder(
          builder: (context, value, _) => Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: AnimatedContainer(
                duration: kThemeAnimationDuration,
                height: 8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      value
                          ? Colors.black.withOpacity(0.06)
                          : Colors.black.withOpacity(0.00),
                      Colors.black.withOpacity(0.00)
                    ],
                  ),
                ),
              ),
            ),
          ),
          valueListenable: _showTopShadows,
        ),
        // ValueListenableBuilder(
        //   builder: (context, value, child) => AnimatedPositioned(
        //     duration: kThemeAnimationDuration,
        //     right: 16,
        //     bottom: value ? 70 : -100,
        //     child: child ?? const SizedBox(),
        //   ),
        //   valueListenable: _showTopButton,
        //   child: ScrollUpButton(
        //     onTap: () => _listViewController.animateTo(
        //       0,
        //       duration: kThemeAnimationDuration,
        //       curve: Curves.easeInOut,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _hasEntities() => ValueListenableBuilder(
        builder: (context, value, child) => RefreshConfiguration(
          headerBuilder: () => ClassicHeader(
            idleText: '',
            releaseText: '',
            refreshingText: '',
            completeText: '',
            idleIcon: refreshIndicator,
            refreshingIcon: refreshIndicator,
            releaseIcon: refreshIndicator,
            completeIcon: refreshIndicator,
          ),
          footerBuilder: () => ClassicFooter(
            loadStyle: value ? LoadStyle.ShowAlways : LoadStyle.ShowWhenLoading,
            idleText: '',
            loadingText: '',
            canLoadingText: '',
            idleIcon: loadIndicator,
            loadingIcon: loadIndicator,
            canLoadingIcon: loadIndicator,
          ),
          child: child ?? const SizedBox(),
        ),
        valueListenable: _showLoadIndicator,
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp:
              widget.itemCount < (widget.maxAmount ?? widget.itemCount + 1) ||
                  widget.canLoadMore,
          onRefresh: _onRefreshing,
          onLoading: _onLoading,
          controller: _refreshController,
          scrollController: _listViewController,
          child: FlutterListView(
            controller: _listViewController,
            delegate: FlutterListViewDelegate(
              widget.itemBuilder,
              childCount: widget.itemCount,
              keepPosition: true,
              onItemKey: widget.uniqueIds == null
                  ? null
                  : (index) => widget.uniqueIds![index].toString(),
              preferItemHeight: widget.itemExtent ?? 50,
            ),
            shrinkWrap: true,
          ),
        ),
      );

  Widget _hasNoEntities() => RefreshConfiguration(
        headerBuilder: () => ClassicHeader(
          idleText: '',
          releaseText: '',
          refreshingText: '',
          completeText: '',
          idleIcon: refreshIndicator,
          refreshingIcon: refreshIndicator,
          releaseIcon: refreshIndicator,
          completeIcon: refreshIndicator,
        ),
        footerBuilder: () => ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          idleText: '',
          loadingText: '',
          canLoadingText: '',
          idleIcon: loadIndicator,
          loadingIcon: loadIndicator,
          canLoadingIcon: loadIndicator,
        ),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: _onEmptyRefreshing,
          onLoading: _onEmptyLoading,
          controller: _emptyRefreshController,
          child: widget.emptyWidget,
        ),
      );
}

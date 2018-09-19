import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/src/_internal_date_time/all.dart';
import 'package:calendar_views/src/custom_page_view/all.dart';

import '_constriants_validator.dart';
import '_page_month.dart';
import 'month_page_builder.dart';
import 'month_page_communicator.dart';
import 'month_page_controller.dart';

class MonthPageView extends CustomPageView<Month> {
  MonthPageView({
    @required this.minimumMonth,
    this.maximumMonth,
    MonthPageController controller,
    @required this.pageBuilder,
    this.onMonthChanged,
    Axis scrollDirection = CustomPageView.default_scroll_direction,
    bool pageSnapping = CustomPageView.default_page_snapping,
    bool reverse = CustomPageView.default_reverse,
    ScrollPhysics physics = CustomPageView.default_physics,
  })  : this.controller = controller ?? new MonthPageController(),
        assert(minimumMonth != null),
        assert(controller != null),
        assert(pageBuilder != null),
        super(
          scrollDirection: scrollDirection,
          pageSnapping: pageSnapping,
          reverse: reverse,
          physics: physics,
        ) {
    ConstraintsValidator validator = new ConstraintsValidator(
      minimumMonth: new Month.fromDateTime(minimumMonth),
      maximumMonth:
          maximumMonth != null ? new Month.fromDateTime(maximumMonth) : null,
    );
    validator.validateMinimumMonth();
    validator.validateMaximumMonth();
  }

  /// Minimum month (inclusive).
  final DateTime minimumMonth;

  /// Maximum month (inclusive).
  ///
  /// If [maximumMonth] is null the [MonthPageView] is infinite.
  final DateTime maximumMonth;

  /// Object for controlling this [MonthPageView].
  final MonthPageController controller;

  /// Function that builds a page inside [MonthPageView].
  final MonthPageBuilder pageBuilder;

  /// Called whenever the displayed month changes.
  ///
  /// Properties of DateTime except for year and month are set to their default values.
  final ValueChanged<DateTime> onMonthChanged;

  @override
  _MonthPageViewState createState() => new _MonthPageViewState();
}

class _MonthPageViewState extends CustomPageViewState<MonthPageView, Month> {
  PageMonth _pageMonth;

  @override
  void initState() {
    super.initState();

    _pageMonth = _createPageMonth();
    _attachToController();
  }

  @override
  void didUpdateWidget(MonthPageView oldWidget) {
    super.didUpdateWidget(oldWidget);

    _pageMonth = _createPageMonth();

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.detach();
      _attachToController();
    }
  }

  PageMonth _createPageMonth() {
    DateTime minimumMonth = widget.minimumMonth;
    DateTime maximumMonth = widget.maximumMonth;

    return new PageMonth(
      minimumMonth: new Month.fromDateTime(minimumMonth),
      maximumMonth:
          maximumMonth != null ? new Month.fromDateTime(maximumMonth) : null,
    );
  }

  void _attachToController() {
    widget.controller.attach(_createMonthPageCommunicator());
  }

  MonthPageCommunicator _createMonthPageCommunicator() {
    return new MonthPageCommunicator(
      currentMonth: () => currentRepresentation.toDateTime(),
      jumpToMonth: (DateTime month) {
        int page = getPageOfRepresentation(new Month.fromDateTime(month));
        jumpToPage(page);
      },
      animateToMonth: (DateTime month, {duration, curve}) {
        int page = getPageOfRepresentation(new Month.fromDateTime(month));
        return animateToPage(page, duration: duration, curve: curve);
      },
      currentPage: () => currentPage,
      jumpToPage: jumpToPage,
      animateToPage: animateToPage,
    );
  }

  @override
  Month getRepresentationOfPage(int page) {
    return _pageMonth.monthOfPage(page);
  }

  @override
  int getPageOfRepresentation(Month representation) {
    return _pageMonth.pageOfMonth(representation);
  }

  @override
  int get initialPage {
    Month initialMonth = new Month.fromDateTime(widget.controller.initialMonth);
    return getPageOfRepresentation(initialMonth);
  }

  @override
  int get numberOfPages {
    return _pageMonth.numberOfPages;
  }

  @override
  bool areRepresentationsTheSame(Month representation1, Month representation2) {
    return representation1 == representation2;
  }

  @override
  onPageChanged(Month representationOfPage) {
    if (widget.onMonthChanged != null) {
      widget.onMonthChanged(representationOfPage.toDateTime());
    }
  }

  @override
  Widget itemBuilder(BuildContext context, Month representation) {
    return widget.pageBuilder(context, representation.toDateTime());
  }
}

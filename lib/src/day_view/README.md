# Day View

Set of highly customisable widgets for displaying a day view.

Day view can display a single or multiple days.

## Day View Essentials

**DayViewEssentials** is a widget that propagates vital day view related information down the tree.
It must be places before other day view widgets.

## Day View Schedule

**DayViewSchedule** Is the widget that actually displays a day view.

A list of **ScheduleComponents** must be provided, 
items of those components will then be displayed as children of a **DayViewSchedule**. 

### Schedule Positioner

**SchedulePositioner** is an utility that provided information about different areas inside a **DayViewSchedule**.

### Schedule Component

**ScheduleComponent** is an object that builds **items** that are then displayed inside a **DayViewSchedule**.

Some components are already provided by this library,
but you are free to create your own by extending or implementing the **ScheduleComponent** class.

List of already made components:
* **DaySeparationComponent** (builds a widget between each day)
* **EventViewComponent** (for displaying events)
* **SupportLineComponent** (for displaying widgets that indicate some time eg. a line for every hour)
* **TimeIndicationComponent** (for displaying time indicators)

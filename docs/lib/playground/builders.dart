// Playground builder registry: component id -> hand-written builder.
//
// Only components with a builder are present; the playground panel shows
// "Playground coming soon" for every other id. `toggle_group` and `label`
// have no registry component and are therefore absent (P9-2a).

import 'package:docs/playground/builder.dart';

import 'builders/accordion.dart';
import 'builders/alert.dart';
import 'builders/avatar.dart';
import 'builders/badge.dart';
import 'builders/breadcrumb.dart';
import 'builders/button.dart';
import 'builders/calendar.dart';
import 'builders/card.dart';
import 'builders/checkbox.dart';
import 'builders/date_picker.dart';
import 'builders/dialog.dart';
import 'builders/divider.dart';
import 'builders/dropdown_menu.dart';
import 'builders/form.dart';
import 'builders/input.dart';
import 'builders/keyboard_shortcut.dart';
import 'builders/pagination.dart';
import 'builders/popup.dart';
import 'builders/progress.dart';
import 'builders/radio_group.dart';
import 'builders/select.dart';
import 'builders/skeleton.dart';
import 'builders/slider.dart';
import 'builders/spinner.dart';
import 'builders/switch.dart';
import 'builders/tabs.dart';
import 'builders/text_area.dart';
import 'builders/toggle.dart';
import 'builders/tooltip.dart';

/// Hand-written playground builders keyed by component id.
const Map<String, PlaygroundBuilder> kPlaygroundBuilders =
    <String, PlaygroundBuilder>{
      'accordion': buildAccordionPlayground,
      'alert': buildAlertPlayground,
      'avatar': buildAvatarPlayground,
      'badge': buildBadgePlayground,
      'breadcrumb': buildBreadcrumbPlayground,
      'button': buildButtonPlayground,
      'calendar': buildCalendarPlayground,
      'card': buildCardPlayground,
      'checkbox': buildCheckboxPlayground,
      'date_picker': buildDatePickerPlayground,
      'dialog': buildDialogPlayground,
      'divider': buildDividerPlayground,
      'dropdown_menu': buildDropdownMenuPlayground,
      'form': buildFormPlayground,
      'input': buildInputPlayground,
      'keyboard_shortcut': buildKeyboardShortcutPlayground,
      'pagination': buildPaginationPlayground,
      'popup': buildPopupPlayground,
      'progress': buildProgressPlayground,
      'radio_group': buildRadioGroupPlayground,
      'select': buildSelectPlayground,
      'skeleton': buildSkeletonPlayground,
      'slider': buildSliderPlayground,
      'spinner': buildSpinnerPlayground,
      'switch': buildSwitchPlayground,
      'tabs': buildTabsPlayground,
      'text_area': buildTextAreaPlayground,
      'toggle': buildTogglePlayground,
      'tooltip': buildTooltipPlayground,
    };

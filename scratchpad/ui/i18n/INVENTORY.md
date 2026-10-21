# i18n inventory — dashcn kit (components, primitives, blocks, flows, starters)

Final status after the feat/i18n-locales batch. Scan excludes docs-sample
`preview.dart` files and the locale tables themselves. Statuses:
**already localised** (read `ComponentLocalizations` before this batch),
**converted (this batch)**, **no user-facing text** (only asserts, debug
labels, toStrings, separators, numbers, unit/charset/regex data tables,
country proper nouns, key-cap labels, diff porcelain), and **sample
content** (blocks/flows/starters demo copy — the preview.dart doctrine).
Residual literals in converted rows are covered by the guard test
(`dashcn/test/registry/i18n_guard_test.dart`) allow-list with reasons.

## components

| folder | status | notes |
|---|---|---|
| accordion | no user-facing text |  |
| action_sheet | no user-facing text |  |
| alert | no user-facing text |  |
| alert_dialog | no user-facing text |  |
| alpha | no user-facing text |  |
| anchor | no user-facing text |  |
| app | already localised |  |
| async | no user-facing text |  |
| audio_player | converted (this batch) |  |
| autocomplete | no user-facing text |  |
| avatar | no user-facing text |  |
| backdrop_transform | no user-facing text |  |
| badge | no user-facing text |  |
| border_loading | no user-facing text |  |
| breadcrumb | no user-facing text |  |
| button | converted (this batch) |  |
| calendar | already localised |  |
| card | no user-facing text |  |
| card_image | no user-facing text |  |
| carousel | converted (this batch) |  |
| chart | converted (this batch) |  |
| chat | no user-facing text |  |
| checkbox | no user-facing text |  |
| chip | no user-facing text |  |
| chip_input | already localised |  |
| code_snippet | no user-facing text |  |
| collapsible | no user-facing text |  |
| color | no user-facing text |  |
| color_field | converted (this batch) |  |
| color_input | already localised |  |
| color_picker | already localised |  |
| command | already localised |  |
| context_menu | no user-facing text |  |
| country_flag | no user-facing text |  |
| date_picker | already localised |  |
| dialog | already localised |  |
| divider | no user-facing text |  |
| dot_indicator | converted (this batch) |  |
| drawer | no user-facing text |  |
| drawer_container | no user-facing text |  |
| dropdown_menu | no user-facing text |  |
| dropzone | already localised |  |
| empty_state | already localised |  |
| error_system | already localised |  |
| eye_dropper | no user-facing text |  |
| fab | no user-facing text |  |
| feature_carousel | converted (this batch) |  |
| file_diff_viewer | already localised |  |
| file_picker | already localised |  |
| filter_bar | already localised |  |
| form | no user-facing text |  |
| formatted_input | no user-facing text |  |
| formatter | no user-facing text |  |
| gooey_toast | no user-facing text |  |
| group | no user-facing text |  |
| history | no user-facing text |  |
| hover_card | no user-facing text |  |
| hsl | no user-facing text |  |
| hsv | no user-facing text |  |
| icon | no user-facing text |  |
| image | no user-facing text |  |
| image_lightbox | converted (this batch) |  |
| input | no user-facing text |  |
| input_otp | no user-facing text |  |
| item_picker | no user-facing text |  |
| keyboard_shortcut | no user-facing text |  |
| list_tile | no user-facing text |  |
| locale_utils | no user-facing text |  |
| markdown | converted (this batch) |  |
| media_query | no user-facing text |  |
| menu | no user-facing text |  |
| menubar | no user-facing text |  |
| multi_select | already localised |  |
| multiple_choice | no user-facing text |  |
| navigation_bar | no user-facing text |  |
| navigation_menu | no user-facing text |  |
| number_ticker | no user-facing text |  |
| object_input | already localised |  |
| outlined_container | no user-facing text |  |
| overflow_marquee | converted (this batch) |  |
| overlay_configuration | no user-facing text |  |
| page_route | no user-facing text |  |
| pagination | already localised |  |
| patch | no user-facing text |  |
| phone_input | already localised |  |
| pinned_sheet | no user-facing text |  |
| popup | no user-facing text |  |
| progress | no user-facing text |  |
| qr_code | converted (this batch) |  |
| radio_group | no user-facing text |  |
| refresh_trigger | already localised |  |
| resizable | already localised |  |
| scaffold | no user-facing text |  |
| scrollable | no user-facing text |  |
| scrollable_client | no user-facing text |  |
| scrollbar | no user-facing text |  |
| scrollview | no user-facing text |  |
| search_bar | already localised |  |
| segmented_control | no user-facing text |  |
| select | no user-facing text |  |
| selectable | no user-facing text |  |
| signature_pad | converted (this batch) |  |
| skeleton | no user-facing text |  |
| slider | no user-facing text |  |
| sortable | no user-facing text |  |
| spell_check_suggestions_toolbar | already localised |  |
| spinner | converted (this batch) |  |
| stage_container | no user-facing text |  |
| star_rating | no user-facing text |  |
| stepper | converted (this batch) |  |
| steps | no user-facing text |  |
| swipe_actions | no user-facing text |  |
| swiper | no user-facing text |  |
| switch | no user-facing text |  |
| switcher | no user-facing text |  |
| table | no user-facing text |  |
| tabs | no user-facing text |  |
| text_animate | no user-facing text |  |
| text_area | no user-facing text |  |
| time_picker | already localised |  |
| timeline | no user-facing text |  |
| timeline_animation | no user-facing text |  |
| toast | no user-facing text |  |
| toggle | no user-facing text |  |
| toolbar | converted (this batch) |  |
| tooltip | no user-facing text |  |
| tracker | no user-facing text |  |
| tree | converted (this batch) |  |
| triple_dots | no user-facing text |  |
| video_player | converted (this batch) |  |
| wheel_picker | no user-facing text |  |
| window | no user-facing text |  |

## primitives

| folder | status | notes |
|---|---|---|
| README.md | no user-facing text |  |
| animated_value_builder.dart | no user-facing text |  |
| animation.dart | no user-facing text |  |
| animation_queue.dart | no user-facing text |  |
| axis_size.dart | no user-facing text |  |
| basic_layout.dart | no user-facing text |  |
| chart | no user-facing text |  |
| clickable.dart | no user-facing text |  |
| clickable_state.dart | no user-facing text |  |
| color_field_paint.dart | no user-facing text |  |
| color_math.dart | no user-facing text |  |
| countries.dart | no user-facing text |  |
| date_math.dart | no user-facing text |  |
| drag_sort.dart | no user-facing text |  |
| drawer_route | already localised |  |
| error_handling | already localised |  |
| extensions.dart | no user-facing text |  |
| fade_scroll.dart | no user-facing text |  |
| file_value | already localised |  |
| filter_core | no user-facing text |  |
| focus_outline.dart | no user-facing text |  |
| form_core | already localised |  |
| fractional_align_box.dart | no user-facing text |  |
| gooey | converted (this batch) |  |
| hidden.dart | no user-facing text |  |
| hover.dart | no user-facing text |  |
| input_features | no user-facing text |  |
| label.dart | no user-facing text |  |
| layout.dart | no user-facing text |  |
| localizations | already localised |  |
| markdown_parser | converted (this batch) |  |
| masonry_layout.dart | no user-facing text |  |
| measured_extent.dart | no user-facing text |  |
| menu_nav.dart | no user-facing text |  |
| menu_rows.dart | no user-facing text |  |
| motion | no user-facing text |  |
| navigation | no user-facing text |  |
| object_segments.dart | no user-facing text |  |
| overlap_layout.dart | no user-facing text |  |
| overlay.dart | no user-facing text |  |
| overlay_manager.dart | no user-facing text |  |
| overlay_manager_layer.dart | no user-facing text |  |
| phone_number.dart | no user-facing text |  |
| popover.dart | no user-facing text |  |
| popover_controller.dart | no user-facing text |  |
| popover_layout.dart | no user-facing text |  |
| popover_layout_render.dart | no user-facing text |  |
| popover_overlay_handler.dart | no user-facing text |  |
| popover_overlay_state.dart | no user-facing text |  |
| popover_overlay_widget.dart | no user-facing text |  |
| resizable_handle.dart | no user-facing text |  |
| resizable_pane.dart | no user-facing text |  |
| roving_group.dart | no user-facing text |  |
| roving_row.dart | no user-facing text |  |
| screen_capture.dart | no user-facing text |  |
| scroll_metrics.dart | no user-facing text |  |
| search | no user-facing text |  |
| select_popup.dart | no user-facing text |  |
| selectable_radio | no user-facing text |  |
| sheet_overlay.dart | no user-facing text |  |
| sheet_stage.dart | no user-facing text |  |
| slider | no user-facing text |  |
| slider_value.dart | no user-facing text |  |
| sortable_layer.dart | no user-facing text |  |
| streaming_text | no user-facing text |  |
| subfocus.dart | no user-facing text |  |
| subfocus_item.dart | no user-facing text |  |
| subfocus_list_item.dart | no user-facing text |  |
| subfocus_scope.dart | no user-facing text |  |
| surface.dart | no user-facing text |  |
| syntax_highlight | no user-facing text |  |
| tab_container.dart | no user-facing text |  |
| table_layout | already localised |  |
| tap_target.dart | no user-facing text |  |
| text | no user-facing text |  |
| text_editing | already localised |  |
| toast_queue | no user-facing text |  |
| touch_hit_area.dart | no user-facing text |  |
| tree_selection | no user-facing text |  |
| widget_states.dart | no user-facing text |  |
| window_host.dart | no user-facing text |  |
| window_manager.dart | no user-facing text |  |
| window_snap.dart | no user-facing text |  |

## blocks

| folder | status | notes |
|---|---|---|
| account-01 | sample content | settings/profile/team demo screens; demo copy. |
| account-02 | sample content | notification prefs demo; demo copy. |
| calendar-01 | chrome converted + sample copy | Clear/Apply via actionClear/actionApply; months via locale getMonth/getAbbreviatedMonth. Prose stays sample copy. |
| calendar-02 | chrome converted + sample copy | months via locale getMonth. Slot prose and demo date stay sample copy. |
| dashboard-01 | sample content | analytics demo with demo data/names. |
| dashboard-02 | chrome converted + sample copy | Search hintText via filterSearch. Share/reports/devices/download stay sample copy. |
| login-01 | chrome converted + sample copy | Email/Password/Sign in/Forgot password/Remember me/Create account via auth* keys. Prose stays sample copy. |
| login-02 | chrome converted + sample copy | Email/Password/Sign in via auth* keys. Prose stays sample copy. |
| login-03 | chrome converted + sample copy | Email/Password/Sign in via auth* keys. Provider names stay sample copy. |
| otp-01 | chrome converted + sample copy | Code/Verify/Resend/countdown via authCode/actionVerify/actionResend/resendInSeconds. Prose stays sample copy. |
| pricing-01 | sample content | marketing demo copy. |
| sidebar-01 | sample content | inbox demo with demo messages. |
| sidebar-02 | sample content | playground demo copy. |
| sidebar-03 | chrome converted + sample copy | Search hintText via filterSearch. Workspace demo copy stays. |
| signup-01 | chrome converted + sample copy | Name/Email/Password/Create account/Sign in via auth* keys. Legal sentence stays sample copy. |
| signup-02 | chrome converted + sample copy | First/Last name, Work email, Password, Start free trial, Sign in via keys. Aside marketing + legal sentence stay sample copy. |

## flows

| folder | status | notes |
|---|---|---|
| auth-01 | sample content | auth flow demo; labels mirror block chrome keys per screen. |
| chat-01 | sample content | chat demo with demo messages. |
| checkout-01 | sample content | checkout demo with demo products/addresses. |
| onboarding-01 | sample content | onboarding demo prose. |
| settings-01 | sample content | settings demo prose. |

## starters

| folder | status | notes |
|---|---|---|
| chat | sample content | demo copy. |
| saas | sample content | demo copy. |
| shop | sample content | demo copy. |


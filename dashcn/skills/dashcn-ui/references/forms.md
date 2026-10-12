# Forms And Inputs

Install form-heavy screens as a coherent stack, not one widget at a time.

```bash
dashcn dry-run \
  @dashcn/form \
  @dashcn/form_field \
  @dashcn/input \
  @dashcn/text_field \
  @dashcn/text_area \
  @dashcn/select \
  @dashcn/checkbox \
  @dashcn/radio_group \
  @dashcn/switch \
  @dashcn/slider \
  --json
```

```bash
dashcn add \
  @dashcn/form \
  @dashcn/form_field \
  @dashcn/input \
  @dashcn/text_field \
  @dashcn/text_area \
  @dashcn/select \
  @dashcn/checkbox \
  @dashcn/radio_group \
  @dashcn/switch \
  @dashcn/slider
```

## Specialized Inputs

- Search/typeahead: `form/autocomplete`, `form/chip_input`
- Dates/times: `display/calendar`, `form/date_picker`, `form/time_picker`, `form/object_input`
- Color: `form/color_picker`, `form/color_input`, `form/hsv`, `form/hsl`, `form/history`
- Files: `form/file_picker`, `form/file_input`, `form/dropzone`
- Phone: `form/phone_input`
- OTP: `form/input_otp`
- Rating/choice: `form/star_rating`, `form/multiple_choice`, `form/item_picker`
- Formatting/validation: `form/formatter`, `form/validated`, `form/control`

## Validation Rule

Keep validation in form primitives and shared helpers. Do not spread duplicate ad-hoc flags through wrapper widgets when `form`, `form_field`, `validated`, and controlled primitives can own the state.

## Verify

```bash
dashcn validate --json
dashcn audit --json
dashcn deps --json
```

// Playground visibility switch.
//
// When false the Playground (the live editable preview with its controls,
// including the Theme controls) is hidden on every component page: the
// open button, the side panel / bottom sheet and the inline section all
// stay out of the widget tree, so no sidebar link, search result, tab or
// direct route can reach them. The panel, builders, values, code emission
// and tests stay in the tree so the Playground can be re-enabled later
// with this one switch.
const bool kShowPlayground = false;

// Device-frame picker visibility switch.
//
// When false the device-frame chip row (None / iPhone / Android / iPad /
// Desktop / Web / All) is hidden on every component page and previews render
// with no device frame (the "None" behaviour) everywhere. The frame bar's
// rotate/replay and light/dark toggle stay, and the frame code, specs and
// tests stay in the tree so the picker can be re-enabled later with this one
// switch.
const bool kShowDeviceFrames = false;

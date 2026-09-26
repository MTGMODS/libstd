local enums = {}

local enum_mt = {
    __index = function(t, k)
        return 0
    end
}

enums.ActivateFlags = setmetatable({
    ["FromFocusApi"] = 32,
    ["FromShortcut"] = 16,
    ["FromTabbing"] = 8,
    ["None"] = 0,
    ["PreferInput"] = 1,
    ["PreferTweak"] = 2,
    ["TryToPreserveState"] = 4,
}, enum_mt)
ImGuiActivateFlags = enums.ActivateFlags

enums.FontAtlasFlags = setmetatable({
    ["None"] = 0,
    ["NoPowerOfTwoHeight"] = 1,
    ["NoMouseCursors"] = 2,
    ["NoBakedLines"] = 4,
}, enum_mt)
ImGuiFontAtlasFlags = enums.FontAtlasFlags
enums.AtlasFlags = enums.FontAtlasFlags
ImGuiAtlasFlags = enums.AtlasFlags

enums.DrawListFlags = setmetatable({
    ["None"] = 0,
    ["AntiAliasedLines"] = 1,
    ["AntiAliasedLinesUseTex"] = 2,
    ["AntiAliasedFill"] = 4,
    ["AllowVtxOffset"] = 8,
}, enum_mt)
ImGuiDrawListFlags = enums.DrawListFlags

enums.Axis = setmetatable({
    ["None"] = -1,
    ["X"] = 0,
    ["Y"] = 1,
}, enum_mt)
ImGuiAxis = enums.Axis

enums.BackendFlags = setmetatable({
    ["HasGamepad"] = 1,
    ["HasMouseCursors"] = 2,
    ["HasSetMousePos"] = 4,
    ["None"] = 0,
    ["RendererHasTextures"] = 16,
    ["RendererHasVtxOffset"] = 8,
}, enum_mt)
ImGuiBackendFlags = enums.BackendFlags

enums.ButtonFlags = setmetatable({
    ["AlignTextBaseLine"] = 32768,
    ["AllowOverlap"] = 4096,
    ["EnableNav"] = 8,
    ["FlattenChildren"] = 2048,
    ["MouseButtonLeft"] = 1,
    ["MouseButtonMask_"] = 7,
    ["MouseButtonMiddle"] = 4,
    ["MouseButtonRight"] = 2,
    ["NoFocus"] = 4194304,
    ["NoHoldingActiveId"] = 131072,
    ["NoHoveredOnFocus"] = 524288,
    ["NoKeyModsAllowed"] = 65536,
    ["NoNavFocus"] = 262144,
    ["NoSetKeyOwner"] = 1048576,
    ["NoTestKeyOwner"] = 2097152,
    ["None"] = 0,
    ["PressedOnClick"] = 16,
    ["PressedOnClickRelease"] = 32,
    ["PressedOnClickReleaseAnywhere"] = 64,
    ["PressedOnDefault_"] = 32,
    ["PressedOnDoubleClick"] = 256,
    ["PressedOnDragDropHold"] = 512,
    ["PressedOnMask_"] = 1008,
    ["PressedOnRelease"] = 128,
}, enum_mt)
ImGuiButtonFlags = enums.ButtonFlags

enums.ChildFlags = setmetatable({
    ["AlwaysAutoResize"] = 64,
    ["AlwaysUseWindowPadding"] = 2,
    ["AutoResizeX"] = 16,
    ["AutoResizeY"] = 32,
    ["Borders"] = 1,
    ["FrameStyle"] = 128,
    ["NavFlattened"] = 256,
    ["None"] = 0,
    ["ResizeX"] = 4,
    ["ResizeY"] = 8,
}, enum_mt)
ImGuiChildFlags = enums.ChildFlags

local col_enum_mt = {
    __index = function(t, k)
        return nil
    end
}

enums.Col = setmetatable({
    ["Border"] = 5,
    ["BorderShadow"] = 6,
    ["Button"] = 21,
    ["ButtonActive"] = 23,
    ["ButtonHovered"] = 22,
    ["COUNT"] = 60,
    ["CheckMark"] = 18,
    ["ChildBg"] = 3,
    ["DragDropTarget"] = 53,
    ["DragDropTargetBg"] = 54,
    ["FrameBg"] = 7,
    ["FrameBgActive"] = 9,
    ["FrameBgHovered"] = 8,
    ["Header"] = 24,
    ["HeaderActive"] = 26,
    ["HeaderHovered"] = 25,
    ["InputTextCursor"] = 33,
    ["MenuBarBg"] = 13,
    ["ModalWindowDimBg"] = 59,
    ["NavCursor"] = 56,
    ["NavHighlight"] = 56,
    ["NavWindowingDimBg"] = 58,
    ["NavWindowingHighlight"] = 57,
    ["PlotHistogram"] = 43,
    ["PlotHistogramHovered"] = 44,
    ["PlotLines"] = 41,
    ["PlotLinesHovered"] = 42,
    ["PopupBg"] = 4,
    ["ResizeGrip"] = 30,
    ["ResizeGripActive"] = 32,
    ["ResizeGripHovered"] = 31,
    ["ScrollbarBg"] = 14,
    ["ScrollbarGrab"] = 15,
    ["ScrollbarGrabActive"] = 17,
    ["ScrollbarGrabHovered"] = 16,
    ["Separator"] = 27,
    ["SeparatorActive"] = 29,
    ["SeparatorHovered"] = 28,
    ["SliderGrab"] = 19,
    ["SliderGrabActive"] = 20,
    ["Tab"] = 35,
    ["TabDimmed"] = 38,
    ["TabDimmedSelected"] = 39,
    ["TabDimmedSelectedOverline"] = 40,
    ["TabHovered"] = 34,
    ["TabSelected"] = 36,
    ["TabSelectedOverline"] = 37,
    ["TableBorderLight"] = 47,
    ["TableBorderStrong"] = 46,
    ["TableHeaderBg"] = 45,
    ["TableRowBg"] = 48,
    ["TableRowBgAlt"] = 49,
    ["Text"] = 0,
    ["TextDisabled"] = 1,
    ["TextLink"] = 50,
    ["TextSelectedBg"] = 51,
    ["TitleBg"] = 10,
    ["TitleBgActive"] = 11,
    ["TitleBgCollapsed"] = 12,
    ["TreeLines"] = 52,
    ["UnsavedMarker"] = 55,
    ["WindowBg"] = 2,

    ["TabActive"] = 36,
    ["TabUnfocused"] = 38,
    ["TabUnfocusedActive"] = 39,
    ["CloseButton"] = 21,
    ["CloseButtonHovered"] = 22,
    ["CloseButtonActive"] = 23,
    ["ChildWindowBg"] = 3,
    ["ComboBg"] = 7,
    ["ModalWindowDarkening"] = 59,
    ["Column"] = 27,
    ["ColumnHovered"] = 28,
    ["ColumnActive"] = 29,
}, col_enum_mt)
ImGuiCol = enums.Col

enums.ColorEditFlags = setmetatable({
    ["AlphaBar"] = 262144,
    ["AlphaMask_"] = 28674,
    ["AlphaNoBg"] = 8192,
    ["AlphaOpaque"] = 4096,
    ["AlphaPreviewHalf"] = 16384,
    ["DataTypeMask_"] = 25165824,
    ["DefaultOptions_"] = 177209344,
    ["DisplayHSV"] = 2097152,
    ["DisplayHex"] = 4194304,
    ["DisplayMask_"] = 7340032,
    ["DisplayRGB"] = 1048576,
    ["Float"] = 16777216,
    ["HDR"] = 524288,
    ["InputHSV"] = 268435456,
    ["InputMask_"] = 402653184,
    ["InputRGB"] = 134217728,
    ["NoAlpha"] = 2,
    ["NoBorder"] = 1024,
    ["NoColorMarkers"] = 2048,
    ["NoDragDrop"] = 512,
    ["NoInputs"] = 32,
    ["NoLabel"] = 128,
    ["NoOptions"] = 8,
    ["NoPicker"] = 4,
    ["NoSidePreview"] = 256,
    ["NoSmallPreview"] = 16,
    ["NoTooltip"] = 64,
    ["None"] = 0,
    ["PickerHueBar"] = 33554432,
    ["PickerHueWheel"] = 67108864,
    ["PickerMask_"] = 100663296,
    ["Uint8"] = 8388608,
}, enum_mt)
ImGuiColorEditFlags = enums.ColorEditFlags

enums.ComboFlags = setmetatable({
    ["CustomPreview"] = 1048576,
    ["HeightLarge"] = 8,
    ["HeightLargest"] = 16,
    ["HeightMask_"] = 30,
    ["HeightRegular"] = 4,
    ["HeightSmall"] = 2,
    ["NoArrowButton"] = 32,
    ["NoPreview"] = 64,
    ["None"] = 0,
    ["PopupAlignLeft"] = 1,
    ["WidthFitPreview"] = 128,
}, enum_mt)
ImGuiComboFlags = enums.ComboFlags

enums.Cond = setmetatable({
    ["Always"] = 1,
    ["Appearing"] = 8,
    ["FirstUseEver"] = 4,
    ["None"] = 0,
    ["Once"] = 2,
}, enum_mt)
ImGuiCond = enums.Cond

enums.ConfigFlags = setmetatable({
    ["IsSRGB"] = 1048576,
    ["IsTouchScreen"] = 2097152,
    ["NavEnableGamepad"] = 2,
    ["NavEnableKeyboard"] = 1,
    ["NoKeyboard"] = 64,
    ["NoMouse"] = 16,
    ["NoMouseCursorChange"] = 32,
    ["None"] = 0,
}, enum_mt)
ImGuiConfigFlags = enums.ConfigFlags

enums.ContextHookType = setmetatable({
    ["EndFramePost"] = 3,
    ["EndFramePre"] = 2,
    ["NewFramePost"] = 1,
    ["NewFramePre"] = 0,
    ["PendingRemoval_"] = 7,
    ["RenderPost"] = 5,
    ["RenderPre"] = 4,
    ["Shutdown"] = 6,
}, enum_mt)
ImGuiContextHookType = enums.ContextHookType

enums.DataType = setmetatable({
    ["Bool"] = 10,
    ["COUNT"] = 12,
    ["Double"] = 9,
    ["Float"] = 8,
    ["ID"] = 13,
    ["Pointer"] = 12,
    ["S16"] = 2,
    ["S32"] = 4,
    ["S64"] = 6,
    ["S8"] = 0,
    ["String"] = 11,
    ["U16"] = 3,
    ["U32"] = 5,
    ["U64"] = 7,
    ["U8"] = 1,
}, enum_mt)
ImGuiDataType = enums.DataType

enums.DebugLogFlags = setmetatable({
    ["EventActiveId"] = 2,
    ["EventClipper"] = 32,
    ["EventDocking"] = 1024,
    ["EventError"] = 1,
    ["EventFocus"] = 4,
    ["EventFont"] = 256,
    ["EventIO"] = 128,
    ["EventInputRouting"] = 512,
    ["EventMask_"] = 4095,
    ["EventNav"] = 16,
    ["EventPopup"] = 8,
    ["EventSelection"] = 64,
    ["EventViewport"] = 2048,
    ["None"] = 0,
    ["OutputToDebugger"] = 2097152,
    ["OutputToTTY"] = 1048576,
    ["OutputToTestEngine"] = 4194304,
}, enum_mt)
ImGuiDebugLogFlags = enums.DebugLogFlags

enums.Dir = setmetatable({
    ["COUNT"] = 4,
    ["Down"] = 3,
    ["Left"] = 0,
    ["None"] = -1,
    ["Right"] = 1,
    ["Up"] = 2,
}, enum_mt)
ImGuiDir = enums.Dir

enums.DragDropFlags = setmetatable({
    ["AcceptBeforeDelivery"] = 1024,
    ["AcceptDrawAsHovered"] = 8192,
    ["AcceptNoDrawDefaultRect"] = 2048,
    ["AcceptNoPreviewTooltip"] = 4096,
    ["AcceptPeekOnly"] = 3072,
    ["None"] = 0,
    ["PayloadAutoExpire"] = 32,
    ["PayloadNoCrossContext"] = 64,
    ["PayloadNoCrossProcess"] = 128,
    ["SourceAllowNullID"] = 8,
    ["SourceExtern"] = 16,
    ["SourceNoDisableHover"] = 2,
    ["SourceNoHoldToOpenOthers"] = 4,
    ["SourceNoPreviewTooltip"] = 1,
}, enum_mt)
ImGuiDragDropFlags = enums.DragDropFlags

enums.DrawCornerFlags = setmetatable({
    ["All"] = 240,
    ["Bot"] = 192,
    ["BotLeft"] = 64,
    ["BotRight"] = 128,
    ["Left"] = 80,
    ["None"] = 256,
    ["Right"] = 160,
    ["Top"] = 48,
    ["TopLeft"] = 16,
    ["TopRight"] = 32,
}, enum_mt)
ImGuiDrawCornerFlags = enums.DrawCornerFlags

enums.DrawFlags = setmetatable({
    ["None"] = 0,
    ["Closed"] = 1,
    ["RoundCornersTopLeft"] = 16,
    ["RoundCornersTopRight"] = 32,
    ["RoundCornersBottomLeft"] = 64,
    ["RoundCornersBottomRight"] = 128,
    ["RoundCornersNone"] = 256,
    ["RoundCornersTop"] = 48,
    ["RoundCornersBottom"] = 192,
    ["RoundCornersBot"] = 192,
    ["RoundCornersLeft"] = 80,
    ["RoundCornersRight"] = 160,
    ["RoundCornersAll"] = 240,
    ["RoundCornersDefault_"] = 240,
    ["RoundCornersMask_"] = 496,
}, enum_mt)
ImGuiDrawFlags = enums.DrawFlags

enums.NavInput = setmetatable({
    ["Activate"] = 0,
    ["Cancel"] = 1,
    ["Input"] = 2,
    ["Menu"] = 3,
    ["DpadLeft"] = 4,
    ["DpadRight"] = 5,
    ["DpadUp"] = 6,
    ["DpadDown"] = 7,
    ["LStickLeft"] = 8,
    ["LStickRight"] = 9,
    ["LStickUp"] = 10,
    ["LStickDown"] = 11,
    ["FocusPrev"] = 12,
    ["FocusNext"] = 13,
    ["TweakSlow"] = 14,
    ["TweakFast"] = 15,
    ["COUNT"] = 16,
}, enum_mt)
ImGuiNavInput = enums.NavInput

enums.Flags = enums.DrawFlags
ImGuiFlags = enums.Flags

enums.FocusRequestFlags = setmetatable({
    ["None"] = 0,
    ["RestoreFocusedChild"] = 1,
    ["UnlessBelowModal"] = 2,
}, enum_mt)
ImGuiFocusRequestFlags = enums.FocusRequestFlags

enums.FocusedFlags = setmetatable({
    ["AnyWindow"] = 4,
    ["ChildWindows"] = 1,
    ["NoPopupHierarchy"] = 8,
    ["None"] = 0,
    ["RootAndChildWindows"] = 3,
    ["RootWindow"] = 2,
}, enum_mt)
ImGuiFocusedFlags = enums.FocusedFlags

enums.HoveredFlags = setmetatable({
    ["AllowWhenBlockedByActiveItem"] = 128,
    ["AllowWhenBlockedByPopup"] = 32,
    ["AllowWhenDisabled"] = 1024,
    ["AllowWhenOverlapped"] = 768,
    ["AllowWhenOverlappedByItem"] = 256,
    ["AllowWhenOverlappedByWindow"] = 512,
    ["AllowedMaskForIsItemHovered"] = 262048,
    ["AllowedMaskForIsWindowHovered"] = 12463,
    ["AnyWindow"] = 4,
    ["ChildWindows"] = 1,
    ["DelayMask_"] = 245760,
    ["DelayNone"] = 16384,
    ["DelayNormal"] = 65536,
    ["DelayShort"] = 32768,
    ["ForTooltip"] = 4096,
    ["NoNavOverride"] = 2048,
    ["NoPopupHierarchy"] = 8,
    ["NoSharedDelay"] = 131072,
    ["None"] = 0,
    ["RectOnly"] = 928,
    ["RootAndChildWindows"] = 3,
    ["RootWindow"] = 2,
    ["Stationary"] = 8192,
}, enum_mt)
ImGuiHoveredFlags = enums.HoveredFlags

enums.InputEventType = setmetatable({
    ["COUNT"] = 7,
    ["Focus"] = 6,
    ["Key"] = 4,
    ["MouseButton"] = 3,
    ["MousePos"] = 1,
    ["MouseWheel"] = 2,
    ["None"] = 0,
    ["Text"] = 5,
}, enum_mt)
ImGuiInputEventType = enums.InputEventType

enums.InputFlags = setmetatable({
    ["CondActive"] = 8388608,
    ["CondDefault_"] = 12582912,
    ["CondHovered"] = 4194304,
    ["CondMask_"] = 12582912,
    ["LockThisFrame"] = 1048576,
    ["LockUntilRelease"] = 2097152,
    ["None"] = 0,
    ["Repeat"] = 1,
    ["RepeatMask_"] = 255,
    ["RepeatRateDefault"] = 2,
    ["RepeatRateMask_"] = 14,
    ["RepeatRateNavMove"] = 4,
    ["RepeatRateNavTweak"] = 8,
    ["RepeatUntilKeyModsChange"] = 32,
    ["RepeatUntilKeyModsChangeFromNone"] = 64,
    ["RepeatUntilMask_"] = 240,
    ["RepeatUntilOtherKeyPress"] = 128,
    ["RepeatUntilRelease"] = 16,
    ["RouteActive"] = 1024,
    ["RouteAlways"] = 8192,
    ["RouteFocused"] = 2048,
    ["RouteFromRootWindow"] = 131072,
    ["RouteGlobal"] = 4096,
    ["RouteOptionsMask_"] = 245760,
    ["RouteOverActive"] = 32768,
    ["RouteOverFocused"] = 16384,
    ["RouteTypeMask_"] = 15360,
    ["RouteUnlessBgFocused"] = 65536,
    ["SupportedByIsKeyPressed"] = 255,
    ["SupportedByIsMouseClicked"] = 1,
    ["SupportedBySetItemKeyOwner"] = 15728640,
    ["SupportedBySetKeyOwner"] = 3145728,
    ["SupportedBySetNextItemShortcut"] = 523519,
    ["SupportedByShortcut"] = 261375,
    ["Tooltip"] = 262144,
}, enum_mt)
ImGuiInputFlags = enums.InputFlags

enums.InputSource = setmetatable({
    ["COUNT"] = 4,
    ["Gamepad"] = 3,
    ["Keyboard"] = 2,
    ["Mouse"] = 1,
    ["None"] = 0,
}, enum_mt)
ImGuiInputSource = enums.InputSource

enums.InputTextFlags = setmetatable({
    ["AllowTabInput"] = 32,
    ["AlwaysOverwrite"] = 2048,
    ["AutoSelectAll"] = 4096,
    ["CallbackAlways"] = 1048576,
    ["CallbackCharFilter"] = 2097152,
    ["CallbackCompletion"] = 262144,
    ["CallbackEdit"] = 8388608,
    ["CallbackHistory"] = 524288,
    ["CallbackResize"] = 4194304,
    ["CharsDecimal"] = 1,
    ["CharsHexadecimal"] = 2,
    ["CharsNoBlank"] = 16,
    ["CharsScientific"] = 4,
    ["CharsUppercase"] = 8,
    ["CtrlEnterForNewLine"] = 256,
    ["DisplayEmptyRefVal"] = 16384,
    ["ElideLeft"] = 131072,
    ["EnterReturnsTrue"] = 64,
    ["EscapeClearsAll"] = 128,
    ["LocalizeDecimalPoint"] = 268435456,
    ["MergedItem"] = 134217728,
    ["Multiline"] = 67108864,
    ["NoHorizontalScroll"] = 32768,
    ["NoUndoRedo"] = 65536,
    ["None"] = 0,
    ["ParseEmptyRefVal"] = 8192,
    ["Password"] = 1024,
    ["ReadOnly"] = 512,
    ["WordWrap"] = 16777216,
}, enum_mt)
ImGuiInputTextFlags = enums.InputTextFlags

enums.ItemFlags = setmetatable({
    ["AllowDuplicateId"] = 32,
    ["AllowOverlap"] = 16384,
    ["AutoClosePopups"] = 16,
    ["ButtonRepeat"] = 8,
    ["Default_"] = 16,
    ["Disabled"] = 64,
    ["HasSelectionUserData"] = 2097152,
    ["Inputable"] = 1048576,
    ["IsMultiSelect"] = 4194304,
    ["MixedValue"] = 4096,
    ["NoFocus"] = 131072,
    ["NoMarkEdited"] = 65536,
    ["NoNav"] = 2,
    ["NoNavDefaultFocus"] = 4,
    ["NoNavDisableMouseHover"] = 32768,
    ["NoTabStop"] = 1,
    ["NoWindowHoverableCheck"] = 8192,
    ["None"] = 0,
    ["ReadOnly"] = 2048,
}, enum_mt)
ImGuiItemFlags = enums.ItemFlags

enums.ItemStatusFlags = setmetatable({
    ["Deactivated"] = 64,
    ["Edited"] = 4,
    ["HasClipRect"] = 512,
    ["HasDeactivated"] = 32,
    ["HasDisplayRect"] = 2,
    ["HasShortcut"] = 1024,
    ["HoveredRect"] = 1,
    ["HoveredWindow"] = 128,
    ["None"] = 0,
    ["ToggledOpen"] = 16,
    ["ToggledSelection"] = 8,
    ["Visible"] = 256,
}, enum_mt)
ImGuiItemStatusFlags = enums.ItemStatusFlags

enums.Key = setmetatable({
    ["0"] = 536,
    ["1"] = 537,
    ["2"] = 538,
    ["3"] = 539,
    ["4"] = 540,
    ["5"] = 541,
    ["6"] = 542,
    ["7"] = 543,
    ["8"] = 544,
    ["9"] = 545,
    ["A"] = 546,
    ["Alt"] = 16384,
    ["Apostrophe"] = 596,
    ["AppBack"] = 629,
    ["AppForward"] = 630,
    ["B"] = 547,
    ["Backslash"] = 604,
    ["Backspace"] = 523,
    ["C"] = 548,
    ["CapsLock"] = 607,
    ["Comma"] = 597,
    ["Ctrl"] = 4096,
    ["D"] = 549,
    ["Delete"] = 522,
    ["DownArrow"] = 516,
    ["E"] = 550,
    ["End"] = 520,
    ["Enter"] = 525,
    ["Equal"] = 602,
    ["Escape"] = 526,
    ["F"] = 551,
    ["F1"] = 572,
    ["F10"] = 581,
    ["F11"] = 582,
    ["F12"] = 583,
    ["F13"] = 584,
    ["F14"] = 585,
    ["F15"] = 586,
    ["F16"] = 587,
    ["F17"] = 588,
    ["F18"] = 589,
    ["F19"] = 590,
    ["F2"] = 573,
    ["F20"] = 591,
    ["F21"] = 592,
    ["F22"] = 593,
    ["F23"] = 594,
    ["F24"] = 595,
    ["F3"] = 574,
    ["F4"] = 575,
    ["F5"] = 576,
    ["F6"] = 577,
    ["F7"] = 578,
    ["F8"] = 579,
    ["F9"] = 580,
    ["G"] = 552,
    ["GamepadBack"] = 633,
    ["GamepadDpadDown"] = 641,
    ["GamepadDpadLeft"] = 638,
    ["GamepadDpadRight"] = 639,
    ["GamepadDpadUp"] = 640,
    ["GamepadFaceDown"] = 637,
    ["GamepadFaceLeft"] = 634,
    ["GamepadFaceRight"] = 635,
    ["GamepadFaceUp"] = 636,
    ["GamepadL1"] = 642,
    ["GamepadL2"] = 644,
    ["GamepadL3"] = 646,
    ["GamepadLStickDown"] = 651,
    ["GamepadLStickLeft"] = 648,
    ["GamepadLStickRight"] = 649,
    ["GamepadLStickUp"] = 650,
    ["GamepadR1"] = 643,
    ["GamepadR2"] = 645,
    ["GamepadR3"] = 647,
    ["GamepadRStickDown"] = 655,
    ["GamepadRStickLeft"] = 652,
    ["GamepadRStickRight"] = 653,
    ["GamepadRStickUp"] = 654,
    ["GamepadStart"] = 632,
    ["GraveAccent"] = 606,
    ["H"] = 553,
    ["Home"] = 519,
    ["I"] = 554,
    ["Insert"] = 521,
    ["J"] = 555,
    ["K"] = 556,
    ["Keypad0"] = 612,
    ["Keypad1"] = 613,
    ["Keypad2"] = 614,
    ["Keypad3"] = 615,
    ["Keypad4"] = 616,
    ["Keypad5"] = 617,
    ["Keypad6"] = 618,
    ["Keypad7"] = 619,
    ["Keypad8"] = 620,
    ["Keypad9"] = 621,
    ["KeypadAdd"] = 626,
    ["KeypadDecimal"] = 622,
    ["KeypadDivide"] = 623,
    ["KeypadEnter"] = 627,
    ["KeypadEqual"] = 628,
    ["KeypadMultiply"] = 624,
    ["KeypadSubtract"] = 625,
    ["L"] = 557,
    ["LeftAlt"] = 529,
    ["LeftArrow"] = 513,
    ["LeftBracket"] = 603,
    ["LeftCtrl"] = 527,
    ["LeftShift"] = 528,
    ["LeftSuper"] = 530,
    ["M"] = 558,
    ["Mask_"] = 61440,
    ["Menu"] = 535,
    ["Minus"] = 598,
    ["MouseLeft"] = 656,
    ["MouseMiddle"] = 658,
    ["MouseRight"] = 657,
    ["MouseWheelX"] = 661,
    ["MouseWheelY"] = 662,
    ["MouseX1"] = 659,
    ["MouseX2"] = 660,
    ["N"] = 559,
    ["NamedKey_BEGIN"] = 512,
    ["NamedKey_COUNT"] = 155,
    ["NamedKey_END"] = 667,
    ["None"] = 0,
    ["NumLock"] = 609,
    ["O"] = 560,
    ["Oem102"] = 631,
    ["P"] = 561,
    ["PageDown"] = 518,
    ["PageUp"] = 517,
    ["Pause"] = 611,
    ["Period"] = 599,
    ["PrintScreen"] = 610,
    ["Q"] = 562,
    ["R"] = 563,
    ["ReservedForModAlt"] = 665,
    ["ReservedForModCtrl"] = 663,
    ["ReservedForModShift"] = 664,
    ["ReservedForModSuper"] = 666,
    ["RightAlt"] = 533,
    ["RightArrow"] = 514,
    ["RightBracket"] = 605,
    ["RightCtrl"] = 531,
    ["RightShift"] = 532,
    ["RightSuper"] = 534,
    ["S"] = 564,
    ["ScrollLock"] = 608,
    ["Semicolon"] = 601,
    ["Shift"] = 8192,
    ["Slash"] = 600,
    ["Space"] = 524,
    ["Super"] = 32768,
    ["T"] = 565,
    ["Tab"] = 512,
    ["U"] = 566,
    ["UpArrow"] = 515,
    ["V"] = 567,
    ["W"] = 568,
    ["X"] = 569,
    ["Y"] = 570,
    ["Z"] = 571,
}, enum_mt)
ImGuiKey = enums.Key

enums.LayoutType = setmetatable({
    ["Horizontal"] = 0,
    ["Vertical"] = 1,
}, enum_mt)
ImGuiLayoutType = enums.LayoutType

enums.ListClipperFlags = setmetatable({
    ["NoSetTableRowCounters"] = 1,
    ["None"] = 0,
}, enum_mt)
ImGuiListClipperFlags = enums.ListClipperFlags

enums.ListFlags = setmetatable({
    ["AllowVtxOffset"] = 8,
    ["AntiAliasedFill"] = 4,
    ["AntiAliasedLines"] = 1,
    ["AntiAliasedLinesUseTex"] = 2,
    ["None"] = 0,
}, enum_mt)
ImGuiListFlags = enums.ListFlags

enums.LocKey = setmetatable({
    ["COUNT"] = 10,
    ["CopyLink"] = 9,
    ["OpenLink_s"] = 8,
    ["TableResetOrder"] = 4,
    ["TableSizeAllDefault"] = 3,
    ["TableSizeAllFit"] = 2,
    ["TableSizeOne"] = 1,
    ["VersionStr"] = 0,
    ["WindowingMainMenuBar"] = 5,
    ["WindowingPopup"] = 6,
    ["WindowingUntitled"] = 7,
}, enum_mt)
ImGuiLocKey = enums.LocKey

enums.LogFlags = setmetatable({
    ["None"] = 0,
    ["OutputBuffer"] = 4,
    ["OutputClipboard"] = 8,
    ["OutputFile"] = 2,
    ["OutputMask_"] = 15,
    ["OutputTTY"] = 1,
}, enum_mt)
ImGuiLogFlags = enums.LogFlags

enums.MouseButton = setmetatable({
    ["COUNT"] = 5,
    ["Left"] = 0,
    ["Middle"] = 2,
    ["Right"] = 1,
}, enum_mt)
ImGuiMouseButton = enums.MouseButton

enums.MouseCursor = setmetatable({
    ["Arrow"] = 0,
    ["COUNT"] = 11,
    ["Hand"] = 7,
    ["None"] = -1,
    ["NotAllowed"] = 10,
    ["Progress"] = 9,
    ["ResizeAll"] = 2,
    ["ResizeEW"] = 4,
    ["ResizeNESW"] = 5,
    ["ResizeNS"] = 3,
    ["ResizeNWSE"] = 6,
    ["TextInput"] = 1,
    ["Wait"] = 8,
}, enum_mt)
ImGuiMouseCursor = enums.MouseCursor

enums.MouseSource = setmetatable({
    ["COUNT"] = 3,
    ["Mouse"] = 0,
    ["Pen"] = 2,
    ["TouchScreen"] = 1,
}, enum_mt)
ImGuiMouseSource = enums.MouseSource

enums.MultiSelectFlags = setmetatable({
    ["BoxSelect1d"] = 64,
    ["BoxSelect2d"] = 128,
    ["BoxSelectNoScroll"] = 256,
    ["ClearOnClickVoid"] = 1024,
    ["ClearOnEscape"] = 512,
    ["NavWrapX"] = 65536,
    ["NoAutoClear"] = 16,
    ["NoAutoClearOnReselect"] = 32,
    ["NoAutoSelect"] = 8,
    ["NoRangeSelect"] = 4,
    ["NoSelectAll"] = 2,
    ["NoSelectOnRightClick"] = 131072,
    ["None"] = 0,
    ["ScopeRect"] = 4096,
    ["ScopeWindow"] = 2048,
    ["SelectOnClick"] = 8192,
    ["SelectOnClickRelease"] = 16384,
    ["SingleSelect"] = 1,
}, enum_mt)
ImGuiMultiSelectFlags = enums.MultiSelectFlags

enums.NavLayer = setmetatable({
    ["COUNT"] = 2,
    ["Main"] = 0,
    ["Menu"] = 1,
}, enum_mt)
ImGuiNavLayer = enums.NavLayer

enums.NavMoveFlags = setmetatable({
    ["Activate"] = 4096,
    ["AllowCurrentNavId"] = 16,
    ["AlsoScoreVisibleSet"] = 32,
    ["DebugNoResult"] = 256,
    ["FocusApi"] = 512,
    ["Forwarded"] = 128,
    ["IsPageMove"] = 2048,
    ["IsTabbing"] = 1024,
    ["LoopX"] = 1,
    ["LoopY"] = 2,
    ["NoClearActiveId"] = 32768,
    ["NoSelect"] = 8192,
    ["NoSetNavCursorVisible"] = 16384,
    ["None"] = 0,
    ["ScrollToEdgeY"] = 64,
    ["WrapMask_"] = 15,
    ["WrapX"] = 4,
    ["WrapY"] = 8,
}, enum_mt)
ImGuiNavMoveFlags = enums.NavMoveFlags

enums.NavRenderCursorFlags = setmetatable({
    ["AlwaysDraw"] = 4,
    ["Compact"] = 2,
    ["NoRounding"] = 8,
    ["None"] = 0,
}, enum_mt)
ImGuiNavRenderCursorFlags = enums.NavRenderCursorFlags

enums.NextItemDataFlags = setmetatable({
    ["HasColorMarker"] = 32,
    ["HasOpen"] = 2,
    ["HasRefVal"] = 8,
    ["HasShortcut"] = 4,
    ["HasStorageID"] = 16,
    ["HasWidth"] = 1,
    ["None"] = 0,
}, enum_mt)
ImGuiNextItemDataFlags = enums.NextItemDataFlags

enums.NextWindowDataFlags = setmetatable({
    ["HasBgAlpha"] = 64,
    ["HasChildFlags"] = 512,
    ["HasCollapsed"] = 8,
    ["HasContentSize"] = 4,
    ["HasFocus"] = 32,
    ["HasPos"] = 1,
    ["HasRefreshPolicy"] = 1024,
    ["HasScroll"] = 128,
    ["HasSize"] = 2,
    ["HasSizeConstraint"] = 16,
    ["HasWindowFlags"] = 256,
    ["None"] = 0,
}, enum_mt)
ImGuiNextWindowDataFlags = enums.NextWindowDataFlags

enums.OldColumnFlags = setmetatable({
    ["GrowParentContentsSize"] = 16,
    ["NoBorder"] = 1,
    ["NoForceWithinWindow"] = 8,
    ["NoPreserveWidths"] = 4,
    ["NoResize"] = 2,
    ["None"] = 0,
}, enum_mt)
ImGuiOldColumnFlags = enums.OldColumnFlags

enums.PlotType = setmetatable({
    ["Histogram"] = 1,
    ["Lines"] = 0,
}, enum_mt)
ImGuiPlotType = enums.PlotType

enums.PopupFlags = setmetatable({
    ["AnyPopup"] = 3072,
    ["AnyPopupId"] = 1024,
    ["AnyPopupLevel"] = 2048,
    ["InvalidMask_"] = 3,
    ["MouseButtonLeft"] = 4,
    ["MouseButtonMask_"] = 12,
    ["MouseButtonMiddle"] = 12,
    ["MouseButtonRight"] = 8,
    ["MouseButtonShift_"] = 2,
    ["NoOpenOverExistingPopup"] = 128,
    ["NoOpenOverItems"] = 256,
    ["NoReopen"] = 32,
    ["None"] = 0,
}, enum_mt)
ImGuiPopupFlags = enums.PopupFlags

enums.PopupPositionPolicy = setmetatable({
    ["ComboBox"] = 1,
    ["Default"] = 0,
    ["Tooltip"] = 2,
}, enum_mt)
ImGuiPopupPositionPolicy = enums.PopupPositionPolicy

enums.ScrollFlags = setmetatable({
    ["AlwaysCenterX"] = 16,
    ["AlwaysCenterY"] = 32,
    ["KeepVisibleCenterX"] = 4,
    ["KeepVisibleCenterY"] = 8,
    ["KeepVisibleEdgeX"] = 1,
    ["KeepVisibleEdgeY"] = 2,
    ["MaskX_"] = 21,
    ["MaskY_"] = 42,
    ["NoScrollParent"] = 64,
    ["None"] = 0,
}, enum_mt)
ImGuiScrollFlags = enums.ScrollFlags

enums.SelectableFlags = setmetatable({
    ["AllowDoubleClick"] = 4,
    ["AllowOverlap"] = 16,
    ["Disabled"] = 8,
    ["Highlight"] = 32,
    ["NoAutoClosePopups"] = 1,
    ["NoHoldingActiveID"] = 1048576,
    ["NoPadWithHalfSpacing"] = 67108864,
    ["NoSetKeyOwner"] = 134217728,
    ["None"] = 0,
    ["SelectOnClick"] = 4194304,
    ["SelectOnNav"] = 64,
    ["SelectOnRelease"] = 8388608,
    ["SetNavIdOnHover"] = 33554432,
    ["SpanAllColumns"] = 2,
    ["SpanAvailWidth"] = 16777216,
}, enum_mt)
ImGuiSelectableFlags = enums.SelectableFlags

enums.SelectionRequestType = setmetatable({
    ["None"] = 0,
    ["SetAll"] = 1,
    ["SetRange"] = 2,
}, enum_mt)
ImGuiSelectionRequestType = enums.SelectionRequestType

enums.SeparatorFlags = setmetatable({
    ["Horizontal"] = 1,
    ["None"] = 0,
    ["SpanAllColumns"] = 4,
    ["Vertical"] = 2,
}, enum_mt)
ImGuiSeparatorFlags = enums.SeparatorFlags

enums.SliderFlags = setmetatable({
    ["AlwaysClamp"] = 1536,
    ["ClampOnInput"] = 512,
    ["ClampZeroRange"] = 1024,
    ["ColorMarkers"] = 4096,
    ["InvalidMask_"] = 1879048207,
    ["Logarithmic"] = 32,
    ["NoInput"] = 128,
    ["NoRoundToFormat"] = 64,
    ["NoSpeedTweaks"] = 2048,
    ["None"] = 0,
    ["ReadOnly"] = 2097152,
    ["Vertical"] = 1048576,
    ["WrapAround"] = 256,
}, enum_mt)
ImGuiSliderFlags = enums.SliderFlags

enums.SortDirection = setmetatable({
    ["Ascending"] = 1,
    ["Descending"] = 2,
    ["None"] = 0,
}, enum_mt)
ImGuiSortDirection = enums.SortDirection

enums.StyleVar = setmetatable({
    ["Alpha"] = 0,
    ["ButtonTextAlign"] = 35,
    ["COUNT"] = 40,
    ["CellPadding"] = 17,
    ["ChildBorderSize"] = 8,
    ["ChildRounding"] = 7,
    ["DisabledAlpha"] = 1,
    ["FrameBorderSize"] = 13,
    ["FramePadding"] = 11,
    ["FrameRounding"] = 12,
    ["GrabMinSize"] = 21,
    ["GrabRounding"] = 22,
    ["ImageBorderSize"] = 24,
    ["ImageRounding"] = 23,
    ["IndentSpacing"] = 16,
    ["ItemInnerSpacing"] = 15,
    ["ItemSpacing"] = 14,
    ["PopupBorderSize"] = 10,
    ["PopupRounding"] = 9,
    ["ScrollbarPadding"] = 20,
    ["ScrollbarRounding"] = 19,
    ["ScrollbarSize"] = 18,
    ["SelectableTextAlign"] = 36,
    ["SeparatorTextAlign"] = 38,
    ["SeparatorTextBorderSize"] = 37,
    ["SeparatorTextPadding"] = 39,
    ["TabBarBorderSize"] = 29,
    ["TabBarOverlineSize"] = 30,
    ["TabBorderSize"] = 26,
    ["TabMinWidthBase"] = 27,
    ["TabMinWidthShrink"] = 28,
    ["TabRounding"] = 25,
    ["TableAngledHeadersAngle"] = 31,
    ["TableAngledHeadersTextAlign"] = 32,
    ["TreeLinesRounding"] = 34,
    ["TreeLinesSize"] = 33,
    ["WindowBorderSize"] = 4,
    ["WindowMinSize"] = 5,
    ["WindowPadding"] = 2,
    ["WindowRounding"] = 3,
    ["WindowTitleAlign"] = 6,
}, enum_mt)
ImGuiStyleVar = enums.StyleVar

enums.TabBarFlags = setmetatable({
    ["AutoSelectNewTabs"] = 2,
    ["DockNode"] = 1048576,
    ["DrawSelectedOverline"] = 64,
    ["FittingPolicyDefault_"] = 128,
    ["FittingPolicyMask_"] = 896,
    ["FittingPolicyMixed"] = 128,
    ["FittingPolicyScroll"] = 512,
    ["FittingPolicyShrink"] = 256,
    ["IsFocused"] = 2097152,
    ["NoCloseWithMiddleMouseButton"] = 8,
    ["NoTabListScrollingButtons"] = 16,
    ["NoTooltip"] = 32,
    ["None"] = 0,
    ["Reorderable"] = 1,
    ["SaveSettings"] = 4194304,
    ["TabListPopupButton"] = 4,
}, enum_mt)
ImGuiTabBarFlags = enums.TabBarFlags

enums.TabItemFlags = setmetatable({
    ["Button"] = 2097152,
    ["Invisible"] = 4194304,
    ["Leading"] = 64,
    ["NoAssumedClosure"] = 256,
    ["NoCloseButton"] = 1048576,
    ["NoCloseWithMiddleMouseButton"] = 4,
    ["NoPushId"] = 8,
    ["NoReorder"] = 32,
    ["NoTooltip"] = 16,
    ["None"] = 0,
    ["SectionMask_"] = 192,
    ["SetSelected"] = 2,
    ["Trailing"] = 128,
    ["UnsavedDocument"] = 1,
}, enum_mt)
ImGuiTabItemFlags = enums.TabItemFlags

enums.TableBgTarget = setmetatable({
    ["CellBg"] = 3,
    ["None"] = 0,
    ["RowBg0"] = 1,
    ["RowBg1"] = 2,
}, enum_mt)
ImGuiTableBgTarget = enums.TableBgTarget

enums.TableColumnFlags = setmetatable({
    ["AngledHeader"] = 262144,
    ["DefaultHide"] = 2,
    ["DefaultSort"] = 4,
    ["Disabled"] = 1,
    ["IndentDisable"] = 131072,
    ["IndentEnable"] = 65536,
    ["IndentMask_"] = 196608,
    ["IsEnabled"] = 16777216,
    ["IsHovered"] = 134217728,
    ["IsSorted"] = 67108864,
    ["IsVisible"] = 33554432,
    ["NoClip"] = 256,
    ["NoDirectResize_"] = 1073741824,
    ["NoHeaderLabel"] = 4096,
    ["NoHeaderWidth"] = 8192,
    ["NoHide"] = 128,
    ["NoReorder"] = 64,
    ["NoResize"] = 32,
    ["NoSort"] = 512,
    ["NoSortAscending"] = 1024,
    ["NoSortDescending"] = 2048,
    ["None"] = 0,
    ["PreferSortAscending"] = 16384,
    ["PreferSortDescending"] = 32768,
    ["StatusMask_"] = 251658240,
    ["WidthFixed"] = 16,
    ["WidthMask_"] = 24,
    ["WidthStretch"] = 8,
}, enum_mt)
ImGuiTableColumnFlags = enums.TableColumnFlags

enums.TableFlags = setmetatable({
    ["Borders"] = 1920,
    ["BordersH"] = 384,
    ["BordersInner"] = 640,
    ["BordersInnerH"] = 128,
    ["BordersInnerV"] = 512,
    ["BordersOuter"] = 1280,
    ["BordersOuterH"] = 256,
    ["BordersOuterV"] = 1024,
    ["BordersV"] = 1536,
    ["ContextMenuInBody"] = 32,
    ["Hideable"] = 4,
    ["HighlightHoveredColumn"] = 268435456,
    ["NoBordersInBody"] = 2048,
    ["NoBordersInBodyUntilResize"] = 4096,
    ["NoClip"] = 1048576,
    ["NoHostExtendX"] = 65536,
    ["NoHostExtendY"] = 131072,
    ["NoKeepColumnsVisible"] = 262144,
    ["NoPadInnerX"] = 8388608,
    ["NoPadOuterX"] = 4194304,
    ["NoSavedSettings"] = 16,
    ["None"] = 0,
    ["PadOuterX"] = 2097152,
    ["PreciseWidths"] = 524288,
    ["Reorderable"] = 2,
    ["Resizable"] = 1,
    ["RowBg"] = 64,
    ["ScrollX"] = 16777216,
    ["ScrollY"] = 33554432,
    ["SizingFixedFit"] = 8192,
    ["SizingFixedSame"] = 16384,
    ["SizingMask_"] = 57344,
    ["SizingStretchProp"] = 24576,
    ["SizingStretchSame"] = 32768,
    ["SortMulti"] = 67108864,
    ["SortTristate"] = 134217728,
    ["Sortable"] = 8,
}, enum_mt)
ImGuiTableFlags = enums.TableFlags

enums.TableRowFlags = setmetatable({
    ["Headers"] = 1,
    ["None"] = 0,
}, enum_mt)
ImGuiTableRowFlags = enums.TableRowFlags

enums.TextFlags = setmetatable({
    ["CpuFineClip"] = 1,
    ["NoWidthForLargeClippedText"] = 1,
    ["None"] = 0,
    ["StopOnNewLine"] = 4,
    ["WrapKeepBlanks"] = 2,
}, enum_mt)
ImGuiTextFlags = enums.TextFlags

enums.TextureFormat = setmetatable({
    ["Alpha8"] = 1,
    ["RGBA32"] = 0,
}, enum_mt)
ImGuiTextureFormat = enums.TextureFormat

enums.TextureStatus = setmetatable({
    ["Destroyed"] = 1,
    ["OK"] = 0,
    ["WantCreate"] = 2,
    ["WantDestroy"] = 4,
    ["WantUpdates"] = 3,
}, enum_mt)
ImGuiTextureStatus = enums.TextureStatus

enums.TooltipFlags = setmetatable({
    ["None"] = 0,
    ["OverridePrevious"] = 2,
}, enum_mt)
ImGuiTooltipFlags = enums.TooltipFlags

enums.TreeNodeFlags = setmetatable({
    ["AllowOverlap"] = 4,
    ["Bullet"] = 512,
    ["ClipLabelForTrailingButton"] = 268435456,
    ["CollapsingHeader"] = 26,
    ["DefaultOpen"] = 32,
    ["DrawLinesFull"] = 524288,
    ["DrawLinesMask_"] = 1835008,
    ["DrawLinesNone"] = 262144,
    ["DrawLinesToNodes"] = 1048576,
    ["FramePadding"] = 1024,
    ["Framed"] = 2,
    ["LabelSpanAllColumns"] = 32768,
    ["Leaf"] = 256,
    ["NavLeftJumpsToParent"] = 131072,
    ["NoAutoOpenOnLog"] = 16,
    ["NoNavFocus"] = 134217728,
    ["NoTreePushOnOpen"] = 8,
    ["None"] = 0,
    ["OpenOnArrow"] = 128,
    ["OpenOnDoubleClick"] = 64,
    ["OpenOnMask_"] = 192,
    ["Selected"] = 1,
    ["SpanAllColumns"] = 16384,
    ["SpanAvailWidth"] = 2048,
    ["SpanFullWidth"] = 4096,
    ["SpanLabelWidth"] = 8192,
    ["UpsideDownArrow"] = 536870912,
}, enum_mt)
ImGuiTreeNodeFlags = enums.TreeNodeFlags

enums.TypingSelectFlags = setmetatable({
    ["AllowBackspace"] = 1,
    ["AllowSingleCharMode"] = 2,
    ["None"] = 0,
}, enum_mt)
ImGuiTypingSelectFlags = enums.TypingSelectFlags

enums.ViewportFlags = setmetatable({
    ["IsPlatformMonitor"] = 2,
    ["IsPlatformWindow"] = 1,
    ["None"] = 0,
    ["OwnedByApp"] = 4,
}, enum_mt)
ImGuiViewportFlags = enums.ViewportFlags

enums.WcharClass = setmetatable({
    ["Blank"] = 0,
    ["Other"] = 2,
    ["Punct"] = 1,
}, enum_mt)
ImGuiWcharClass = enums.WcharClass

enums.WindowBgClickFlags = setmetatable({
    ["Move"] = 1,
    ["None"] = 0,
}, enum_mt)
ImGuiWindowBgClickFlags = enums.WindowBgClickFlags

enums.WindowFlags = setmetatable({
    ["AlwaysAutoResize"] = 64,
    ["AlwaysHorizontalScrollbar"] = 32768,
    ["AlwaysVerticalScrollbar"] = 16384,
    ["ChildMenu"] = 268435456,
    ["ChildWindow"] = 16777216,
    ["HorizontalScrollbar"] = 2048,
    ["MenuBar"] = 1024,
    ["Modal"] = 134217728,
    ["NoBackground"] = 128,
    ["NoBringToFrontOnFocus"] = 8192,
    ["NoCollapse"] = 32,
    ["NoDecoration"] = 43,
    ["NoFocusOnAppearing"] = 4096,
    ["NoInputs"] = 197120,
    ["NoMouseInputs"] = 512,
    ["NoMove"] = 4,
    ["NoNav"] = 196608,
    ["NoNavFocus"] = 131072,
    ["NoNavInputs"] = 65536,
    ["NoResize"] = 2,
    ["NoSavedSettings"] = 256,
    ["NoScrollWithMouse"] = 16,
    ["NoScrollbar"] = 8,
    ["NoTitleBar"] = 1,
    ["None"] = 0,
    ["Popup"] = 67108864,
    ["Tooltip"] = 33554432,
    ["UnsavedDocument"] = 262144,
}, enum_mt)
ImGuiWindowFlags = enums.WindowFlags

enums.WindowRefreshFlags = setmetatable({
    ["None"] = 0,
    ["RefreshOnFocus"] = 4,
    ["RefreshOnHover"] = 2,
    ["TryToAvoidRefresh"] = 1,
}, enum_mt)
ImGuiWindowRefreshFlags = enums.WindowRefreshFlags

return enums

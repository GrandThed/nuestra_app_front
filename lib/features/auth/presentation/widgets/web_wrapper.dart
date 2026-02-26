// Copyright 2024 Household Hub. All rights reserved.
// Conditional export: uses stub on non-web, real implementation on web.
export 'web_wrapper_stub.dart'
    if (dart.library.js_interop) 'web_wrapper_web.dart';

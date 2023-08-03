"use strict";
exports.__esModule = true;
var React = require("react");
var clsx_1 = require("clsx");
function LoadingCircle(_a) {
    var className = _a.className;
    return (<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" className={(0, clsx_1.clsx)('animate-spin', className)}>
      <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
      <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
    </svg>);
}
exports["default"] = LoadingCircle;

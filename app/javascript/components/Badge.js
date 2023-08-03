"use strict";
exports.__esModule = true;
var React = require("react");
var clsx_1 = require("clsx");
function Badge(_a) {
    var label = _a.label, color = _a.color, className = _a.className, _b = _a.size, size = _b === void 0 ? 'medium' : _b;
    return (<span className={(0, clsx_1.clsx)('inline-flex items-center rounded-full text-xs font-medium', {
            'px-2 py-0.5': size === 'small',
            'px-2.5 py-0.5': size === 'medium',
            'px-3 py-0.5': size === 'large'
        }, color.background, color.text, className)}>
      {label}
    </span>);
}
exports["default"] = Badge;

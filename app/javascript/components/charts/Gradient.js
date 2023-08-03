"use strict";
var __rest = (this && this.__rest) || function (s, e) {
    var t = {};
    for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
        t[p] = s[p];
    if (s != null && typeof Object.getOwnPropertySymbols === "function")
        for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
            if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                t[p[i]] = s[p[i]];
        }
    return t;
};
exports.__esModule = true;
exports.RedGradient = exports.redGradientId = void 0;
var React = require("react");
var colors = require("tailwindcss/colors");
/**
 * A SVG linear gradient. Requires a unique ID and an array of color values.
 */
function Gradient(_a) {
    var id = _a.id, colors = _a.colors, props = __rest(_a, ["id", "colors"]);
    return (<linearGradient id={id} gradientUnits="userSpaceOnUse" spreadMethod="pad" {...props}>
      {colors.map(function (color, i) { return (<stop key={i} offset={"".concat((i * 100) / (colors.length - 1), "%")} stopColor={color}/>); })}
    </linearGradient>);
}
exports["default"] = Gradient;
exports.redGradientId = 'hotseat-red-gradient';
/**
 * A red gradient.
 */
function RedGradient() {
    return <Gradient id={exports.redGradientId} colors={[colors.red['600'], colors.red['100']]} x2="0" y2="100%"/>;
}
exports.RedGradient = RedGradient;

"use strict";
var __assign = (this && this.__assign) || function () {
    __assign = Object.assign || function(t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
                t[p] = s[p];
        }
        return t;
    };
    return __assign.apply(this, arguments);
};
exports.__esModule = true;
exports.useChartDimensions = exports.defaultDimensions = void 0;
var react_1 = require("react");
exports.defaultDimensions = {
    marginTop: 10,
    marginRight: 10,
    marginBottom: 40,
    marginLeft: 40,
    height: 0,
    width: 0,
    boundedHeight: 0,
    boundedWidth: 0
};
var combineChartDimensions = function (dimensions) {
    var parsedDimensions = __assign(__assign({}, dimensions), { marginTop: dimensions.marginTop || exports.defaultDimensions.marginTop, marginRight: dimensions.marginRight || exports.defaultDimensions.marginRight, marginBottom: dimensions.marginBottom || exports.defaultDimensions.marginBottom, marginLeft: dimensions.marginLeft || exports.defaultDimensions.marginLeft });
    return __assign(__assign({}, parsedDimensions), { boundedHeight: Math.max(parsedDimensions.height - parsedDimensions.marginTop - parsedDimensions.marginBottom, 0), boundedWidth: Math.max(parsedDimensions.width - parsedDimensions.marginLeft - parsedDimensions.marginRight, 0) });
};
function useChartDimensions(passedDimensions) {
    var ref = (0, react_1.useRef)(null);
    var _a = (0, react_1.useState)(0), width = _a[0], changeWidth = _a[1];
    var _b = (0, react_1.useState)(0), height = _b[0], changeHeight = _b[1];
    (0, react_1.useEffect)(function () {
        if (passedDimensions.width && passedDimensions.height)
            return;
        var element = ref.current;
        if (!element)
            return;
        var resizeObserver = new ResizeObserver(function (entries) {
            if (!Array.isArray(entries))
                return;
            if (!entries.length)
                return;
            var entry = entries[0];
            if (width != entry.contentRect.width)
                changeWidth(entry.contentRect.width);
            if (height != entry.contentRect.height)
                changeHeight(entry.contentRect.height);
        });
        resizeObserver.observe(element);
        return function () { return resizeObserver.unobserve(element); };
    }, []);
    var newSettings = combineChartDimensions(__assign(__assign({}, passedDimensions), { width: passedDimensions.width || width, height: passedDimensions.height || height }));
    return [ref, newSettings];
}
exports.useChartDimensions = useChartDimensions;

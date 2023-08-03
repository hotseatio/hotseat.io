"use strict";
exports.__esModule = true;
exports.useChartDimensions = void 0;
var React = require("react");
var react_1 = require("react");
var useChartDimensions_1 = require("./hooks/useChartDimensions");
var ChartContext = (0, react_1.createContext)(useChartDimensions_1.defaultDimensions);
var useChartDimensions = function () { return (0, react_1.useContext)(ChartContext); };
exports.useChartDimensions = useChartDimensions;
function Chart(_a) {
    var dimensions = _a.dimensions, children = _a.children, onPointerMove = _a.onPointerMove, onPointerLeave = _a.onPointerLeave;
    return (<ChartContext.Provider value={dimensions}>
      <svg className="Chart" width={dimensions.width} height={dimensions.height} onTouchStart={function (e) { return e.preventDefault(); }} onPointerMove={onPointerMove} onPointerLeave={onPointerLeave}>
        <g transform={"translate(".concat(dimensions.marginLeft, ", ").concat(dimensions.marginTop, ")")}>{children}</g>
      </svg>
    </ChartContext.Provider>);
}
exports["default"] = Chart;

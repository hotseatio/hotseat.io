"use strict";
exports.__esModule = true;
var React = require("react");
var react_1 = require("react");
var d3_scale_1 = require("d3-scale");
var d3_array_1 = require("d3-array");
var Chart_1 = require("components/charts/Chart");
var XAxis_1 = require("components/charts/axis/XAxis");
var YAxis_1 = require("components/charts/axis/YAxis");
var Gradient_1 = require("components/charts/Gradient");
var useChartDimensions_1 = require("components/charts/hooks/useChartDimensions");
var POSSIBLE_GRADES = ['A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F'];
var GAP_SIZE = 2;
function Tooltip(_a) {
    var grade = _a.grade, percentage = _a.percentage, x = _a.x, y = _a.y;
    var styles = { left: x + 10, top: y - 16 };
    return (<div className="absolute bg-black text-white text-sm rounded py-1 px-2" style={styles}>
      <p>
        {grade}: {percentage}%
      </p>
    </div>);
}
function GradeChart(_a) {
    var _b;
    var data = _a.data;
    var _c = (0, react_1.useState)(null), tooltipGrade = _c[0], setTooltipGrade = _c[1];
    var _d = (0, react_1.useState)(null), tooltipPercentage = _d[0], setTooltipPercentage = _d[1];
    var _e = (0, react_1.useState)({ x: 0, y: 0 }), tooltipCoords = _e[0], setTooltipCoords = _e[1];
    var _f = (0, useChartDimensions_1.useChartDimensions)({
        marginLeft: 36,
        marginTop: 20,
        height: 300
    }), ref = _f[0], dimensions = _f[1];
    var xScale = (0, d3_scale_1.scaleBand)().domain(POSSIBLE_GRADES).range([0, dimensions.boundedWidth]);
    var yScale = (0, d3_scale_1.scaleLinear)()
        .domain([0, (_b = (0, d3_array_1.max)(data)) !== null && _b !== void 0 ? _b : 0 + 5])
        .range([dimensions.boundedHeight, 0])
        .nice();
    var width = Math.max(0, xScale.bandwidth() - GAP_SIZE);
    return (<div className="Histogram" ref={ref}>
      <Chart_1["default"] dimensions={dimensions}>
        <defs>
          <Gradient_1.RedGradient />
        </defs>
        {data.map(function (d, i) {
            var x = xScale(POSSIBLE_GRADES[i]);
            var y = yScale(d);
            var height = dimensions.boundedHeight - y;
            return (<rect onMouseMove={function (e) {
                    setTooltipGrade(POSSIBLE_GRADES[i]);
                    setTooltipPercentage(d);
                    setTooltipCoords({ x: e.pageX, y: e.pageY });
                }} onMouseLeave={function () {
                    setTooltipGrade(null);
                    setTooltipPercentage(null);
                }} key={i} x={x} y={y} width={width} height={height} style={{ fill: "url(#".concat(Gradient_1.redGradientId, ")") }}/>);
        })}
        <XAxis_1["default"] scale={xScale} formatTick={function (tick) { return tick; }}/>
        <YAxis_1["default"] scale={yScale} formatTick={function (tick) { return "".concat(tick, "%"); }}/>
      </Chart_1["default"]>
      {tooltipGrade !== null && tooltipPercentage !== null && (<Tooltip grade={tooltipGrade} percentage={tooltipPercentage} x={tooltipCoords.x} y={tooltipCoords.y}/>)}
    </div>);
}
exports["default"] = GradeChart;

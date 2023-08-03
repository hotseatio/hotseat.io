"use strict";
exports.__esModule = true;
var React = require("react");
var d3_time_1 = require("d3-time");
var Chart_1 = require("components/charts/Chart");
/**
 * A horizontal axis.
 */
function XAxis(props) {
    var _a = props.showTickMarks, showTickMarks = _a === void 0 ? false : _a, label = props.label;
    var ticks;
    var dimensions = (0, Chart_1.useChartDimensions)();
    if (isBandProps(props)) {
        var scale_1 = props.scale, formatTick = props.formatTick;
        var tickValues = scale_1.domain();
        var getX = function (value) {
            var x = props.scale(value);
            if (x === undefined)
                throw new Error('');
            return x + scale_1.bandwidth() / 2;
        };
        ticks = createTicksLabels(tickValues, getX, formatTick, showTickMarks);
    }
    else {
        var scale_2 = props.scale, formatTick = props.formatTick;
        var timeInterval = d3_time_1.timeDay.every(3);
        var tickValues = timeInterval ? scale_2.ticks(timeInterval) : scale_2.ticks();
        var getX = function (value) { return scale_2(value); };
        ticks = createTicksLabels(tickValues, getX, formatTick, showTickMarks);
    }
    return (<g className="Axis AxisHorizontal" transform={"translate(0, ".concat(dimensions.boundedHeight, ")")}>
      <line className="stroke-gray-700 dark:stroke-gray-200 stroke-1" x2={dimensions.boundedWidth}/>
      {ticks}
      {label && (<text className="fill-gray-800 dark:stroke-gray-100 text-md" transform={"translate(".concat(dimensions.boundedWidth / 2, ", 60)")}>
          {label}
        </text>)}
    </g>);
}
exports["default"] = XAxis;
function createTicksLabels(ticks, getX, formatTick, showTickMarks) {
    return (<>
      {ticks.map(function (tick) {
            return (<g key={formatTick(tick)} transform={"translate(".concat(getX(tick), ", 0)")}>
            {showTickMarks && <line y2="6" stroke="currentColor"/>}
            <text className="fill-gray-800 dark:fill-gray-100 text-xs" style={{
                    textAnchor: 'middle',
                    transform: 'translateY(20px)'
                }}>
              {formatTick(tick)}
            </text>
          </g>);
        })}
    </>);
}
function isBandProps(props) {
    return props.scale.bandwidth !== undefined;
}

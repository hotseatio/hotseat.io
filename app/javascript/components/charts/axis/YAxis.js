"use strict";
exports.__esModule = true;
var React = require("react");
var Chart_1 = require("components/charts/Chart");
/**
 * A vertical axis.
 */
function YAxis(_a) {
    var scale = _a.scale, label = _a.label, formatTick = _a.formatTick;
    var dimensions = (0, Chart_1.useChartDimensions)();
    var numberOfTicks = dimensions.boundedHeight / 70;
    var ticks = scale.ticks(numberOfTicks);
    return (<g>
      <line className="stroke-gray-700 dark:stroke-gray-200 stroke-1" y2={dimensions.boundedHeight}/>

      {ticks.map(function (tick) { return (<g key={tick} transform={"translate(-4, ".concat(scale(tick), ")")}>
          <text className="fill-gray-800 dark:fill-gray-100 text-xs" style={{
                textAnchor: 'end'
            }}>
            {formatTick(tick)}
          </text>
        </g>); })}

      {label && (<text style={{
                transform: "translate(-56px, ".concat(dimensions.boundedHeight / 2, "px) rotate(-90deg)")
            }}>
          {label}
        </text>)}
    </g>);
}
exports["default"] = YAxis;

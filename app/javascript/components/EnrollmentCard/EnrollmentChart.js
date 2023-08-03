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
var React = require("react");
var react_1 = require("react");
var d3_selection_1 = require("d3-selection");
var d3_array_1 = require("d3-array");
var d3_scale_1 = require("d3-scale");
var d3_time_1 = require("d3-time");
var d3_shape_1 = require("d3-shape");
var date_1 = require("utilities/date");
var useChartDimensions_1 = require("components/charts/hooks/useChartDimensions");
var XAxis_1 = require("components/charts/axis/XAxis");
var YAxis_1 = require("components/charts/axis/YAxis");
var Chart_1 = require("components/charts/Chart");
var Gradient_1 = require("components/charts/Gradient");
// How often the Schedule crawler runs.
var UPDATE_PERIOD = 1 * date_1.HOUR;
var TIME_FORMAT_OPTIONS = {
    month: 'short',
    day: 'numeric',
    hour: 'numeric',
    timeZone: 'America/Los_Angeles',
    timeZoneName: 'short'
};
function formatLegendLabel(datum) {
    return "".concat(datum.enrollmentCount + datum.waitlistCount, "/").concat(datum.enrollmentCapacity + datum.waitlistCapacity, " seats taken (").concat(datum.enrollmentStatus, ")");
}
function formatHoverLabel(datum) {
    return (datum.enrollmentCount + datum.waitlistCount).toString();
}
function fillOmittedData(jsonData, _a) {
    var enrollmentEnd = _a.enrollmentEnd, isLive = _a.isLive;
    var out = [];
    var prev;
    for (var _i = 0, jsonData_1 = jsonData; _i < jsonData_1.length; _i++) {
        var jsonDatum = jsonData_1[_i];
        var cur = __assign(__assign({}, jsonDatum), { createdAt: new Date(jsonDatum.createdAt) });
        // Handle sharp enrollment spikes.
        // https://github.com/nathunsmitty/hotseat.io/issues/62
        if (prev && (0, date_1.sub)(cur.createdAt, prev.createdAt) > 1.5 * UPDATE_PERIOD) {
            var copyDate = (0, date_1.add)(cur.createdAt, -UPDATE_PERIOD);
            out.push(__assign(__assign({}, prev), { createdAt: copyDate }));
        }
        out.push(cur);
        prev = cur;
    }
    // Duplicate the last datapoint, so that the line is extended
    // to the entire timeframe for which we have data.
    if (prev) {
        var end = isLive ? (0, date_1.earliest)(new Date(), enrollmentEnd) : enrollmentEnd;
        out.push(__assign(__assign({}, prev), { createdAt: end }));
    }
    return out;
}
var datumBisector = (0, d3_array_1.bisector)(function (d) { return d.createdAt; }).left;
function EnrollmentChart(_a) {
    var sectionData = _a.sectionData, sectionLabels = _a.sectionLabels, enrollmentStart = _a.enrollmentStart, enrollmentEnd = _a.enrollmentEnd, markers = _a.markers, isLive = _a.isLive;
    var _b = (0, useChartDimensions_1.useChartDimensions)({
        marginRight: 30,
        marginLeft: 50,
        height: 300
    }), ref = _b[0], dms = _b[1];
    var _c = (0, react_1.useState)(null), mouseX = _c[0], setMouseX = _c[1];
    var _d = (0, react_1.useState)(null), highlightedDataPoints = _d[0], setHighlightedDataPoints = _d[1];
    var sanitizedSectionData = (0, react_1.useMemo)(function () { return sectionData.map(function (data) { return fillOmittedData(data, { enrollmentEnd: new Date(enrollmentEnd), isLive: isLive }); }); }, [sectionData, enrollmentEnd, isLive]);
    var latestSectionData = (0, react_1.useMemo)(function () { return sanitizedSectionData.map(function (data) { return data[data.length - 1]; }); }, [sanitizedSectionData]);
    var legendSectionData = highlightedDataPoints !== null && highlightedDataPoints !== void 0 ? highlightedDataPoints : latestSectionData;
    var yMax = (0, react_1.useMemo)(function () {
        return (0, d3_array_1.max)(sanitizedSectionData.flat(), function (d) {
            return Math.max(d.enrollmentCapacity + d.waitlistCapacity, d.enrollmentCount + d.waitlistCount);
        });
    }, [sanitizedSectionData]);
    var formatXAxisTick = function (date) {
        var rawDaysCount = d3_time_1.timeDay.count(new Date(enrollmentStart), date);
        var daysCount = Math.max(rawDaysCount, 0);
        var suffix = "day".concat(daysCount === 1 ? '' : 's');
        return "".concat(daysCount, " ").concat(suffix);
    };
    var xScale = (0, d3_scale_1.scaleTime)()
        .domain([new Date(enrollmentStart), new Date(enrollmentEnd)])
        .range([0, dms.boundedWidth]);
    // .nice()
    var yScale = (0, d3_scale_1.scaleLinear)()
        .domain([0, (yMax !== null && yMax !== void 0 ? yMax : 200) + 20])
        .range([dms.boundedHeight, 0]);
    // .nice()
    var pathGenerator = (0, d3_shape_1.line)()
        .x(function (d) { return xScale(d.createdAt); })
        .y(function (d) { return yScale(d.enrollmentCount + d.waitlistCount); });
    var sectionPaths = sanitizedSectionData.map(function (data) { return pathGenerator(data); });
    var firstDataPoint = sanitizedSectionData[0][0];
    var lastDataPoint = sanitizedSectionData[0][sanitizedSectionData[0].length - 1];
    var leftmostX = Math.max(xScale(firstDataPoint.createdAt), 0);
    var rightmostX = Math.min(xScale(lastDataPoint.createdAt), dms.boundedWidth);
    var setMouseXOnMove = (0, react_1.useCallback)(function (event) {
        var x = (0, d3_selection_1.pointer)(event)[0];
        var adjustedX = x - dms.marginLeft;
        if (adjustedX < leftmostX || adjustedX > rightmostX) {
            setMouseXOnLeave();
            return;
        }
        setMouseX(adjustedX);
        var newHighlightedDataPoints = sanitizedSectionData.map(function (data) {
            var date = xScale.invert(adjustedX);
            var index = datumBisector(data, date, 1);
            if (index === 0) {
                return data[index];
            }
            var a = data[index - 1];
            var b = data[index];
            if (b === undefined) {
                return a;
            }
            return date.getTime() - a.createdAt.getTime() > b.createdAt.getTime() - date.getTime() ? b : a;
        });
        setHighlightedDataPoints(newHighlightedDataPoints);
    }, [sanitizedSectionData, xScale, dms.marginLeft, leftmostX, rightmostX]);
    var setMouseXOnLeave = function () {
        setMouseX(null);
        setHighlightedDataPoints(null);
    };
    return (<div>
      <div className="text-right mx-6 my-2 text-sm text-gray-900 dark:text-white bg-white dark:bg-gray-900">
        <div>{legendSectionData[0].createdAt.toLocaleDateString('en-US', TIME_FORMAT_OPTIONS)}</div>
        {legendSectionData.map(function (datum, i) { return (<div key={i}>
            {sectionLabels[i]}: {formatLegendLabel(datum)}
          </div>); })}
      </div>
      <div ref={ref}>
        <Chart_1["default"] dimensions={dms} onPointerMove={setMouseXOnMove} onPointerLeave={setMouseXOnLeave}>
          <defs>
            <Gradient_1.RedGradient />
          </defs>

          {sectionPaths.map(function (path, i) { return (<path key={i} d={path !== null && path !== void 0 ? path : undefined} className="fill-none stroke-1.5" stroke={"url(#".concat(Gradient_1.redGradientId, ")")}/>); })}

          {mouseX !== null && highlightedDataPoints !== null && (<g className="mouse-effects">
              <path d={"M".concat(mouseX, ",").concat(dms.boundedHeight, " ").concat(mouseX, ",0")} className="stroke-gray-900 dark:stroke-white stroke-1"/>
              {highlightedDataPoints.map(function (datum, i) { return (<g key={i} transform={"translate(".concat(mouseX, ",").concat(yScale(datum.enrollmentCount + datum.waitlistCount), ")")}>
                  <circle r={4} className="fill-none stroke-red-600 stroke-1"/>
                  <text className="fill-gray-800 dark:fill-gray-100 text-xs" transform="translate(-26,0)">
                    {formatHoverLabel(datum)}
                  </text>
                </g>); })}
            </g>)}

          {markers.map(function (_a) {
            var label = _a.label, rawTime = _a.time;
            var time = new Date(rawTime);
            return (<g key={rawTime} transform={"translate(".concat(xScale(time), ",0)")}>
                <d3_shape_1.line className="stroke-gray-700 dark:stroke-gray-200 stroke-1" strokeDasharray="2" y2={dms.boundedHeight}/>
                <text className="fill-gray-800 dark:fill-gray-100 text-xs" transform={"translate(4,10)"}>
                  {label}
                </text>
              </g>);
        })}

          <XAxis_1["default"] scale={xScale} formatTick={formatXAxisTick} showTickMarks={true}/>
          <YAxis_1["default"] scale={yScale} formatTick={function (tick) { return tick.toString(); }}/>
        </Chart_1["default"]>
      </div>
      {isLive && (<div className="text-center mx-6 my-2 text-sm text-gray-500 dark:text-gray-400 bg-white dark:bg-gray-900">
          <p>Displayed data is updated hourly from the UCLA Registrar.</p>
        </div>)}
    </div>);
}
exports["default"] = EnrollmentChart;

"use strict";
exports.__esModule = true;
var React = require("react");
var react_1 = require("react");
var lodash_es_1 = require("lodash-es");
var EnrollmentChart_1 = require("./EnrollmentChart");
var Select_1 = require("components/Select");
var Card_1 = require("components/Card");
function EnrollmentCard(_a) {
    var id = _a.id, termEnrollmentData = _a.termEnrollmentData;
    var terms = termEnrollmentData.map(function (d) { return d.term; });
    var termItems = (0, react_1.useMemo)(function () { return terms.map(function (term) { return ({ id: term, label: term }); }); }, [terms]);
    var _b = (0, react_1.useState)(0), selectedTermIndex = _b[0], setSelectedTermIndex = _b[1];
    var selectedTermData = termEnrollmentData[selectedTermIndex];
    var periodItems = (0, react_1.useMemo)(function () {
        return (0, lodash_es_1.compact)([
            selectedTermData.enrollmentPeriod.sections.length > 0 ? { label: 'Enrollment', id: 'enroll' } : null,
            selectedTermData.quarterStart.sections.length > 0 ? { label: 'Drops', id: 'drop' } : null,
        ]);
    }, [selectedTermData]);
    var _c = (0, react_1.useState)(0), selectedPeriodIndex = _c[0], setSelectedPeriodIndex = _c[1];
    var selectedPeriod = periodItems[selectedPeriodIndex];
    var SelectNodes = [
        <Select_1["default"] key="period" label="Enrollment or drops:" labelInvisible className="w-32" onSelect={function (_selected, i) { return setSelectedPeriodIndex(i); }} items={periodItems} value={selectedPeriodIndex}/>,
        <Select_1["default"] key="term" label="Select a term:" labelInvisible className="w-24" onSelect={function (_selected, i) { return setSelectedTermIndex(i); }} items={termItems} value={selectedTermIndex}/>,
    ];
    var _d = selectedPeriod.id === 'drop' ? selectedTermData.quarterStart : selectedTermData.enrollmentPeriod, markers = _d.markers, start = _d.start, end = _d.end, sections = _d.sections, isLive = _d.isLive;
    return (<Card_1.Card id={id} title="Enrollment Progress" rightContent={SelectNodes}>
      <EnrollmentChart_1["default"] markers={markers} enrollmentStart={start} enrollmentEnd={end} sectionLabels={sections.map(function (s) { return s.label; })} sectionData={sections.map(function (s) { return s.data; })} isLive={isLive}/>
    </Card_1.Card>);
}
exports["default"] = EnrollmentCard;

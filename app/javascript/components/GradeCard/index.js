"use strict";
exports.__esModule = true;
var React = require("react");
var react_1 = require("react");
var GradeChart_1 = require("./GradeChart");
var Card_1 = require("components/Card");
function GradeCard(_a) {
    var id = _a.id, termGradeData = _a.termGradeData;
    var terms = (0, react_1.useMemo)(function () { return termGradeData.map(function (d) { return d.term; }); }, [termGradeData]);
    var _b = (0, react_1.useState)(0), selectedTermIndex = _b[0], setSelectedTermIndex = _b[1];
    var selectedData = termGradeData[selectedTermIndex].grades;
    return (<Card_1.TermSelectCard id={id} title="Previous Grades" onTermSelect={setSelectedTermIndex} terms={terms}>
      <GradeChart_1["default"] data={selectedData}/>
    </Card_1.TermSelectCard>);
}
exports["default"] = GradeCard;

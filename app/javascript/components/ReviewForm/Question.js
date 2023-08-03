"use strict";
exports.__esModule = true;
var React = require("react");
function questionValueRange(type) {
    switch (type) {
        case 'agreement':
            return ['1', '2', '3', '4', '5', '6', '7'];
        case 'time':
            return ['0-5', '5-10', '10-15', '15-20', '20+'];
        case 'binary':
            return ['false', 'true'];
        case 'count':
            return ['0', '1', '2', '3'];
        case 'final':
            return ['none', '10th', 'finals'];
    }
}
function questionLabelForValue(q) {
    var likertResponsesAgreement = {
        '1': 'Strongly disagree',
        '2': 'Disagree',
        '3': 'Somewhat disagree',
        '4': 'Neutral',
        '5': 'Somewhat agree',
        '6': 'Agree',
        '7': 'Strongly agree'
    };
    var responsesCount = {
        '0': '0',
        '1': '1',
        '2': '2',
        '3': '3 or more'
    };
    var responsesBinary = {
        "false": 'No',
        "true": 'Yes'
    };
    var responsesFinal = {
        none: 'No',
        '10th': 'Yes, during 10th week',
        finals: 'Yes, during finals week'
    };
    switch (q.type) {
        case 'agreement':
            return likertResponsesAgreement[q.value];
        case 'time':
            return "".concat(q.value, " hrs/week");
        case 'binary':
            return responsesBinary[q.value];
        case 'count':
            return responsesCount[q.value];
        case 'final':
            return responsesFinal[q.value];
    }
}
function Question(_a) {
    var id = _a.id, text = _a.text, type = _a.type, required = _a.required, onSelect = _a.onSelect, checkedValue = _a.value;
    var onChange = function (e) {
        onSelect(id, e.target.value);
    };
    return (<div className="mb-12" id={id} role="presentation">
      <h4 className="text-center my-4 text-lg font-bold" aria-hidden>
        {text}
      </h4>
      <div className="max-w-xl mx-auto flex flex-col sm:flex-row justify-between" role="radiogroup" aria-label={text}>
        {
        // @ts-ignore: TypeScript can't tell that questionValueRange works
        questionValueRange(type).map(function (value, i) {
            var inputId = "review_".concat(id, "_").concat(i);
            return (<div key={inputId} className="flex-1 flex flex-row sm:flex-col items-center text-center text-sm mb-2 sm:mb-0">
                <input type="radio" id={inputId} name={"review[".concat(id, "]")} value={value} className="rating-radio" required={required} onChange={onChange} checked={value === checkedValue}/>
                <label htmlFor={inputId} className="ml-2 sm:ml-0">
                  {questionLabelForValue({ type: type, value: value })}
                </label>
              </div>);
        })}
      </div>
    </div>);
}
exports["default"] = Question;

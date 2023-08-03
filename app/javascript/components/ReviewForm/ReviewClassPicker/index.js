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
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (g && (g = 0, op[0] && (_ = 0)), _) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
exports.__esModule = true;
var React = require("react");
var react_1 = require("react");
var Alert_1 = require("components/Alert");
var AutocompletableInput_1 = require("components/AutocompletableInput");
var LoadingCircle_1 = require("components/icons/LoadingCircle");
var Select_1 = require("components/Select");
var courseToString = function (c) {
    return c === null ? 'unknown' : "".concat(c.subjectAreaCode, " ").concat(c.number, ": ").concat(c.title);
};
var sectionToLabel = function (section) {
    var label = '';
    if (section.index) {
        label += "Lecture ".concat(section.index, ": ");
    }
    if (section.instructor) {
        label += section.instructor.fullLabel;
    }
    else {
        label += section.registrarInstructors[0];
    }
    if (section.days[0]) {
        label += " (".concat(section.days[0]).concat(section.times[0] && " at ".concat(section.times[0]), ")");
    }
    return label;
};
var reviewClassPickerReducer = function (state, partialState) {
    var nextState = __assign(__assign({}, state), partialState);
    return nextState;
};
var initializeReviewClassPickerState = function (initialSuggestion) {
    // Render initial suggestion, if there is one
    var selectedCourse = null;
    var terms = [];
    var sections = [];
    var precedingCourse = null;
    var supersedingCourse = null;
    var selectedTermIndex = 'placeholder';
    var selectedSectionIndex = 'placeholder';
    if ((initialSuggestion === null || initialSuggestion === void 0 ? void 0 : initialSuggestion.type) === 'course') {
        selectedCourse = initialSuggestion.course;
    }
    else if ((initialSuggestion === null || initialSuggestion === void 0 ? void 0 : initialSuggestion.type) === 'section') {
        var selectedTerm_1 = initialSuggestion.selectedTerm, selectedSection_1 = initialSuggestion.selectedSection;
        selectedCourse = initialSuggestion.course;
        sections = initialSuggestion.sections;
        terms = initialSuggestion.termSuggestion.terms;
        precedingCourse = initialSuggestion.termSuggestion.precedingCourse;
        supersedingCourse = initialSuggestion.termSuggestion.supersedingCourse;
        selectedTermIndex = terms.findIndex(function (term) { return term.term === selectedTerm_1.term; });
        selectedSectionIndex = sections.findIndex(function (section) { return section.id === selectedSection_1.id; });
    }
    return {
        selectedCourse: selectedCourse,
        selectedTermIndex: selectedTermIndex,
        selectedSectionIndex: selectedSectionIndex,
        sections: sections,
        terms: terms,
        precedingCourse: precedingCourse,
        supersedingCourse: supersedingCourse,
        isLoadingTerms: false,
        isLoadingSections: false
    };
};
function ReviewClassPicker(_a) {
    var _this = this;
    var coursesUrl = _a.coursesUrl, sectionSuggestionsUrl = _a.sectionSuggestionsUrl, termSuggestionsUrl = _a.termSuggestionsUrl, _b = _a.initialSuggestion, initialSuggestion = _b === void 0 ? null : _b, onSectionSelectCallback = _a.onSectionSelect;
    (0, react_1.useEffect)(function () {
        if ((initialSuggestion === null || initialSuggestion === void 0 ? void 0 : initialSuggestion.type) === 'section') {
            // Trigger the section selection callback, since we're starting with a selected section!
            onSectionSelectCallback(initialSuggestion.selectedSection.id.toString());
        }
        // Only run on initial mount
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, []);
    var _c = (0, react_1.useReducer)(reviewClassPickerReducer, initialSuggestion, initializeReviewClassPickerState), state = _c[0], updateState = _c[1];
    var selectedCourse = state.selectedCourse, sections = state.sections, terms = state.terms, selectedTermIndex = state.selectedTermIndex, selectedSectionIndex = state.selectedSectionIndex, precedingCourse = state.precedingCourse, supersedingCourse = state.supersedingCourse;
    // Derived state
    var selectedTerm = terms[selectedTermIndex];
    // Memoized derived state
    var termItems = (0, react_1.useMemo)(function () { return terms.map(function (term) { return ({ id: term.term, label: term.readable }); }); }, [terms]);
    var sectionItems = (0, react_1.useMemo)(function () { return sections.map(function (section) { return ({ id: section.id, label: sectionToLabel(section) }); }); }, [sections]);
    // Fetch the terms and deprecation info for a given course.
    // Triggered on changes to selected course.
    (0, react_1.useEffect)(function () {
        var fetchTerms = function () { return __awaiter(_this, void 0, void 0, function () {
            var url, res, termSuggestion;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        if (selectedCourse === null)
                            return [2 /*return*/];
                        url = new URL("".concat(termSuggestionsUrl, "?course_id=").concat(selectedCourse.id));
                        updateState({ isLoadingTerms: true });
                        _a.label = 1;
                    case 1:
                        _a.trys.push([1, , 6, 7]);
                        return [4 /*yield*/, fetch(url.toString(), {
                                headers: { Accept: 'application/json' }
                            })];
                    case 2:
                        res = _a.sent();
                        if (!res.ok) return [3 /*break*/, 4];
                        return [4 /*yield*/, res.json()];
                    case 3:
                        termSuggestion = _a.sent();
                        updateState(__assign({}, termSuggestion));
                        return [3 /*break*/, 5];
                    case 4:
                        console.error('Could not get terms', url.toString(), res.status);
                        _a.label = 5;
                    case 5: return [3 /*break*/, 7];
                    case 6:
                        updateState({ isLoadingTerms: false });
                        return [7 /*endfinally*/];
                    case 7: return [2 /*return*/];
                }
            });
        }); };
        fetchTerms();
    }, [selectedCourse, termSuggestionsUrl]);
    // Fetch sections corresponding to currently chosen course and term.
    // Triggered on changes to selected course or term.
    (0, react_1.useEffect)(function () {
        var fetchSections = function () { return __awaiter(_this, void 0, void 0, function () {
            var url, res, sections_1;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        if (selectedCourse === null || selectedTerm === null)
                            return [2 /*return*/];
                        url = new URL("".concat(sectionSuggestionsUrl, "?course_id=").concat(selectedCourse.id, "&term=").concat(selectedTerm.term));
                        updateState({ isLoadingSections: true });
                        _a.label = 1;
                    case 1:
                        _a.trys.push([1, , 6, 7]);
                        return [4 /*yield*/, fetch(url.toString(), {
                                headers: { Accept: 'application/json' }
                            })];
                    case 2:
                        res = _a.sent();
                        if (!res.ok) return [3 /*break*/, 4];
                        return [4 /*yield*/, res.json()];
                    case 3:
                        sections_1 = _a.sent();
                        updateState({ sections: sections_1 });
                        return [3 /*break*/, 5];
                    case 4:
                        console.error('Could not get sections', url.toString(), res.status);
                        _a.label = 5;
                    case 5: return [3 /*break*/, 7];
                    case 6:
                        updateState({ isLoadingSections: false });
                        return [7 /*endfinally*/];
                    case 7: return [2 /*return*/];
                }
            });
        }); };
        fetchSections();
    }, [sectionSuggestionsUrl, selectedCourse, selectedTerm]);
    var onCourseSelect = function (course) {
        updateState({
            selectedCourse: course,
            selectedTermIndex: 'placeholder',
            selectedSectionIndex: 'placeholder',
            sections: []
        });
    };
    var onTermSelect = function (_, i) {
        updateState({ selectedTermIndex: i, selectedSectionIndex: 'placeholder' });
    };
    var onSectionSelect = function (_, i) {
        var section = sections[i];
        updateState({ selectedSectionIndex: i });
        onSectionSelectCallback(section.id.toString());
    };
    return (<div className="w-full space-y-4">
      <AutocompletableInput_1["default"] id="review-class-picker" suggestionUrl={coursesUrl} label="Course" placeholder="Search for your class…" onSelect={onCourseSelect} initialSelectedItem={selectedCourse} required={true} renderSuggestion={AutocompletableInput_1.renderCourse} suggestionToString={courseToString}/>

      {precedingCourse !== null && (<Alert_1["default"] type="info" title="Can't find your term?">
          <p>
            This course was previously offered as{' '}
            <a className="underline cursor-pointer" onClick={function () { return onCourseSelect(precedingCourse); }}>
              {courseToString(precedingCourse)}
            </a>
            .
          </p>
        </Alert_1["default"]>)}

      {supersedingCourse !== null && (<Alert_1["default"] type="info" title="Can't find your term?">
          <p>
            This course is no longer offered and has been renamed to{' '}
            <a className="underline cursor-pointer" onClick={function () { return onCourseSelect(supersedingCourse); }}>
              {courseToString(supersedingCourse)}
            </a>
            .
          </p>
        </Alert_1["default"]>)}

      {selectedCourse &&
            (state.isLoadingTerms ? (<LoadingCircle_1["default"] className="h-5 w-5 my-2"/>) : (<Select_1["default"] id="term" label="Term" items={termItems} onSelect={onTermSelect} value={selectedTermIndex}/>))}

      {selectedCourse &&
            selectedTerm &&
            (state.isLoadingSections ? (<LoadingCircle_1["default"] className="h-5 w-5 my-2"/>) : (<Select_1["default"] id="section" label="Section" items={sectionItems} onSelect={onSectionSelect} value={selectedSectionIndex}/>))}
    </div>);
}
exports["default"] = ReviewClassPicker;

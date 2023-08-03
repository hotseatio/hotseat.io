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
var lodash_es_1 = require("lodash-es");
var ReviewClassPicker_1 = require("./ReviewClassPicker");
var Question_1 = require("./Question");
var Alert_1 = require("components/Alert");
var Select_1 = require("components/Select");
var LoadingCircle_1 = require("components/icons/LoadingCircle");
var authenticityHeaders_1 = require("utilities/authenticityHeaders");
var snakecaseObject_1 = require("utilities/snakecaseObject");
var formReducer = function (state, partialState) {
    var nextState = __assign(__assign({}, state), partialState);
    return nextState;
};
var initializeReviewFormState = function (_a) {
    var review = _a.review, grades = _a.grades;
    var _b = review !== null && review !== void 0 ? review : {}, grade = _b.grade, sectionId = _b.sectionId, organization = _b.organization, clarity = _b.clarity, overall = _b.overall, weeklyTime = _b.weeklyTime, groupProject = _b.groupProject, extraCredit = _b.extraCredit, attendance = _b.attendance, midtermCount = _b.midtermCount, final = _b.final, textbook = _b.textbook, comments = _b.comments;
    var gradeIndex = grades.findIndex(function (currentGrade) { return grade === currentGrade; });
    if (gradeIndex === -1) {
        gradeIndex = 'placeholder';
    }
    return {
        sectionId: sectionId,
        grade: grade,
        gradeIndex: gradeIndex,
        organization: organization,
        clarity: clarity,
        overall: overall,
        weeklyTime: weeklyTime,
        groupProject: groupProject,
        extraCredit: extraCredit,
        attendance: attendance,
        midtermCount: midtermCount,
        final: final,
        textbook: textbook,
        comments: comments
    };
};
var formatStateToRequestBody = function (formState) { return ({
    review: (0, snakecaseObject_1["default"])((0, lodash_es_1.omit)(formState, 'gradeIndex'))
}); };
var constructOnSubmit = function (_a) {
    var state = _a.state, setIsSubmitting = _a.setIsSubmitting, setError = _a.setError, url = _a.url, method = _a.method;
    return function (e) { return __awaiter(void 0, void 0, void 0, function () {
        var body, response, responseBody;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    e.preventDefault();
                    setIsSubmitting(true);
                    body = formatStateToRequestBody(state);
                    return [4 /*yield*/, fetch(url, {
                            method: method,
                            headers: (0, authenticityHeaders_1.authenticityHeaders)({ 'Content-Type': 'application/json' }),
                            body: JSON.stringify(body)
                        })];
                case 1:
                    response = _a.sent();
                    if (!(response.status !== 200)) return [3 /*break*/, 3];
                    return [4 /*yield*/, response.json()];
                case 2:
                    responseBody = _a.sent();
                    setError(responseBody.msg);
                    return [3 /*break*/, 4];
                case 3:
                    if (response.redirected === true) {
                        window.location.href = response.url;
                    }
                    _a.label = 4;
                case 4:
                    setIsSubmitting(false);
                    return [2 /*return*/];
            }
        });
    }); };
};
function ReviewForm(_a) {
    var createUrl = _a.createUrl, editUrl = _a.editUrl, coursesUrl = _a.coursesUrl, sectionSuggestionsUrl = _a.sectionSuggestionsUrl, termSuggestionsUrl = _a.termSuggestionsUrl, initialSuggestion = _a.initialSuggestion, questionSections = _a.questionSections, grades = _a.grades, review = _a.review;
    var _b = (0, react_1.useState)(null), error = _b[0], setError = _b[1];
    var _c = (0, react_1.useState)(false), isSubmitting = _c[0], setIsSubmitting = _c[1];
    var _d = (0, react_1.useReducer)(formReducer, { review: review, grades: grades }, initializeReviewFormState), formData = _d[0], updateFormData = _d[1];
    var gradeItems = (0, react_1.useMemo)(function () { return grades.map(function (grade) { return ({ id: grade, label: grade }); }); }, [grades]);
    var isEdit = review !== null;
    var onSubmit = constructOnSubmit({
        url: isEdit ? editUrl : createUrl,
        method: isEdit ? 'PATCH' : 'POST',
        state: formData,
        setError: setError,
        setIsSubmitting: setIsSubmitting
    });
    return (<form acceptCharset="UTF-8" action={isEdit ? editUrl : createUrl} method={isEdit ? 'patch' : 'post'} onSubmit={onSubmit}>
      <h3 className="my-6 text-2xl font-extrabold text-gray-900 dark:text-white">The class</h3>
      <ReviewClassPicker_1["default"] coursesUrl={coursesUrl} sectionSuggestionsUrl={sectionSuggestionsUrl} termSuggestionsUrl={termSuggestionsUrl} initialSuggestion={initialSuggestion} onSectionSelect={function (sectionId) { return updateFormData({ sectionId: sectionId }); }}/>

      <Select_1["default"] id="grade" className="mt-4" label="Received grade" items={gradeItems} value={formData.gradeIndex} onSelect={function (selected, i) { return updateFormData({ grade: selected.label, gradeIndex: i }); }}/>

      {questionSections.map(function (section) { return (<div className="my-4" key={section.title}>
          <h3 className="my-6 text-2xl font-extrabold text-gray-900 dark:text-white">{section.title}</h3>
          {section.questions.map(function (question) {
                var _a;
                return (<Question_1["default"] key={question.id} id={question.id} text={question.text} type={question.type} required={question.required} onSelect={function (id, value) {
                    var _a;
                    return updateFormData((_a = {}, _a[(0, lodash_es_1.camelCase)(id)] = value, _a));
                }} value={(_a = formData[(0, lodash_es_1.camelCase)(question.id)]) !== null && _a !== void 0 ? _a : null}/>);
            })}
        </div>); })}

      <div className="my-4">
        <h3 id="comments" className="text-2xl font-extrabold text-gray-900 dark:text-white">
          Comments
        </h3>
        <div className="text-sm text-gray-500 dark:text-gray-400">
          <p className="mb-1">Not sure what to write? Here are some places to start!</p>
          <ul className="list-disc list-inside">
            <li>What did you like about lectures? What could the instructor improve upon?</li>
            <li>Were you prepared for tests from lectures, readings, and the homeworks?</li>
            <li>Did you receive the grade you expected?</li>
            <li>Did you learn what you wanted to from the class?</li>
          </ul>
        </div>

        <textarea required={true} rows={8} className="text-field mt-4" name="review[comments]" id="review_comments" onChange={function (e) { return updateFormData({ comments: e.target.value }); }} aria-labelledby="comments" value={formData.comments}/>
      </div>

      {error !== null && (<Alert_1["default"] type="error" title="Could not submit review">
          <p>{error}</p>
        </Alert_1["default"]>)}

      <button type="submit" name="button" className="mt-4 submit-button disabled:opacity-50 flex items-center justify-center" disabled={isSubmitting}>
        <span>{isEdit ? 'Edit review' : 'Publish review'}</span>
        {isSubmitting && <LoadingCircle_1["default"] className="ml-2 h-5 w-5"/>}
      </button>
    </form>);
}
exports["default"] = ReviewForm;

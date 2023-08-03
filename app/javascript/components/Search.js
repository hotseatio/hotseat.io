"use strict";
exports.__esModule = true;
var React = require("react");
var react_1 = require("react");
var clsx_1 = require("clsx");
var AutocompletableInput_1 = require("components/AutocompletableInput");
var renderSearchSuggestion = function (s) {
    switch (s.searchableType) {
        case 'Course':
            return (<div className="w-full truncate">
          {"".concat(s.searchable.subjectAreaCode, " ").concat(s.searchable.number, " ")}
          <span className="text-gray-400 dark:text-gray-500">{s.searchable.title}</span>
        </div>);
        case 'Instructor':
            return s.searchable.fullLabel;
    }
};
var suggestionToString = function (s) {
    switch (s === null || s === void 0 ? void 0 : s.searchableType) {
        case 'Course':
            return "".concat(s.searchable.subjectAreaCode, " ").concat(s.searchable.number, ": ").concat(s.searchable.title);
        case 'Instructor':
            return s.searchable.fullLabel;
        default:
            return 'unknown';
    }
};
function Search(_a) {
    var searchUrl = _a.searchUrl, suggestionUrl = _a.suggestionUrl, _b = _a.placeholder, placeholder = _b === void 0 ? '' : _b, _c = _a.initialValue, initialValue = _c === void 0 ? undefined : _c, _d = _a.label, label = _d === void 0 ? 'Search' : _d, _e = _a.magnifyingGlass, magnifyingGlass = _e === void 0 ? false : _e, _f = _a.isShrinkable, isShrinkable = _f === void 0 ? false : _f;
    var _g = (0, react_1.useState)(false), isExpanded = _g[0], setIsExpanded = _g[1];
    var _h = (0, react_1.useState)(initialValue), inputValue = _h[0], setInputValue = _h[1];
    var onSelect = function (selectedItem) {
        // Do not import turbolinks since that fails for server-side rendering.
        if (self.Turbo) {
            self.Turbo.visit(selectedItem.searchable.linkUrl);
        }
        else {
            location.assign(selectedItem.searchable.linkUrl);
        }
    };
    var onInputChange = function (input) {
        setInputValue(input);
    };
    var onFormSubmit = function (event) {
        if (self.Turbo) {
            event.preventDefault();
            if (inputValue) {
                var url = new URL(searchUrl, document.URL);
                url.searchParams.set('q', inputValue);
                self.Turbo.visit(url.toString());
            }
        }
    };
    var onFocus = isShrinkable ? function () { return setIsExpanded(true); } : undefined;
    var onBlur = isShrinkable ? function () { return setIsExpanded(false); } : undefined;
    var className = isShrinkable
        ? (0, clsx_1.clsx)('w-full mx-auto transition-all duration-300 ease-in-out', isExpanded ? 'sm:max-w-xl' : 'sm:max-w-xs')
        : undefined;
    return (<form method="get" action={searchUrl} onSubmit={onFormSubmit}>
      <AutocompletableInput_1["default"] id="search-downshift-input" className={className} label={label} placeholder={placeholder} shouldDisplayIcon={magnifyingGlass} suggestionUrl={suggestionUrl} onSelect={onSelect} onFocus={onFocus} onBlur={onBlur} onInputChange={onInputChange} renderSuggestion={renderSearchSuggestion} suggestionToString={suggestionToString}/>
    </form>);
}
exports["default"] = Search;

"use strict";
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
exports.renderCourse = void 0;
var React = require("react");
var react_1 = require("react");
var downshift_1 = require("downshift");
var debounce_1 = require("@react-hook/debounce");
var solid_1 = require("@heroicons/react/20/solid");
var clsx_1 = require("clsx");
var renderCourse = function (c) {
    return (<div className="w-full truncate">
      {"".concat(c.subjectAreaCode, " ").concat(c.number, " ")}
      <span className="text-gray-400 dark:text-gray-500">{c.title}</span>
    </div>);
};
exports.renderCourse = renderCourse;
function AutocompletableInput(_a) {
    var _this = this;
    var id = _a.id, className = _a.className, suggestionUrl = _a.suggestionUrl, label = _a.label, onSelect = _a.onSelect, onInputChange = _a.onInputChange, onFocus = _a.onFocus, onBlur = _a.onBlur, placeholder = _a.placeholder, renderSuggestion = _a.renderSuggestion, suggestionToString = _a.suggestionToString, _b = _a.shouldDisplayIcon, shouldDisplayIcon = _b === void 0 ? false : _b, initialSelectedItem = _a.initialSelectedItem, _c = _a.required, required = _c === void 0 ? false : _c;
    var _d = (0, react_1.useState)([]), suggestions = _d[0], setSuggestions = _d[1];
    var fetchSuggestions = (0, debounce_1.useDebounceCallback)(function (value) { return __awaiter(_this, void 0, void 0, function () {
        var url, res, _a, error_1;
        return __generator(this, function (_b) {
            switch (_b.label) {
                case 0:
                    url = new URL(suggestionUrl);
                    url.searchParams.set('q', value);
                    _b.label = 1;
                case 1:
                    _b.trys.push([1, 6, , 7]);
                    return [4 /*yield*/, fetch(url.toString(), { headers: { Accept: 'application/json' } })];
                case 2:
                    res = _b.sent();
                    if (!res.ok) return [3 /*break*/, 4];
                    _a = setSuggestions;
                    return [4 /*yield*/, res.json()];
                case 3:
                    _a.apply(void 0, [(_b.sent())]);
                    return [3 /*break*/, 5];
                case 4:
                    console.error('Could not get suggestions', res.status);
                    _b.label = 5;
                case 5: return [3 /*break*/, 7];
                case 6:
                    error_1 = _b.sent();
                    console.error(url, error_1);
                    return [3 /*break*/, 7];
                case 7: return [2 /*return*/];
            }
        });
    }); }, 200);
    var _e = (0, downshift_1.useCombobox)({
        id: id,
        items: suggestions,
        initialSelectedItem: initialSelectedItem,
        itemToString: suggestionToString,
        onInputValueChange: function (_a) {
            var inputValue = _a.inputValue;
            if (onInputChange) {
                onInputChange(inputValue);
            }
            if (inputValue) {
                fetchSuggestions(inputValue);
            }
        },
        onSelectedItemChange: function (_a) {
            var selectedItem = _a.selectedItem;
            if (selectedItem) {
                onSelect(selectedItem);
            }
        }
    }), isOpen = _e.isOpen, getLabelProps = _e.getLabelProps, getMenuProps = _e.getMenuProps, getInputProps = _e.getInputProps, highlightedIndex = _e.highlightedIndex, getItemProps = _e.getItemProps;
    return (<div className={(0, clsx_1.clsx)('relative', className)} role="presentation">
      <label className="sr-only" {...getLabelProps()}>
        {label}
      </label>
      <div className="rounded-md shadow-sm">
        {shouldDisplayIcon && (<div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
            <solid_1.MagnifyingGlassIcon className="h-5 w-5 text-gray-400 dark:text-gray-500" fill="currentColor" aria-hidden="true"/>
          </div>)}
        <input {...getInputProps({ onFocus: onFocus, onBlur: onBlur })} placeholder={placeholder} type="text" className={(0, clsx_1.clsx)('base-input block w-full rounded-md', { 'pl-10': shouldDisplayIcon })} required={required}/>
      </div>
      <ul {...getMenuProps()} 
    // Only show when we have results, otherwise the menu looks weird!
    hidden={!isOpen || suggestions.length === 0} className="absolute z-10 mt-1 py-1 bg-white dark:bg-black w-full shadow-lg max-h-60 rounded-md text-base ring-1 ring-black ring-opacity-5 overflow-auto focus:outline-none sm:text-md">
        {suggestions.map(function (suggestion, index) { return (<li className={(0, clsx_1.clsx)(highlightedIndex === index ? 'text-white bg-red-600' : 'text-gray-900 dark:text-gray-50', 'cursor-default select-none relative py-2 pl-8 pr-4')} key={suggestion.id} {...getItemProps({ item: suggestion, index: index })}>
            {renderSuggestion(suggestion)}
          </li>); })}
      </ul>
    </div>);
}
exports["default"] = AutocompletableInput;

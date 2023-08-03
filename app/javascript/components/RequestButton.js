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
var React = require("react");
var react_1 = require("react");
var clsx_1 = require("clsx");
var LoadingCircle_1 = require("components/icons/LoadingCircle");
var authenticityHeaders_1 = require("utilities/authenticityHeaders");
function RequestButton(_a) {
    var _this = this;
    var title = _a.title, className = _a.className, loadingClassName = _a.loadingClassName, resource = _a.resource, method = _a.method, body = _a.body, onClick = _a.onClick, onError = _a.onError, _b = _a.disabled, disabled = _b === void 0 ? false : _b, children = _a.children;
    var _c = (0, react_1.useState)(false), isSubmitting = _c[0], setIsSubmitting = _c[1];
    var onSubmit = function (e) { return __awaiter(_this, void 0, void 0, function () {
        var response, responseBody, _a, responseBody;
        return __generator(this, function (_b) {
            switch (_b.label) {
                case 0:
                    e.preventDefault();
                    setIsSubmitting(true);
                    return [4 /*yield*/, fetch(resource, {
                            method: method,
                            headers: (0, authenticityHeaders_1.authenticityHeaders)({ 'Content-Type': 'application/json' }),
                            body: body ? JSON.stringify(body) : undefined
                        })];
                case 1:
                    response = _b.sent();
                    if (response.redirected === true) {
                        window.location.href = response.url;
                        return [2 /*return*/];
                    }
                    setIsSubmitting(false);
                    if (!!response.ok) return [3 /*break*/, 6];
                    console.error(response);
                    if (!onError) return [3 /*break*/, 5];
                    _b.label = 2;
                case 2:
                    _b.trys.push([2, 4, , 5]);
                    return [4 /*yield*/, response.json()];
                case 3:
                    responseBody = _b.sent();
                    onError(responseBody);
                    return [3 /*break*/, 5];
                case 4:
                    _a = _b.sent();
                    onError();
                    return [3 /*break*/, 5];
                case 5: return [3 /*break*/, 8];
                case 6:
                    if (!onClick) return [3 /*break*/, 8];
                    return [4 /*yield*/, response.json()];
                case 7:
                    responseBody = _b.sent();
                    onClick(responseBody);
                    _b.label = 8;
                case 8: return [2 /*return*/];
            }
        });
    }); };
    return isSubmitting ? (<LoadingCircle_1["default"] className={(0, clsx_1.clsx)('h-5 w-5', loadingClassName)}/>) : (<button title={title} className={className} onClick={onSubmit} disabled={disabled}>
      {children}
    </button>);
}
exports["default"] = RequestButton;

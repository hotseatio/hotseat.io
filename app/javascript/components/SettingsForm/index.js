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
var __rest = (this && this.__rest) || function (s, e) {
    var t = {};
    for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
        t[p] = s[p];
    if (s != null && typeof Object.getOwnPropertySymbols === "function")
        for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
            if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                t[p[i]] = s[p[i]];
        }
    return t;
};
exports.__esModule = true;
var React = require("react");
var react_1 = require("react");
var react_2 = require("@headlessui/react");
var clsx_1 = require("clsx");
var outline_1 = require("@heroicons/react/24/outline");
var CopyToClipboardInput_1 = require("./CopyToClipboardInput");
var PhoneInput_1 = require("./PhoneInput");
var DevicesTable_1 = require("./DevicesTable");
// TODO: come back and polish up notification preferences
// import NotificationPreferences from './NotificationPreferences'
var LoadingCircle_1 = require("components/icons/LoadingCircle");
var Alert_1 = require("components/Alert");
var authenticityHeaders_1 = require("utilities/authenticityHeaders");
function SettingsForm(_a) {
    var _this = this;
    var updateUrl = _a.updateUrl, phoneNumber = _a.phoneNumber, devices = _a.devices, props = __rest(_a, ["updateUrl", "phoneNumber", "devices"]);
    var _b = (0, react_1.useState)(null), response = _b[0], setResponse = _b[1];
    var _c = (0, react_1.useState)(false), isSubmitting = _c[0], setIsSubmitting = _c[1];
    var _d = (0, react_1.useState)(props.betaTester), betaTester = _d[0], setBetaTester = _d[1];
    var onSubmit = function (e) { return __awaiter(_this, void 0, void 0, function () {
        var body, response, responseBody;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    e.preventDefault();
                    setIsSubmitting(true);
                    body = { beta_tester: betaTester, phone: phoneNumber };
                    return [4 /*yield*/, fetch(updateUrl, {
                            method: 'PUT',
                            headers: (0, authenticityHeaders_1.authenticityHeaders)({ 'Content-Type': 'application/json' }),
                            body: JSON.stringify(body)
                        })];
                case 1:
                    response = _a.sent();
                    return [4 /*yield*/, response.json()];
                case 2:
                    responseBody = _a.sent();
                    if (response.status !== 200) {
                        setResponse({ type: 'error', title: responseBody.title, msg: responseBody.msg });
                    }
                    else {
                        setResponse({ type: 'success', title: responseBody.title, msg: responseBody.msg });
                    }
                    setIsSubmitting(false);
                    return [2 /*return*/];
            }
        });
    }); };
    return (<div className="pt-8 sm:px-6 lg:px-8">
      <div className="sm:mx-auto sm:w-full sm:max-w-md">
        <outline_1.FireIcon className="mx-auto h-16 w-auto" aria-hidden="true"/>
        <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900 dark:text-gray-50">Settings</h2>
      </div>

      <div className="mt-8 sm:mx-auto sm:w-full sm:max-w-2xl">
        <div className="bg-white dark:bg-gray-900 py-8 px-4 shadow sm:rounded-lg sm:px-10">
          <form acceptCharset="UTF-8" onSubmit={onSubmit} className="space-y-6">
            <div>
              <label className="input-label" htmlFor="user_name">
                Name
              </label>
              <input className="text-field" disabled={true} type="text" value={props.name} name="user[name]" id="user_name"/>
              <p className="mt-0.5 text-xs text-gray-500 dark:text-gray-400">
                You can change your name via your{' '}
                <a href="https://myaccount.google.com/personal-info" className="underline focus:outline-none focus:ring-2 focus:ring-inset focus:ring-red-500">
                  UCLA Google Account
                </a>
                .
              </p>
            </div>

            <div>
              <label className="input-label" htmlFor="user_email">
                UCLA Email
              </label>
              <input className="text-field" disabled={true} type="email" value={props.email} name="user[email]" id="user_email"/>
            </div>

            <PhoneInput_1["default"] initialPhoneNumber={phoneNumber !== null && phoneNumber !== void 0 ? phoneNumber : null}/>

            <div>
              <label className="input-label" htmlFor="referral_input">
                Referrals
              </label>
              <p className="text-xs text-gray-500 dark:text-gray-400">
                {"Referred users earn two notification tokens for the first review they write. You'll receive a bonus notification token as well!"}
              </p>

              <CopyToClipboardInput_1["default"] value={props.referralLink} name="referral_input" id="referral_input"/>
            </div>

            {betaTester && <DevicesTable_1["default"] devices={devices}/>}
            {/* <NotificationPreferences /> */}

            <react_2.Switch.Group as="div" className="flex items-center justify-between" id="beta_tester">
              <react_2.Switch.Label as="span" className="flex-grow flex flex-col" passive>
                <span className="input-label">Beta Test New Features</span>
                <span className="text-sm text-gray-500 mr-4">
                  As a tester, you will receive access to features that may be unstable. We may occaisionally reach out
                  to you for feedback on these features. You can opt out at any time by disabling this toggle.
                </span>
              </react_2.Switch.Label>
              <react_2.Switch checked={betaTester} onChange={setBetaTester} className={(0, clsx_1.clsx)(betaTester ? 'bg-red-600' : 'bg-gray-200', 'relative inline-flex flex-shrink-0 h-6 w-11 border-2 border-transparent rounded-full cursor-pointer transition-colors ease-in-out duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500')}>
                <span className="sr-only">Become a beta tester</span>
                <span aria-hidden="true" className={(0, clsx_1.clsx)(betaTester ? 'translate-x-5' : 'translate-x-0', 'pointer-events-none inline-block h-5 w-5 rounded-full bg-white shadow transform ring-0 transition ease-in-out duration-200')}/>
              </react_2.Switch>
            </react_2.Switch.Group>

            {response !== null && (<Alert_1["default"] type={response.type} title={response.title}>
                <p>{response.msg}</p>
              </Alert_1["default"]>)}

            <button type="submit" name="button" className="mt-4 submit-button disabled:opacity-50 flex items-center justify-center" disabled={isSubmitting}>
              <span>Update account</span>
              {isSubmitting && <LoadingCircle_1["default"] className="ml-2 h-5 w-5"/>}
            </button>
          </form>
        </div>
      </div>
    </div>);
}
exports["default"] = SettingsForm;

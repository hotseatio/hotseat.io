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
var __spreadArray = (this && this.__spreadArray) || function (to, from, pack) {
    if (pack || arguments.length === 2) for (var i = 0, l = from.length, ar; i < l; i++) {
        if (ar || !(i in from)) {
            if (!ar) ar = Array.prototype.slice.call(from, 0, i);
            ar[i] = from[i];
        }
    }
    return to.concat(ar || Array.prototype.slice.call(from));
};
exports.__esModule = true;
var React = require("react");
var react_1 = require("react");
var lodash_es_1 = require("lodash-es");
var RequestButton_1 = require("components/RequestButton");
var LoadingCircle_1 = require("components/icons/LoadingCircle");
var webpushNotifications_1 = require("utilities/webpushNotifications");
function capitalizeFirstLetter(str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
}
function formatDeviceName(device) {
    var _a;
    return (_a = device.name) !== null && _a !== void 0 ? _a : "".concat(capitalizeFirstLetter(device.browser), " (").concat(device.os, ")");
}
function DevicesTable(_a) {
    var _this = this;
    var initialDevices = _a.devices;
    var _b = (0, react_1.useState)(initialDevices), devices = _b[0], setDevices = _b[1];
    var _c = (0, react_1.useState)(false), isAddingDevice = _c[0], setIsAddingDevice = _c[1];
    var hasNoDevicesRegisted = devices.length === 0;
    var addDevice = function () { return __awaiter(_this, void 0, void 0, function () {
        var newDevice_1, error_1;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    setIsAddingDevice(true);
                    _a.label = 1;
                case 1:
                    _a.trys.push([1, 3, 4, 5]);
                    return [4 /*yield*/, (0, webpushNotifications_1.subscribeToPush)()];
                case 2:
                    newDevice_1 = _a.sent();
                    if (devices.some(function (device) { return device.id === newDevice_1.id; })) {
                        window.alert('Device is already added!');
                    }
                    else {
                        setDevices((0, lodash_es_1.sortBy)(__spreadArray(__spreadArray([], devices, true), [newDevice_1], false), 'id'));
                    }
                    return [3 /*break*/, 5];
                case 3:
                    error_1 = _a.sent();
                    if (error_1 instanceof Error) {
                        alert("There was an error registered your device: ".concat(error_1.message));
                    }
                    else {
                        alert("There was an error registered your device: ".concat(error_1));
                    }
                    return [3 /*break*/, 5];
                case 4:
                    setIsAddingDevice(false);
                    return [7 /*endfinally*/];
                case 5: return [2 /*return*/];
            }
        });
    }); };
    var removeDevice = function (id) {
        setDevices(devices.filter(function (device) {
            device.id !== id;
        }));
    };
    return (<div>
      <div className="sm:flex sm:items-center mt-12">
        <div className="sm:flex-auto">
          <h2 className="text-base font-semibold leading-6 text-gray-900 dark:text-white">Devices</h2>
          <p className="mt-2 text-sm text-gray-600 dark:text-gray-300">
            {hasNoDevicesRegisted
            ? 'Devices that will receive web notifications from Hotseat. Try registering your current device!'
            : 'Your devices that will receive web notifications from Hotseat.'}
          </p>
        </div>
        <div className="mt-4 sm:ml-16 sm:mt-0 sm:flex-none">
          {isAddingDevice ? (<LoadingCircle_1["default"] className="h-5 w-5"/>) : (<button type="button" className="block rounded-md bg-red-600 px-3 py-2 text-center text-sm font-semibold text-white shadow-sm hover:bg-red-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600" onClick={addDevice}>
              Add current device
            </button>)}
        </div>
      </div>
      <div className="mt-2">
        {!hasNoDevicesRegisted && (<table className="min-w-full divide-y divide-gray-300">
            <thead>
              <tr>
                <th scope="col" className="px-3 py-3.5 text-left text-sm font-semibold text-gray-900 dark:text-white">
                  Client
                </th>
                <th scope="col" className="py-3.5">
                  <span className="sr-only">Remove</span>
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-200">
              {devices.map(function (device) { return (<tr key={device.id}>
                  <td className="px-3 py-4 text-sm text-gray-500 dark:text-gray-400">{formatDeviceName(device)}</td>
                  <td className="py-4 text-right text-sm font-medium sm:pr-0">
                    <RequestButton_1["default"] method="DELETE" resource={"/webpush_devices/".concat(device.id)} className="text-red-600 hover:text-red-900" onClick={function () { return removeDevice(device.id); }}>
                      Remove<span className="sr-only">, {formatDeviceName(device)}</span>
                    </RequestButton_1["default"]>
                  </td>
                </tr>); })}
            </tbody>
          </table>)}
      </div>
    </div>);
}
exports["default"] = DevicesTable;

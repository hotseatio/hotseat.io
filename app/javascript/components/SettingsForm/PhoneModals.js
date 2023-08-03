"use strict";
exports.__esModule = true;
exports.RemovePhoneModal = exports.ChangePhoneModal = exports.AddPhoneModal = exports.AddChangePhoneModal = void 0;
var React = require("react");
var react_1 = require("react");
var clsx_1 = require("clsx");
var solid_1 = require("@heroicons/react/20/solid");
var ConfirmModal_1 = require("components/ConfirmModal");
var RequestButton_1 = require("components/RequestButton");
function AddChangePhoneModal(_a) {
    var isOpen = _a.isOpen, type = _a.type, onCancel = _a.onCancel, onConfirm = _a.onConfirm;
    var _b = (0, react_1.useState)(null), phone = _b[0], setPhone = _b[1];
    var _c = (0, react_1.useState)(false), confirmationCodeSent = _c[0], setConfirmationCodeSent = _c[1];
    var _d = (0, react_1.useState)(null), confirmationCode = _d[0], setConfirmationCode = _d[1];
    var _e = (0, react_1.useState)(null), phoneErrorMessage = _e[0], setPhoneErrorMessage = _e[1];
    var _f = (0, react_1.useState)(null), codeErrorMessage = _f[0], setCodeErrorMessage = _f[1];
    var _g = (0, react_1.useState)(null), codePlaceholder = _g[0], setCodePlaceholder = _g[1];
    // Reset modal on open
    (0, react_1.useEffect)(function () {
        if (isOpen) {
            setPhone(null);
            setConfirmationCodeSent(false);
            setConfirmationCode(null);
            setPhoneErrorMessage(null);
            setCodeErrorMessage(null);
        }
    }, [isOpen]);
    var onPhoneInputChange = function (e) {
        setPhone(e.target.value);
    };
    var onConfirmationCodeInputChange = function (e) {
        setConfirmationCode(e.target.value);
    };
    return (<ConfirmModal_1["default"] isOpen={isOpen} title={type === 'new' ? 'Add Phone Number' : 'Change Phone Number'} description="Standard SMS rates may apply." onCancel={onCancel} onConfirm={function () {
            setPhoneErrorMessage(null);
            setCodeErrorMessage(null);
            if (phone)
                onConfirm(phone);
        }} onError={function (error) {
            var _a;
            setCodeErrorMessage((_a = error === null || error === void 0 ? void 0 : error.msg) !== null && _a !== void 0 ? _a : 'Invalid confirmation code');
        }} confirmLabel="Verify" confirmRequest={{
            method: 'POST',
            resource: '/users/confirm-verify-phone',
            body: phone && confirmationCode ? { phone: phone, code: confirmationCode } : undefined
        }} confirmDisabled={(confirmationCode === null || confirmationCode === void 0 ? void 0 : confirmationCode.length) !== 6} Icon={solid_1.PhoneIcon}>
      <div className="w-3/5 mx-auto my-6">
        <div>
          <label htmlFor="phone-number" className={confirmationCodeSent ? 'input-label' : 'sr-only'}>
            Phone Number
          </label>
          <div className="mt-1 flex items-center rounded-md shadow-sm w-full">
            <input type="tel" name="phone-number" id="phone-number" className={(0, clsx_1.clsx)('base-input rounded-l-md border-gray-300 sm:text-sm rounded-r-none flex-1', {
            'text-red-900 placeholder-red-300 dark:placeholder-red-500 focus:outline-none focus:ring-red-500 focus:border-red-500': phoneErrorMessage
        })} placeholder="+1 (555) 987-6543" onChange={onPhoneInputChange} value={phone} aria-invalid={phoneErrorMessage ? 'true' : undefined} aria-describedby={phoneErrorMessage ? 'phone-error-message' : undefined}/>
            <RequestButton_1["default"] method="POST" resource="/users/verify-phone" body={phone ? { phone: phone } : undefined} className="space-x-2 item-center button-background-unrounded rounded-lg rounded-l-none" loadingClassName="ml-3" onError={function (body) { var _a; return setPhoneErrorMessage((_a = body === null || body === void 0 ? void 0 : body.msg) !== null && _a !== void 0 ? _a : 'Could not set phone number'); }} onClick={function (body) {
            var _a;
            if (body.formattedPhone) {
                setPhone(body.formattedPhone);
            }
            setCodePlaceholder((_a = body.confirmationCodePlaceholder) !== null && _a !== void 0 ? _a : null);
            setConfirmationCodeSent(true);
            setPhoneErrorMessage(null);
        }}>
              Add
            </RequestButton_1["default"]>
          </div>
          {phoneErrorMessage && (<p className="mt-0.5 text-sm text-red-600" id="phone-error-message">
              {phoneErrorMessage}
            </p>)}
        </div>
        {confirmationCodeSent && (<div className="mt-2">
            <label htmlFor="phone-number" className="input-label">
              Confirmation Code
            </label>
            <div className="mt-1 flex items-center rounded-md shadow-sm w-full">
              <input type="text" name="confirmation-code" id="confirmation-code" className={(0, clsx_1.clsx)('base-input rounded-l-md sm:text-sm border-gray-300 block w-full rounded-md', {
                'text-red-900 placeholder-red-300 dark:placeholder-red-500 focus:outline-none focus:ring-red-500 focus:border-red-500': codeErrorMessage
            })} onChange={onConfirmationCodeInputChange} placeholder={codePlaceholder} aria-invalid={codeErrorMessage ? 'true' : undefined} aria-describedby={codeErrorMessage ? 'code-error-message' : undefined}/>
            </div>
            {codeErrorMessage && (<p className="mt-1 text-sm text-red-600" id="code-error-message">
                {codeErrorMessage}
              </p>)}
          </div>)}
      </div>
    </ConfirmModal_1["default"]>);
}
exports.AddChangePhoneModal = AddChangePhoneModal;
function AddPhoneModal(props) {
    return <AddChangePhoneModal type="new" {...props}/>;
}
exports.AddPhoneModal = AddPhoneModal;
function ChangePhoneModal(props) {
    return <AddChangePhoneModal type="change" {...props}/>;
}
exports.ChangePhoneModal = ChangePhoneModal;
function RemovePhoneModal(_a) {
    var isOpen = _a.isOpen, onCancel = _a.onCancel, onRemove = _a.onRemove;
    return (<ConfirmModal_1["default"] isOpen={isOpen} title="Remove Phone Number" description="Removing your phone number will unsubscribe you from all classes. Are you sure?" onCancel={onCancel} onConfirm={onRemove} confirmLabel="Remove" confirmRequest={{
            method: 'PUT',
            resource: '/users/remove-phone'
        }} Icon={solid_1.PhoneIcon}/>);
}
exports.RemovePhoneModal = RemovePhoneModal;

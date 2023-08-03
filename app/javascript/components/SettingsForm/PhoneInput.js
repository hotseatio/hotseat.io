"use strict";
exports.__esModule = true;
var React = require("react");
var react_1 = require("react");
var PhoneModals_1 = require("./PhoneModals");
function PhoneInput(_a) {
    var initialPhoneNumber = _a.initialPhoneNumber;
    var _b = (0, react_1.useState)(initialPhoneNumber), phone = _b[0], setPhone = _b[1];
    var _c = (0, react_1.useState)(false), isModalOpen = _c[0], setIsModalOpen = _c[1];
    var input = phone ? (<div className="flex rounded-md shadow-sm">
      <div className="relative flex items-stretch flex-grow focus-within:z-10">
        <input type="tel" value={phone !== null && phone !== void 0 ? phone : undefined} name="user[phone]" id="user_phone" className="base-input block w-full rounded-none rounded-l-md" disabled={true}/>
      </div>
      <button type="button" className="inline-button" onClick={function () { return setIsModalOpen('change'); }}>
        Change
      </button>
      <button type="button" className="inline-button rounded-r-md" onClick={function () { return setIsModalOpen('delete'); }}>
        Remove
      </button>
    </div>) : (<button type="button" id="user_phone" className="button-background" onClick={function () { return setIsModalOpen('new'); }}>
      Add
    </button>);
    return (<div id="phone">
      <label className="input-label mb-1" htmlFor="user_phone">
        Phone Number
      </label>
      {input}
      <PhoneModals_1.AddPhoneModal isOpen={isModalOpen === 'new'} onCancel={function () { return setIsModalOpen(false); }} onConfirm={function (verifiedPhone) {
            setIsModalOpen(false);
            setPhone(verifiedPhone);
        }}/>
      <PhoneModals_1.ChangePhoneModal isOpen={isModalOpen === 'change'} onCancel={function () { return setIsModalOpen(false); }} onConfirm={function (verifiedPhone) {
            setIsModalOpen(false);
            setPhone(verifiedPhone);
        }}/>
      <PhoneModals_1.RemovePhoneModal isOpen={isModalOpen === 'delete'} onCancel={function () { return setIsModalOpen(false); }} onRemove={function () {
            setPhone(null);
            setIsModalOpen(false);
        }}/>
    </div>);
}
exports["default"] = PhoneInput;

"use strict";
exports.__esModule = true;
var React = require("react");
var react_1 = require("react");
var react_2 = require("@headlessui/react");
var RequestButton_1 = require("components/RequestButton");
function ConfirmModal(_a) {
    var isOpen = _a.isOpen, title = _a.title, description = _a.description, onConfirm = _a.onConfirm, onCancel = _a.onCancel, onError = _a.onError, Icon = _a.Icon, confirmRequest = _a.confirmRequest, _b = _a.confirmDisabled, confirmDisabled = _b === void 0 ? false : _b, _c = _a.confirmLabel, confirmLabel = _c === void 0 ? 'Confirm' : _c, _d = _a.cancelLabel, cancelLabel = _d === void 0 ? 'Cancel' : _d, children = _a.children;
    var cancelButtonRef = (0, react_1.useRef)(null);
    return (<react_2.Transition.Root show={isOpen} as={react_1.Fragment}>
      <react_2.Dialog className="fixed z-10 inset-0 overflow-y-auto" initialFocus={cancelButtonRef} onClose={onCancel}>
        <div className="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
          <react_2.Transition.Child as={react_1.Fragment} enter="ease-out duration-300" enterFrom="opacity-0" enterTo="opacity-100" leave="ease-in duration-200" leaveFrom="opacity-100" leaveTo="opacity-0">
            <react_2.Dialog.Overlay className="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity"/>
          </react_2.Transition.Child>

          {/* This element is to trick the browser into centering the modal contents. */}
          <span className="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">
            &#8203;
          </span>
          <react_2.Transition.Child as={react_1.Fragment} enter="ease-out duration-300" enterFrom="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95" enterTo="opacity-100 translate-y-0 sm:scale-100" leave="ease-in duration-200" leaveFrom="opacity-100 translate-y-0 sm:scale-100" leaveTo="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95">
            <div className="inline-block align-bottom bg-white dark:bg-gray-900 rounded-lg px-4 pt-5 pb-4 text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full sm:p-6">
              <div>
                <div className="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-red-100">
                  <Icon className="h-6 w-6 text-red-600" aria-hidden="true"/>
                </div>
                <div className="mt-3 text-center sm:mt-5">
                  <react_2.Dialog.Title as="h3" className="text-lg leading-6 font-medium text-gray-900 dark:text-gray-50">
                    {title}
                  </react_2.Dialog.Title>
                  {description && (<div className="mt-2">
                      <p className="text-sm text-gray-500">{description}</p>
                    </div>)}
                </div>
                {children}
              </div>
              <div className="mt-5 sm:mt-6 sm:grid sm:grid-cols-2 sm:gap-3 sm:grid-flow-row-dense">
                <RequestButton_1["default"] title={confirmLabel} disabled={confirmDisabled} resource={confirmRequest.resource} method={confirmRequest.method} body={confirmRequest.body} className="mt-3 sm:mt-0 sm:col-start-2 submit-button" onClick={onConfirm} onError={onError}>
                  {confirmLabel}
                </RequestButton_1["default"]>
                <button className="mt-3 sm:mt-0 w-full flex justify-center button-background sm:col-start-1" onClick={onCancel} ref={cancelButtonRef}>
                  {cancelLabel}
                </button>
              </div>
            </div>
          </react_2.Transition.Child>
        </div>
      </react_2.Dialog>
    </react_2.Transition.Root>);
}
exports["default"] = ConfirmModal;

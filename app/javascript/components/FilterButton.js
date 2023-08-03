"use strict";
exports.__esModule = true;
var React = require("react");
var react_1 = require("react");
var clsx_1 = require("clsx");
var react_popper_1 = require("react-popper");
var react_2 = require("@headlessui/react");
var solid_1 = require("@heroicons/react/20/solid");
function FilterButton(_a) {
    var _b;
    var links = _a.links;
    var _c = (0, react_1.useState)(null), referenceElement = _c[0], setReferenceElement = _c[1];
    var _d = (0, react_1.useState)(null), popperElement = _d[0], setPopperElement = _d[1];
    var _e = (0, react_popper_1.usePopper)(referenceElement, popperElement, {
        placement: 'bottom-end'
    }), styles = _e.styles, attributes = _e.attributes;
    if (links.length === 0) {
        return null;
    }
    var selectedItem = links.find(function (link) { return link.selected; });
    return (<react_2.Listbox value={selectedItem} onChange={function () {
            /* noop */
        }}>
      <react_2.Listbox.Button className="w-full bg-white dark:bg-gray-900 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm px-4 py-2 inline-flex justify-center text-sm text-gray-700 dark:text-gray-200 hover:bg-gray-50 dark:hover:bg-gray-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500" ref={setReferenceElement}>
        <solid_1.FunnelIcon className="mr-3 h-5 w-5 text-gray-400 dark:text-gray-500" aria-hidden="true"/>
        {(_b = selectedItem === null || selectedItem === void 0 ? void 0 : selectedItem.label) !== null && _b !== void 0 ? _b : 'Filter'}
        <solid_1.ChevronUpDownIcon className="ml-2.5 -mr-1.5 h-5 w-5 text-gray-400 dark:text-gray-500" aria-hidden="true"/>
      </react_2.Listbox.Button>

      <react_2.Listbox.Options className="mt-2 w-56 max-h-96 py-1 overflow-auto rounded-md shadow-lg bg-white dark:bg-gray-900 ring-1 ring-black ring-opacity-5 focus:outline-none" ref={function (element) { return setPopperElement(element); }} style={styles.popper} {...attributes.popper}>
        {links.map(function (link) { return (<react_2.Listbox.Option key={link.key} value={link} className={function (_a) {
                var selected = _a.selected, active = _a.active;
                return (0, clsx_1.clsx)(active ? 'text-white bg-red-600' : 'text-gray-900 dark:text-white', selected ? 'font-semibold' : 'font-normal', 'text-sm');
            }}>
            {function (_a) {
                var selected = _a.selected, active = _a.active;
                return (<a href={link.url} className={'block px-4 py-2 relative'}>
                {link.label}
                {selected ? (<span className={(0, clsx_1.clsx)(active ? 'text-white' : 'text-red-600', 'absolute inset-y-0 right-0 flex items-center pr-4')}>
                    <solid_1.CheckIcon className="h-5 w-5" aria-hidden="true"/>
                  </span>) : null}
              </a>);
            }}
          </react_2.Listbox.Option>); })}
      </react_2.Listbox.Options>
    </react_2.Listbox>);
}
exports["default"] = FilterButton;

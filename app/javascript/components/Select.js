"use strict";
exports.__esModule = true;
var React = require("react");
var react_1 = require("react");
var react_2 = require("@headlessui/react");
var solid_1 = require("@heroicons/react/20/solid");
var clsx_1 = require("clsx");
function Select(_a) {
    var id = _a.id, className = _a.className, label = _a.label, _b = _a.labelInvisible, labelInvisible = _b === void 0 ? false : _b, items = _a.items, onSelect = _a.onSelect, 
    // Zero-width nonbreaking space - keeps the line height of text without containing content
    _c = _a.placeholderText, 
    // Zero-width nonbreaking space - keeps the line height of text without containing content
    placeholderText = _c === void 0 ? '\u200b' : _c, _d = _a.value, value = _d === void 0 ? 'placeholder' : _d;
    var usePlaceholder = value === 'placeholder' || !(value in items);
    var selectedItem = usePlaceholder ? null : items[value];
    var onChange = function (newSelectedID) {
        var newSelectedIndex = items.findIndex(function (item) { return item.id === newSelectedID; });
        onSelect(items[newSelectedIndex], newSelectedIndex);
    };
    return (<div id={id} className={className} role="presentation">
      <react_2.Listbox value={selectedItem === null || selectedItem === void 0 ? void 0 : selectedItem.id} onChange={onChange}>
        {function (_a) {
            var _b;
            var open = _a.open;
            return (<>
            {label && (<react_2.Listbox.Label className={(0, clsx_1.clsx)('block text-sm font-medium text-gray-700 dark:text-gray-200 mb-1', labelInvisible && 'sr-only')}>
                {label}
              </react_2.Listbox.Label>)}
            <div className="relative" role="presentation">
              <react_2.Listbox.Button className="bg-white dark:bg-gray-600 relative w-full border border-gray-300 dark:border-gray-600 rounded-md shadow-sm pl-3 pr-10 py-2 text-left cursor-default focus:outline-none focus:ring-1 focus:ring-red-500 focus:border-red-500 sm:text-sm">
                <span className="block">{(_b = selectedItem === null || selectedItem === void 0 ? void 0 : selectedItem.label) !== null && _b !== void 0 ? _b : placeholderText}</span>

                <span className="absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
                  <solid_1.ChevronUpDownIcon className="h-5 w-5 text-gray-400 dark:text-gray-500" aria-hidden="true"/>
                </span>
              </react_2.Listbox.Button>

              <react_2.Transition show={open} as={react_1.Fragment} leave="transition ease-in duration-100" leaveFrom="opacity-100" leaveTo="opacity-0">
                <react_2.Listbox.Options static className="absolute z-10 mt-1 w-full bg-white dark:bg-black shadow-lg max-h-60 rounded-md py-1 text-base ring-1 ring-black ring-opacity-5 overflow-auto focus:outline-none sm:text-sm">
                  {items.map(function (item) { return (<react_2.Listbox.Option key={item.id} className={function (_a) {
                        var active = _a.active;
                        return (0, clsx_1.clsx)(active ? 'text-white bg-red-600' : 'text-gray-900 dark:text-white', 'cursor-default select-none relative py-2 pl-3 pr-9');
                    }} value={item.id}>
                      {function (_a) {
                        var selected = _a.selected, active = _a.active;
                        return (<>
                          <span className={(0, clsx_1.clsx)(selected ? 'font-semibold' : 'font-normal', 'block truncate')}>
                            {item.label}
                          </span>

                          {selected ? (<span className={(0, clsx_1.clsx)(active ? 'text-white' : 'text-red-600', 'absolute inset-y-0 right-0 flex items-center pr-4')}>
                              <solid_1.CheckIcon className="h-5 w-5" aria-hidden="true"/>
                            </span>) : null}
                        </>);
                    }}
                    </react_2.Listbox.Option>); })}
                </react_2.Listbox.Options>
              </react_2.Transition>
            </div>
          </>);
        }}
      </react_2.Listbox>
    </div>);
}
exports["default"] = Select;

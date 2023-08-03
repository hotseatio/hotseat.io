"use strict";
exports.__esModule = true;
var React = require("react");
var react_1 = require("react");
var solid_1 = require("@heroicons/react/20/solid");
function CopyToClipboardInput(_a) {
    var value = _a.value, name = _a.name, id = _a.id;
    var _b = (0, react_1.useState)(false), wasRecentlyCopied = _b[0], setWasRecentlyCopied = _b[1];
    var onClick = function () {
        navigator.clipboard.writeText(value);
        setWasRecentlyCopied(true);
        setTimeout(function () { return setWasRecentlyCopied(false); }, 2000);
    };
    return (<div className="mt-1 flex rounded-md shadow-sm">
      <input className="base-input block w-full rounded-none rounded-l-md" disabled={true} type="text" value={value} name={name} id={id}/>
      <button type="button" className="inline-button rounded-r-md" onClick={onClick}>
        <span>{wasRecentlyCopied ? 'Copied!' : 'Copy'}</span>
        <solid_1.ClipboardIcon className="h-5 w-5 text-gray-400" aria-hidden="true"/>
      </button>
    </div>);
}
exports["default"] = CopyToClipboardInput;

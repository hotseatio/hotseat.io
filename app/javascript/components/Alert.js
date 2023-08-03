"use strict";
exports.__esModule = true;
var React = require("react");
var solid_1 = require("@heroicons/react/20/solid");
var clsx_1 = require("clsx");
function getColors(type) {
    switch (type) {
        case 'error':
            return { bg: 'bg-red-50', icon: 'text-red-400', headerText: 'text-red-800', bodyText: 'text-red-700' };
        case 'warn':
            return { bg: 'bg-yellow-50', icon: 'text-yellow-400', headerText: 'text-yellow-800', bodyText: 'text-yellow-700' };
        case 'success':
            return { bg: 'bg-green-50', icon: 'text-green-400', headerText: 'text-green-800', bodyText: 'text-green-700' };
        case 'info':
        default:
            return { bg: 'bg-blue-50', icon: 'text-blue-400', headerText: 'text-blue-800', bodyText: 'text-blue-700' };
    }
}
function getIcon(type) {
    switch (type) {
        case 'error':
            return solid_1.XCircleIcon;
        case 'warn':
            return solid_1.ExclamationTriangleIcon;
        case 'success':
            return solid_1.CheckCircleIcon;
        case 'info':
        default:
            return solid_1.InformationCircleIcon;
    }
}
function Alert(_a) {
    var type = _a.type, title = _a.title, children = _a.children;
    var colors = getColors(type);
    var Icon = getIcon(type);
    return (<div className={(0, clsx_1.clsx)(colors.bg, 'rounded-md p-4 my-2')}>
      <div className="flex">
        <div className="flex-shrink-0">
          <Icon className={(0, clsx_1.clsx)(colors.icon, 'h-5 w-5')} aria-hidden="true"/>
        </div>
        <div className="ml-3">
          <h3 className={(0, clsx_1.clsx)(colors.headerText, 'text-sm font-medium')}>{title}</h3>
          {!!children && <div className={(0, clsx_1.clsx)(colors.bodyText, 'mt-2 text-sm')}>{children}</div>}
        </div>
      </div>
    </div>);
}
exports["default"] = Alert;

"use strict";
exports.__esModule = true;
exports.ReviewButton = exports.RegistrarButton = exports.DetailsButton = void 0;
var React = require("react");
var outline_1 = require("@heroicons/react/24/outline");
function DetailsButton(_a) {
    var link = _a.link;
    return (<a title="Details" href={link} className="button-secondary">
      <outline_1.InformationCircleIcon className="h-5 w-5"/>
    </a>);
}
exports.DetailsButton = DetailsButton;
function RegistrarButton(_a) {
    var link = _a.link;
    return (<a title="UCLA Registrar" href={link} rel="noopener noreferrer" target="_blank" className="button-secondary">
      <outline_1.InformationCircleIcon className="h-5 w-5"/>
    </a>);
}
exports.RegistrarButton = RegistrarButton;
function ReviewButton(_a) {
    var sectionId = _a.sectionId;
    return (<a href={"/reviews/new?section=".concat(sectionId)} className="button-primary">
      Review
    </a>);
}
exports.ReviewButton = ReviewButton;

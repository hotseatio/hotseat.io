"use strict";
exports.__esModule = true;
require("@hotwired/turbo-rails");
var React = require("react");
var client_1 = require("react-dom/client");
var ahoy_js_1 = require("ahoy.js");
var Search_1 = require("components/Search");
var EnrollmentCard_1 = require("components/EnrollmentCard");
var GradeCard_1 = require("components/GradeCard");
var ReviewForm_1 = require("components/ReviewForm");
var SettingsForm_1 = require("components/SettingsForm");
var FilterButton_1 = require("components/FilterButton");
var ListCard_1 = require("components/ListCard");
var webpushNotifications_1 = require("utilities/webpushNotifications");
var components = {
    Search: Search_1["default"],
    EnrollmentCard: EnrollmentCard_1["default"],
    GradeCard: GradeCard_1["default"],
    ReviewForm: ReviewForm_1["default"],
    SettingsForm: SettingsForm_1["default"],
    FilterButton: FilterButton_1["default"],
    SectionListCard: ListCard_1.SectionListCard,
    CurrentCoursesListCard: ListCard_1.CurrentCoursesListCard,
    PreviousCoursesListCard: ListCard_1.PreviousCoursesListCard
};
document.addEventListener('turbo:load', function () {
    for (var _i = 0, _a = Object.entries(components); _i < _a.length; _i++) {
        var _b = _a[_i], name_1 = _b[0], Component = _b[1];
        if (document.getElementById(name_1)) {
            var container = document.getElementById(name_1);
            var root = (0, client_1.createRoot)(container);
            var rawProps = container.getAttribute('data-react-props');
            var props = JSON.parse(rawProps);
            root.render(<Component {...props}/>);
        }
    }
    // Service worker
    (0, webpushNotifications_1.registerServiceWorker)();
});
// Ahoy
ahoy_js_1["default"].configure({
    visitsUrl: '/hotcount/visits',
    eventsUrl: '/hotcount/events'
});
ahoy_js_1["default"].trackView();
ahoy_js_1["default"].trackClicks('a, button, input[type=submit]');
ahoy_js_1["default"].trackSubmits('form');

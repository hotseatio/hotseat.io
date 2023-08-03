"use strict";
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
var outline_1 = require("@heroicons/react/24/outline");
var CourseRow_1 = require("./CourseRow");
var Buttons_1 = require("./Buttons");
var context_1 = require("./context");
var GetTokensButton_1 = require("components/GetTokensButton");
var Card_1 = require("components/Card");
function CourseList(_a) {
    var initialSections = _a.sections;
    var _b = (0, react_1.useState)(initialSections), sections = _b[0], setSections = _b[1];
    var onFollowToggle = function (sectionIndex) {
        sections[sectionIndex].isFollowed = !sections[sectionIndex].isFollowed;
        if (sections[sectionIndex].isFollowed === false) {
            // Remove section when it is no longer followed
            setSections(sections.filter(function (_, i) { return i !== sectionIndex; }));
        }
        else {
            setSections(__spreadArray([], sections, true));
        }
    };
    var onSubscribeToggle = function (sectionIndex) {
        sections[sectionIndex].isSubscribed = !sections[sectionIndex].isSubscribed;
        setSections(__spreadArray([], sections, true));
    };
    return (<ul className="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
      {sections.map(function (section) {
            var actionButtons = (<>
            <Buttons_1.DetailsButton link={section.detailsLink}/>
            <Buttons_1.FollowButton isFollowed={section.isFollowed} sectionId={section.id} onClick={function () { return onFollowToggle(section.id); }}/>
            <Buttons_1.SubscribeButton isSubscribed={section.isSubscribed} sectionId={section.id} onClick={function () { return onSubscribeToggle(section.id); }}/>
          </>);
            return <CourseRow_1["default"] key={section.id} section={section} actionButtons={actionButtons}/>;
        })}
    </ul>);
}
function EmptyState(_a) {
    var subjectAreas = _a.subjectAreas;
    return (<div className="text-center p-12">
      <outline_1.AcademicCapIcon className="mx-auto h-12 w-12 text-gray-400 dark:text-gray-500"/>
      <h3 className="mt-2 text-sm font-medium text-gray-900 dark:text-white">No courses</h3>
      <p className="mt-1 text-sm text-gray-400 mb-4 dark:text-gray-500">
        Add courses by searching for them above or by picking a subject.
      </p>
      <ul className="grid gap-y-2 gap-x-4 grid-cols-2 md:grid-cols-3">
        {subjectAreas.map(function (subjectArea) { return (<a href={subjectArea.linkUrl} key={subjectArea.id} className="cursor-pointer">
            <li className="inline-flex items-center px-3 py-0.5 rounded-lg text-sm font-medium bg-red-100 text-red-800 hover:bg-red-200">
              {subjectArea.name}
            </li>
          </a>); })}
      </ul>
    </div>);
}
function CurrentCoursesListCard(_a) {
    var isBetaTester = _a.isBetaTester, sections = _a.sections, notificationTokenCount = _a.notificationTokenCount, subjectAreas = _a.subjectAreas;
    var rightContent = (<div className="flex items-center">
      <p className="hidden sm:inline-block text-sm text-gray-500 dark:text-gray-400 pr-2">{"Notification tokens: ".concat(notificationTokenCount)}</p>
      <GetTokensButton_1.GetMoreTokensButton />
    </div>);
    return (<context_1.IsBetaTesterContext.Provider value={isBetaTester}>
      <Card_1.Card id="current-courses" title="Current Courses" rightContent={rightContent}>
        {sections.length > 0 ? <CourseList sections={sections}/> : <EmptyState subjectAreas={subjectAreas}/>}
      </Card_1.Card>
    </context_1.IsBetaTesterContext.Provider>);
}
exports["default"] = CurrentCoursesListCard;

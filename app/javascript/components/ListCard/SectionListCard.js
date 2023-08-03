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
var SectionRow_1 = require("./SectionRow");
var context_1 = require("./context");
var Buttons_1 = require("./Buttons");
var Card_1 = require("components/Card");
var constructActionButtons = function (enrollmentPeriod, section, sectionIndex, callbacks) {
    var actionButtons = null;
    if (enrollmentPeriod === 'post') {
        var reviewButton = section.isReviewed ? (<div className="flex items-center text-gray-500 dark:text-gray-400 text-sm">
        Reviewed <outline_1.CheckIcon className="h-5 w-5 ml-1 text-gray-400 dark:text-gray-500"/>
      </div>) : (<Buttons_1.ReviewButton sectionId={section.id}/>);
        actionButtons = (<>
        <Buttons_1.RegistrarButton link={section.detailsLink}/>
        {reviewButton}
      </>);
    }
    else if (enrollmentPeriod === 'current') {
        actionButtons = (<>
        <Buttons_1.RegistrarButton link={section.detailsLink}/>
        <Buttons_1.FollowButton isFollowed={section.isFollowed} sectionId={section.id} onClick={function () { return callbacks.onFollowToggle(sectionIndex); }}/>
        <Buttons_1.SubscribeButton isSubscribed={section.isSubscribed} sectionId={section.id} onClick={function () { return callbacks.onSubscribeToggle(sectionIndex); }}/>
      </>);
    }
    return actionButtons;
};
function SectionListCard(_a) {
    var isBetaTester = _a.isBetaTester, initialSectionsByTerm = _a.sectionsByTerm;
    var _b = (0, react_1.useState)(initialSectionsByTerm), sectionsByTerm = _b[0], setSectionsByTerm = _b[1];
    var _c = (0, react_1.useState)(0), selectedTermIndex = _c[0], setSelectedTermIndex = _c[1];
    var terms = (0, react_1.useMemo)(function () { return sectionsByTerm.map(function (_a) {
        var term = _a[0];
        return term;
    }); }, [sectionsByTerm]);
    var _d = sectionsByTerm[selectedTermIndex][1], enrollmentPeriod = _d.enrollmentPeriod, sections = _d.sections;
    var onFollowToggle = function (sectionIndex) {
        sections[sectionIndex].isFollowed = !sections[sectionIndex].isFollowed;
        setSectionsByTerm(__spreadArray([], sectionsByTerm, true));
    };
    var onSubscribeToggle = function (sectionIndex) {
        sections[sectionIndex].isSubscribed = !sections[sectionIndex].isSubscribed;
        setSectionsByTerm(__spreadArray([], sectionsByTerm, true));
    };
    return (<context_1.IsBetaTesterContext.Provider value={isBetaTester}>
      <Card_1.TermSelectCard id="sections" title="Section List" onTermSelect={setSelectedTermIndex} terms={terms}>
        <ul className="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
          {sections.map(function (section, sectionIndex) {
            var actionButtons = constructActionButtons(enrollmentPeriod, section, sectionIndex, {
                onFollowToggle: onFollowToggle,
                onSubscribeToggle: onSubscribeToggle
            });
            return <SectionRow_1["default"] key={section.id} section={section} actionButtons={actionButtons}/>;
        })}
        </ul>
      </Card_1.TermSelectCard>
    </context_1.IsBetaTesterContext.Provider>);
}
exports["default"] = SectionListCard;

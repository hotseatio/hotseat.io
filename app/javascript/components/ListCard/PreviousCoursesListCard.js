"use strict";
exports.__esModule = true;
var React = require("react");
var outline_1 = require("@heroicons/react/24/outline");
var CourseRow_1 = require("./CourseRow");
var Buttons_1 = require("./Buttons");
var context_1 = require("./context");
var Card_1 = require("components/Card");
function PreviousCoursesListCard(_a) {
    var isBetaTester = _a.isBetaTester, sections = _a.sections;
    return (<context_1.IsBetaTesterContext.Provider value={isBetaTester}>
      <Card_1.Card id="previous-courses" title="Previous Courses">
        <ul className="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
          {sections.map(function (section) {
            var reviewButton = section.isReviewed ? (<div className="flex items-center text-gray-500 dark:text-gray-400 text-sm">
                Reviewed <outline_1.CheckIcon className="h-5 w-5 ml-1 text-gray-400 dark:text-gray-500"/>
              </div>) : (<Buttons_1.ReviewButton sectionId={section.id}/>);
            var actionButtons = (<>
                <Buttons_1.DetailsButton link={section.detailsLink}/>
                {reviewButton}
              </>);
            return <CourseRow_1["default"] key={section.id} section={section} actionButtons={actionButtons}/>;
        })}
        </ul>
      </Card_1.Card>
    </context_1.IsBetaTesterContext.Provider>);
}
exports["default"] = PreviousCoursesListCard;

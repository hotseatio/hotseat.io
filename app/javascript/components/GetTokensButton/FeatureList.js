"use strict";
exports.__esModule = true;
exports.PrimaryFeatureList = exports.SecondaryFeatureList = void 0;
var React = require("react");
var outline_1 = require("@heroicons/react/24/outline");
function SecondaryFeatureList(_a) {
    var features = _a.features, ctaLabel = _a.ctaLabel, ctaLink = _a.ctaLink;
    return (<div className="flex-1 flex flex-col justify-between border-t-2 border-gray-100 dark:border-gray-800 p-6 bg-gray-50 dark:bg-gray-800 sm:px-5 sm:py-6">
      <ul role="list" className="space-y-4">
        {features.map(function (feature) { return (<li key={feature} className="flex items-start">
            <div className="flex-shrink-0">
              <outline_1.CheckIcon className="flex-shrink-0 h-6 w-6 text-red-500" aria-hidden="true"/>
            </div>
            <p className="ml-3 text-base font-medium text-gray-500 dark:text-gray-400">{feature}</p>
          </li>); })}
      </ul>
      <div className="mt-8">
        <div className="rounded-lg shadow-md">
          <a href={ctaLink} className="block w-full text-center rounded-lg border border-transparent bg-white dark:bg-gray-900 px-6 py-3 text-base font-medium text-red-600 hover:bg-gray-50 dark:hover:bg-black focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500" 
    // We need this here for the Stripe checkout redirect to work properly
    // https://github.com/hotwired/turbo/issues/211#issuecomment-966570923
    data-turbo="false">
            {ctaLabel}
          </a>
        </div>
      </div>
    </div>);
}
exports.SecondaryFeatureList = SecondaryFeatureList;
function PrimaryFeatureList(_a) {
    var features = _a.features, ctaLabel = _a.ctaLabel, ctaLink = _a.ctaLink;
    return (<div className="border-t-2 border-gray-100 dark:border-gray-800 rounded-b-lg pt-10 pb-8 px-6 bg-gray-50 dark:bg-gray-800 sm:p-8">
      <ul role="list" className="space-y-4">
        {features.map(function (feature) { return (<li key={feature} className="flex items-start">
            <div className="flex-shrink-0">
              <outline_1.CheckIcon className="flex-shrink-0 h-6 w-6 text-red-500" aria-hidden="true"/>
            </div>
            <p className="ml-3 text-base font-medium text-gray-500 dark:text-gray-400">{feature}</p>
          </li>); })}
      </ul>
      <div className="mt-10 sm:mt-24">
        <div className="rounded-lg shadow-md">
          <a href={ctaLink} className="block w-full text-center rounded-lg border border-transparent bg-red-600 px-6 py-4 text-xl leading-6 font-medium text-white hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
            {ctaLabel}
          </a>
        </div>
      </div>
    </div>);
}
exports.PrimaryFeatureList = PrimaryFeatureList;

"use strict";
exports.__esModule = true;
var React = require("react");
var react_1 = require("react");
var react_2 = require("@headlessui/react");
var CloseButton_1 = require("./CloseButton");
var FeatureList_1 = require("./FeatureList");
var referFeatures = ['Earn a token for each user who signs up and writes a review!'];
var reviewFeatures = [
    'Earn 1 token for every course you review.',
    'Helps out other Hotseat users find the best classes!',
];
var buyFeatures = ['Only $1.25/token.', 'Supports Hotseat development!'];
function GetMoreTokensModal(_a) {
    var open = _a.open, setOpen = _a.setOpen;
    return (<react_2.Transition.Root show={open} as={react_1.Fragment}>
      <react_2.Dialog className="fixed z-10 inset-0 overflow-y-auto" onClose={setOpen}>
        <div className="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block lg:p-0">
          <react_2.Transition.Child as={react_1.Fragment} enter="ease-out duration-300" enterFrom="opacity-0" enterTo="opacity-100" leave="ease-in duration-200" leaveFrom="opacity-100" leaveTo="opacity-0">
            <react_2.Dialog.Overlay className="fixed inset-0 bg-gray-500 dark:bg-gray-400 bg-opacity-75 transition-opacity"/>
          </react_2.Transition.Child>

          {/* This element is to trick the browser into centering the modal contents. */}
          <span className="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">
            &#8203;
          </span>
          <react_2.Transition.Child as={react_1.Fragment} enter="ease-out duration-300" enterFrom="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95" enterTo="opacity-100 translate-y-0 sm:scale-100" leave="ease-in duration-200" leaveFrom="opacity-100 translate-y-0 sm:scale-100" leaveTo="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95">
            <div className="inline-block align-bottom bg-white dark:bg-gray-900 rounded-lg px-4 pt-5 pb-4 text-left overflow-hidden shadow-xl transform transition-all sm:align-middle sm:max-w-4xl sm:w-full sm:p-6">
              <CloseButton_1["default"] onClick={function () { return setOpen(false); }}/>

              <div className="max-w-7xl mx-auto px-4 sm:px-6 h-5/6 lg:h-2/3 mt-8 sm:mt-0">
                <div className="relative lg:grid lg:grid-cols-7">
                  <div className="mx-auto max-w-md lg:mx-0 lg:max-w-none lg:col-start-1 lg:col-end-3 lg:row-start-2 lg:row-end-3">
                    <div className="h-full flex flex-col rounded-lg shadow-lg border border-gray-100 dark:border-gray-800 overflow-hidden lg:rounded-none lg:rounded-l-lg">
                      <div className="flex-1 flex flex-col">
                        <div className="px-6 py-10">
                          <div>
                            <h3 className="text-center text-2xl font-medium text-gray-900 dark:text-white" id="tier-hobby">
                              Refer a friend
                            </h3>
                            <div className="mt-4 flex items-center justify-center">
                              <span className="px-3 flex items-start text-4xl tracking-tight font-extrabold text-gray-900 dark:text-white sm:text-4xl">
                                Free
                              </span>
                            </div>
                          </div>
                        </div>
                        <FeatureList_1.SecondaryFeatureList features={referFeatures} ctaLabel="Get referral link" ctaLink="/settings"/>
                      </div>
                    </div>
                  </div>
                  <div className="mt-10 max-w-lg mx-auto lg:mt-0 lg:max-w-none lg:mx-0 lg:col-start-3 lg:col-end-6 lg:row-start-1 lg:row-end-4">
                    <div className="relative z-10 rounded-lg shadow-xl">
                      <div className="pointer-events-none absolute inset-0 rounded-lg border-2 border-red-600" aria-hidden="true"/>
                      <div className="absolute inset-x-0 top-0 transform translate-y-px">
                        <div className="flex justify-center transform -translate-y-1/2">
                          <span className="inline-flex rounded-full bg-red-600 px-4 py-1 text-sm font-semibold tracking-wider uppercase text-white">
                            Most popular
                          </span>
                        </div>
                      </div>
                      <div className="rounded-t-lg px-6 pt-12 pb-10">
                        <div>
                          <h3 className="text-center text-3xl font-semibold text-gray-900 dark:text-white sm:-mx-6">
                            Review a class
                          </h3>
                          <div className="mt-4 flex items-center justify-center">
                            <span className="px-3 flex items-start text-4xl tracking-tight font-extrabold text-gray-900 dark:text-white sm:text-4xl">
                              Free
                            </span>
                          </div>
                        </div>
                      </div>
                      <FeatureList_1.PrimaryFeatureList features={reviewFeatures} ctaLabel="Review" ctaLink="/reviews/new"/>
                    </div>
                  </div>
                  <div className="mt-10 mx-auto max-w-md lg:m-0 lg:max-w-none lg:col-start-6 lg:col-end-8 lg:row-start-2 lg:row-end-3">
                    <div className="h-full flex flex-col rounded-lg border border-gray-100 dark:border-gray-800 shadow-lg overflow-hidden lg:rounded-none lg:rounded-r-lg">
                      <div className="flex-1 flex flex-col">
                        <div className="px-6 py-10">
                          <div>
                            <h3 className="text-center text-2xl font-medium text-gray-900 dark:text-white">
                              Buy tokens
                            </h3>
                            <div className="mt-4 flex items-center justify-center">
                              <span className="px-3 flex items-start text-5xl tracking-tight text-gray-900 dark:text-white">
                                <span className="mt-2 mr-2 text-2xl font-medium">$</span>
                                <span className="font-extrabold">5</span>
                              </span>
                              <span className="text-lg font-medium text-gray-500 dark:text-gray-400">for 4 tokens</span>
                            </div>
                          </div>
                        </div>
                        <FeatureList_1.SecondaryFeatureList features={buyFeatures} ctaLabel="Buy now" ctaLink="/checkout"/>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </react_2.Transition.Child>
        </div>
      </react_2.Dialog>
    </react_2.Transition.Root>);
}
exports["default"] = GetMoreTokensModal;

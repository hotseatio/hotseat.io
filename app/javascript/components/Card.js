"use strict";
exports.__esModule = true;
exports.TermSelectCard = exports.Card = void 0;
var React = require("react");
var react_1 = require("react");
var clsx_1 = require("clsx");
var Select_1 = require("components/Select");
/**
 * A display card. The React equivalent of shared/_card.html.erb.
 */
function Card(_a) {
    var id = _a.id, children = _a.children, title = _a.title, rightContent = _a.rightContent;
    if (Array.isArray(rightContent)) {
        rightContent = React.Children.map(rightContent, function (item, i) { return (<div className={(0, clsx_1.clsx)(i === 0 && 'ml-auto', 'flex-shrink-0')} role="presentation">
        {item}
      </div>); });
    }
    else {
        if (typeof rightContent === 'string' || typeof rightContent === 'number') {
            rightContent = <p className="text-sm text-gray-500 dark:text-gray-400">{rightContent}</p>;
        }
        rightContent = (<div className="ml-auto flex-shrink-0" role="presentation">
        {rightContent}
      </div>);
    }
    var titleID = id + '-title';
    return (<section id={id} aria-labelledby={titleID} className="bg-white dark:bg-gray-900 shadow rounded-lg my-4">
      <header className="px-4 py-5 border-b border-gray-200 dark:border-gray-700 sm:px-6 flex items-center justify-between flex-wrap sm:flex-nowrap gap-2">
        <h3 id={titleID}>{title}</h3>
        {rightContent}
      </header>
      {children}
    </section>);
}
exports.Card = Card;
/**
 * A display card with a selectable term.
 */
function TermSelectCard(_a) {
    var id = _a.id, title = _a.title, children = _a.children, onTermSelect = _a.onTermSelect, terms = _a.terms;
    var _b = (0, react_1.useState)(0), selectedTermIndex = _b[0], setSelectedTermIndex = _b[1];
    var termItems = (0, react_1.useMemo)(function () { return terms.map(function (term) { return ({ id: term, label: term }); }); }, [terms]);
    var onSelect = function (_selected, i) {
        setSelectedTermIndex(i);
        onTermSelect(i);
    };
    var SelectNode = (<Select_1["default"] label="Select a term:" labelInvisible className="w-24" onSelect={onSelect} items={termItems} value={selectedTermIndex}/>);
    return (<Card id={id} title={title} rightContent={SelectNode}>
      {children}
    </Card>);
}
exports.TermSelectCard = TermSelectCard;

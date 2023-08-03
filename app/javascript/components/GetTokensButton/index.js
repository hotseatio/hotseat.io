"use strict";
exports.__esModule = true;
exports.GetMoreTokensButton = void 0;
var React = require("react");
var react_1 = require("react");
var GetMoreTokensModal_1 = require("./GetMoreTokensModal");
function GetMoreTokensButton() {
    var _a = (0, react_1.useState)(false), isModalOpen = _a[0], setIsModalOpen = _a[1];
    var onOpenModal = function () {
        setIsModalOpen(true);
    };
    return (<>
      <button className="button-primary" onClick={onOpenModal}>
        Get tokens
      </button>
      <GetMoreTokensModal_1["default"] open={isModalOpen} setOpen={setIsModalOpen}/>
    </>);
}
exports.GetMoreTokensButton = GetMoreTokensButton;

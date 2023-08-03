"use strict";
var __rest = (this && this.__rest) || function (s, e) {
    var t = {};
    for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
        t[p] = s[p];
    if (s != null && typeof Object.getOwnPropertySymbols === "function")
        for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
            if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                t[p[i]] = s[p[i]];
        }
    return t;
};
exports.__esModule = true;
exports.SubscribeButton = exports.FollowButton = void 0;
var React = require("react");
var react_1 = require("react");
var solid_1 = require("@heroicons/react/20/solid");
var outline_1 = require("@heroicons/react/24/outline");
var RequestButton_1 = require("components/RequestButton");
var ConfirmModal_1 = require("components/ConfirmModal");
var GetMoreTokensModal_1 = require("components/GetTokensButton/GetMoreTokensModal");
function FollowButton(_a) {
    var isFollowed = _a.isFollowed, props = __rest(_a, ["isFollowed"]);
    return isFollowed ? <ToggledFollowButton {...props}/> : <UntoggledFollowButton {...props}/>;
}
exports.FollowButton = FollowButton;
function SubscribeButton(_a) {
    var isSubscribed = _a.isSubscribed, props = __rest(_a, ["isSubscribed"]);
    return isSubscribed ? <ToggledSubscribeButton {...props}/> : <UntoggledSubscribeButton {...props}/>;
}
exports.SubscribeButton = SubscribeButton;
function UntoggledFollowButton(_a) {
    var sectionId = _a.sectionId, onClick = _a.onClick;
    return (<RequestButton_1["default"] title="Add to my courses" className="button-secondary" resource="/relationships" method="POST" body={{ section_id: sectionId, subscribe: false }} onClick={onClick}>
      <outline_1.StarIcon className="h-5 w-5"/>
    </RequestButton_1["default"]>);
}
function ToggledFollowButton(_a) {
    var sectionId = _a.sectionId, onClick = _a.onClick;
    return (<RequestButton_1["default"] title="Remove from my courses" className="button-secondary" resource={"/relationships/".concat(sectionId)} method="DELETE" body={{ section_id: sectionId, subscription_only: false }} onClick={onClick}>
      <solid_1.StarIcon className="h-5 w-5"/>
    </RequestButton_1["default"]>);
}
function UntoggledSubscribeButton(_a) {
    var sectionId = _a.sectionId, onClick = _a.onClick;
    var _b = (0, react_1.useState)(false), isModalOpen = _b[0], setIsModalOpen = _b[1];
    var _c = (0, react_1.useState)(0), notificationTokens = _c[0], setNotificationTokens = _c[1];
    var _d = (0, react_1.useState)(null), phone = _d[0], setPhone = _d[1];
    var onOpenModal = function (payload) {
        setNotificationTokens(payload.notificationTokens);
        setPhone(payload.phone);
        setIsModalOpen(true);
    };
    var onConfirm = function () {
        setIsModalOpen(false);
        if (onClick)
            onClick();
    };
    var showGetMoreTokensModal = notificationTokens === 0;
    var subscribeDisabled = false;
    var description = null;
    if (phone === null) {
        description = "You don't currently have a phone number set. Go over to Settings to add your number!";
        subscribeDisabled = true;
    }
    else {
        description = "You will receive text message alerts to ".concat(phone, " about enrollment changes to this class. Message and data rates may apply. You may unsubscribe at any time in your settings page. This subscription will use one of your ").concat(notificationTokens, " notification tokens. To obtain more notification tokens, write reviews for classes you've taken.");
    }
    return (<>
      <RequestButton_1["default"] title="Notify me" className="button-primary" resource="/user/details" method="GET" onClick={onOpenModal}>
        <outline_1.BellIcon className="h-5 w-5"/>
      </RequestButton_1["default"]>
      {showGetMoreTokensModal ? (<GetMoreTokensModal_1["default"] open={isModalOpen} setOpen={setIsModalOpen}/>) : (<ConfirmModal_1["default"] title="Confirm subscription" description={description} isOpen={isModalOpen} Icon={outline_1.BellIcon} onConfirm={onConfirm} onCancel={function () { return setIsModalOpen(false); }} confirmDisabled={subscribeDisabled} confirmLabel="Subscribe" confirmRequest={{
                method: 'POST',
                resource: '/relationships',
                body: { section_id: sectionId, subscribe: true }
            }}/>)}
    </>);
}
function ToggledSubscribeButton(_a) {
    var sectionId = _a.sectionId, onClick = _a.onClick;
    var _b = (0, react_1.useState)(false), isModalOpen = _b[0], setIsModalOpen = _b[1];
    var onConfirm = function () {
        setIsModalOpen(false);
        if (onClick)
            onClick();
    };
    return (<>
      <button title="Don't notify me" className="button-primary" onClick={function () { return setIsModalOpen(true); }}>
        <solid_1.BellIcon className="h-5 w-5"/>
      </button>
      <ConfirmModal_1["default"] title="Confirm unsubscribe" isOpen={isModalOpen} Icon={outline_1.BellIcon} onConfirm={onConfirm} onCancel={function () { return setIsModalOpen(false); }} confirmLabel="Unsubscribe" confirmRequest={{
            method: 'DELETE',
            resource: "/relationships/".concat(sectionId),
            body: { section_id: sectionId, subscription_only: true }
        }}/>
    </>);
}

"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
exports.__esModule = true;
exports.ReviewButton = exports.RegistrarButton = exports.DetailsButton = exports.SubscribeButton = exports.FollowButton = void 0;
var RelationshipButtons_1 = require("./RelationshipButtons");
__createBinding(exports, RelationshipButtons_1, "FollowButton");
__createBinding(exports, RelationshipButtons_1, "SubscribeButton");
var LinkButtons_1 = require("./LinkButtons");
__createBinding(exports, LinkButtons_1, "DetailsButton");
__createBinding(exports, LinkButtons_1, "RegistrarButton");
__createBinding(exports, LinkButtons_1, "ReviewButton");

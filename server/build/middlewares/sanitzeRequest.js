"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const sanitize_html_1 = __importDefault(require("sanitize-html"));
// Blacklist array: These are fields we do not want to sanitize
const blacklist = ["password", "confirm_password", "terms"];
// define sanitization parameters
const sanitizeOptions = {
    allowedTags: [],
    allowedAttribures: {}
};
const sanitizeRequest = (req, res, next) => {
    var _a;
    if (req.body) {
        const response = { timestamp: Date.now(), message: 'Sanitization Error', code: 400, errors: [] };
        // Loop through each of the fields in the request
        Object.keys(req.body).forEach(field => {
            var _a;
            if (!blacklist.includes(field)) {
                const clean = (0, sanitize_html_1.default)(req.body[field], sanitizeOptions);
                if (clean !== req.body[field]) {
                    (_a = response.errors) === null || _a === void 0 ? void 0 : _a.push({ field, message: `${field} has an illegal/invalid character(s)`, code: 'santize_error', });
                }
            }
        });
        // If there were any santize errors return response
        if (((_a = response.errors) === null || _a === void 0 ? void 0 : _a.length) !== 0) {
            res.status(400).json(response);
            return;
        }
    }
    next();
};
exports.default = sanitizeRequest;

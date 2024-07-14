"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const RequestPasswordReset_1 = require("../../schemas/auth/RequestPasswordReset");
const zod_1 = require("zod");
const User_1 = require("../../model/User");
const sendPasswordResetEmail_1 = __importDefault(require("../../services/auth/sendPasswordResetEmail"));
const requestPasswordResetController = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        // Use the requestPasswordReset zod schema to validate email input
        const { email } = RequestPasswordReset_1.RequestPasswordReset.parse(req.body);
        // Verify the email sent is linked to a valid account
        const user = yield User_1.User.findOne({ email });
        if (!user) {
            const response = {
                timestamp: Date.now(),
                message: 'If the email address is associated with a valid account a reset link is on the way',
                code: 200
            };
            res.status(response.code).json(response);
            return;
        }
        // Send a reset password email
        yield (0, sendPasswordResetEmail_1.default)(user);
        // Send a success response
        const response = {
            timestamp: Date.now(),
            message: 'If the email address is associated with a valid account a reset link is on the way',
            code: 200
        };
        res.status(response.code).json(response);
        return;
    }
    catch (error) {
        console.log(error);
        if (error instanceof zod_1.ZodError) {
            const response = {
                timestamp: Date.now(),
                message: 'Validation Error',
                code: 400,
                errors: error.errors.map(err => ({ field: err.path.join('.'), message: err.message, code: err.code }))
            };
            res.status(response.code).json(response);
            return;
        }
        // Return generic server error
        const response = {
            timestamp: Date.now(),
            message: 'Internal Server Error',
            code: 500
        };
        res.status(response.code).json(response);
        return;
    }
});
exports.default = requestPasswordResetController;

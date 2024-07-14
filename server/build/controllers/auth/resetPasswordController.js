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
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const argon2 = __importStar(require("argon2"));
const zod_1 = require("zod");
const ResetPassword_1 = require("../../schemas/auth/ResetPassword");
const jsonwebtoken_1 = __importStar(require("jsonwebtoken"));
const User_1 = require("../../model/User");
const resetPasswordController = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        // Validate the user entered a new strong password using the ResetPassword zod schema
        const { password, confirm_password } = ResetPassword_1.ResetPassword.parse(req.body);
        // Get the reset token
        const token = req.params.token;
        const JWT_SECRET = process.env.JWT_SECRET || '';
        // Validate the reset token
        const decoded = jsonwebtoken_1.default.verify(token, JWT_SECRET);
        // Find the user's record 
        const user = yield User_1.User.findById(decoded.userId);
        if (!user) {
            const response = {
                timestamp: Date.now(),
                message: 'User Not Found',
                code: 404
            };
            res.status(response.code).json(response);
            return;
        }
        // Hash the user's new password
        const hash = yield argon2.hash(password);
        // Update the password in the user's document
        user.password = hash;
        yield user.save();
        // Send a success response
        const response = {
            timestamp: Date.now(),
            message: 'Password Reset Successfully',
            code: 200
        };
        res.status(response.code).json(response);
        return;
    }
    catch (error) {
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
        if (error instanceof jsonwebtoken_1.JsonWebTokenError) {
            const response = {
                timestamp: Date.now(),
                message: 'Invalid or expired token',
                code: 401
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
exports.default = resetPasswordController;

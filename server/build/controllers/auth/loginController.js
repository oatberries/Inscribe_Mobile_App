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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const LoginFields_1 = require("../../schemas/auth/LoginFields");
const zod_1 = require("zod");
const User_1 = require("../../model/User");
const argon2 = __importStar(require("argon2"));
const generateSessionToken_1 = __importDefault(require("../../utils/generateSessionToken"));
const loginController = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        // Validate the login feilds using the Zod Schema
        const { username, password } = LoginFields_1.LoginFields.parse(req.body);
        // Attempt to find the user's document
        const user = yield User_1.User.findOne({ username });
        if (!user) {
            const response = {
                timestamp: Date.now(),
                message: 'Invalid username or password',
                code: 401
            };
            res.status(response.code).json(response);
            return;
        }
        // Check if the user if verified
        if (!user.verifed) {
            const response = {
                timestamp: Date.now(),
                message: 'Account is not verifed',
                code: 401
            };
            res.status(response.code).json(response);
            return;
        }
        // Check to see if the user's account is locked
        if (user.locked) {
            const response = {
                timestamp: Date.now(),
                message: 'Account is locked',
                code: 403
            };
            res.status(response.code).json(response);
            return;
        }
        // Compare the passwords to see if they match
        const passwordsMatch = yield argon2.verify(user.password, password);
        if (!passwordsMatch) {
            // Increment the login attempts by 1
            user.login_attempts++;
            if (user.login_attempts >= 5) {
                user.locked = true;
            }
            yield user.save();
            const response = {
                timestamp: Date.now(),
                message: 'Invalid username or password',
                code: 401
            };
            res.status(response.code).json(response);
            return;
        }
        // Generate a user session token
        const token = (0, generateSessionToken_1.default)(user);
        // Reset the login attempts to zero and update the login date
        user.login_attempts = 0;
        user.last_login = new Date();
        yield user.save();
        // Send the token to the user
        const response = {
            timestamp: Date.now(),
            message: 'Login Successful',
            code: 200,
            token
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
exports.default = loginController;

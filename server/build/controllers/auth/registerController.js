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
const argon2 = __importStar(require("argon2"));
const zod_1 = require("zod");
const RegisterFields_1 = require("../../schemas/auth/RegisterFields");
const User_1 = require("../../model/User");
const sendVerifyAccountEmail_1 = __importDefault(require("../../services/auth/sendVerifyAccountEmail"));
const registerController = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b;
    try {
        // Use the Zod Schema to validate the register request body
        const { first_name, last_name, username, email, password, confirm_password, terms } = RegisterFields_1.RegisterFields.parse(req.body);
        // Verify the provided email and/or username is not already in use
        const findUser = yield User_1.User.findOne({ $or: [{ email }, { username }] });
        if (findUser) {
            const response = {
                timestamp: Date.now(),
                message: 'Conflict Error',
                code: 409,
                errors: []
            };
            if (findUser.email === email)
                (_a = response.errors) === null || _a === void 0 ? void 0 : _a.push({ field: 'email', message: 'Email is taken', code: 'conflict_error' });
            if (findUser.username === username)
                (_b = response.errors) === null || _b === void 0 ? void 0 : _b.push({ field: 'username', message: 'Username is taken', code: 'conflict_error' });
            res.status(response.code).json(response);
            return;
        }
        // Hash the password
        const hash = yield argon2.hash(password);
        // Create the new user document and save to MongoDB
        const user = new User_1.User({ first_name, last_name, username, email, password: hash, terms_of_services_accepted: terms, terms_of_services_timestamp: Date.now(), terms_of_services_id: parseInt(process.env.TERMS_OF_SERVICE_ID, 10) });
        yield user.save();
        // Send a verify account email
        yield (0, sendVerifyAccountEmail_1.default)(user.id, user.email);
        // Return a success response
        const response = {
            timestamp: Date.now(),
            message: 'User Registered Successfully',
            code: 201
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
        // Return generic Internal server error
        const response = {
            timestamp: Date.now(),
            message: 'Internal Server Error',
            code: 500
        };
        res.status(response.code).json(response);
        return;
    }
});
exports.default = registerController;

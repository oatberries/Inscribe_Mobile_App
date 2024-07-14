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
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const User_1 = require("../../model/User");
const verifyAccountController = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        // Extract the validation token from the req.params
        const token = req.params.token;
        const JWT_SECRET = process.env.JWT_SECRET || '';
        // Validate the token
        const decoded = jsonwebtoken_1.default.verify(token, JWT_SECRET);
        // Find the user's document from the database using id from token
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
        // Check to see if the user is already validated
        if (user.verifed) {
            res.status(200).redirect('/login');
        }
        // Update the user's verified status
        user.verifed = true;
        yield user.save();
        // Redirect to the login page
        return res.status(200).redirect('/login');
    }
    catch (error) {
        // Redirect to error page
        return res.status(500).redirect('/error');
    }
});
exports.default = verifyAccountController;

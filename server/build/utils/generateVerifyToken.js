"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const generateVerifyToken = (userId) => {
    const JWT_SECRET = process.env.JWT_SECRET || '';
    // Create the jwt payload
    const iat = Math.floor(Date.now() / 1000);
    const exp = iat + (15 * 60);
    const payload = { userId, iat, exp, purpose: 'Account Verification' };
    // create the token
    const token = jsonwebtoken_1.default.sign(payload, JWT_SECRET, { algorithm: 'HS256' });
    return token;
};
exports.default = generateVerifyToken;

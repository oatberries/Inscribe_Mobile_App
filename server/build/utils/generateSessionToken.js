"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const generateSessionToken = (user) => {
    const JWT_SECRET = process.env.JWT_SECRET;
    // Create the payload
    const iat = Math.floor(Date.now() / 1000);
    const exp = iat + (60 * 60);
    const payload = {
        userId: user.id,
        iat,
        exp,
        username: user.username,
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name,
        purpose: 'Session Token'
    };
    // Create the session token
    const token = jsonwebtoken_1.default.sign(payload, JWT_SECRET, { algorithm: 'HS256' });
    return token;
};
exports.default = generateSessionToken;

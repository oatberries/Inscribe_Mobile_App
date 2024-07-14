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
const nodemailer_1 = __importDefault(require("nodemailer"));
const generatePasswordResetToken_1 = __importDefault(require("../../utils/generatePasswordResetToken"));
const sendPasswordResetEmail = (userDoc) => __awaiter(void 0, void 0, void 0, function* () {
    // Create a password reset token
    const token = (0, generatePasswordResetToken_1.default)(userDoc.id);
    // Get the node mailer details and credentials
    const host = process.env.NODEMAILER_HOST;
    const port = parseInt(process.env.NODEMAILER_PORT, 10) || 465;
    const user = process.env.NODEMAILER_USER;
    const pass = process.env.NODEMAILER_PASS;
    const base = process.env.BASE_URL || 'http://localhost:5000';
    // Create a nodemailer transporter
    const transporter = nodemailer_1.default.createTransport({
        host,
        port,
        secure: true,
        auth: {
            user,
            pass
        }
    });
    // Create the password reset url
    const url = `${base}/api/auth/redirect-to-password-reset/${token}`;
    // Send password reset email
    const info = yield transporter.sendMail({
        from: user,
        to: userDoc.email,
        subject: 'Reset Your Inscribed Password',
        html: `
            <h1>Reset Your Inscribed Password</h1>
            <p>Click the link to reset your password: <a href=${url}>Reset Password</a></p>
            <p>This link is valid for 15 minutes. If it expires just login and request a new one :)</p>
            <h4>If you did not request this. Please ingnore this email and secure your account.</h4>
        `
    });
});
exports.default = sendPasswordResetEmail;

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
const generateVerifyToken_1 = __importDefault(require("../../utils/generateVerifyToken"));
const nodemailer_1 = __importDefault(require("nodemailer"));
const sendVerifyAccountEmail = (userId, email) => __awaiter(void 0, void 0, void 0, function* () {
    // Create the verification token
    const token = (0, generateVerifyToken_1.default)(userId);
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
    // Create the verify account url
    const url = `${base}/api/auth/verify-account/${token}`;
    // Send verify email
    const info = yield transporter.sendMail({
        from: user,
        to: email,
        subject: 'Verify Your Inscribe Account',
        html: `
            <h1>Verify your Inscribed account</h1>
            <p>Click the link to verify your account: <a href=${url}>Verify</a></p>
            <p>This link is valid for 15 minutes. If it expires just login and request a new one :)</p>
        `
    });
});
exports.default = sendVerifyAccountEmail;

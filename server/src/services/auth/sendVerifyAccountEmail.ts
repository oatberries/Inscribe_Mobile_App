import mongoose from 'mongoose';
import generateVerifyToken from '../../utils/generateVerifyToken';
import nodemailer, { SentMessageInfo, Transporter } from 'nodemailer';
import SMTPTransport from 'nodemailer/lib/smtp-transport';


const sendVerifyAccountEmail = async (userId: mongoose.Types.ObjectId, email: string): Promise<void> => {

    // Create the verification token
    const token: string = generateVerifyToken(userId);

    // Get the node mailer details and credentials
    const host: string = process.env.NODEMAILER_HOST as string;
    const port: number = parseInt(process.env.NODEMAILER_PORT as string, 10) || 465;
    const user: string = process.env.NODEMAILER_USER as string;
    const pass: string = process.env.NODEMAILER_PASS as string;
    const base: string = process.env.BASE_URL || 'http://localhost:5000';

    // Create a nodemailer transporter
    const transporter: Transporter<SMTPTransport.SentMessageInfo> = nodemailer.createTransport({
        host, 
        port, 
        secure: true,
        auth: {
            user,
            pass
        }
    });

    // Create the verify account url
    const url: string = `${base}/api/auth/verify-account/${token}`;

    // Send verify email
    const info: SentMessageInfo = await transporter.sendMail({

        from: user,
        to: email,
        subject: 'Verify Your Inscribe Account',
        html: 
        `
            <h1>Verify your Inscribed account</h1>
            <p>Click the link to verify your account: <a href=${url}>Verify</a></p>
            <p>This link is valid for 15 minutes. If it expires just login and request a new one :)</p>
        `

    });

};

export default sendVerifyAccountEmail;
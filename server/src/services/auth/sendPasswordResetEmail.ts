import nodemailer, { SentMessageInfo, Transporter } from 'nodemailer';
import { UserDocument } from '../../types/models/Users';
import generatePasswordResetToken from '../../utils/generatePasswordResetToken';
import SMTPTransport from 'nodemailer/lib/smtp-transport';


const sendPasswordResetEmail = async (userDoc: UserDocument): Promise<void> => {

    // Create a password reset token
    const token: string = generatePasswordResetToken(userDoc.id);

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

    // Create the password reset url
    const url: string = `${base}/api/auth/redirect-to-password-reset/${token}`;

    // Send password reset email
    const info: SentMessageInfo = await transporter.sendMail({

        from: user,
        to: userDoc.email as string,
        subject: 'Reset Your Inscribed Password',
        html: 
        `
            <h1>Reset Your Inscribed Password</h1>
            <p>Click the link to reset your password: <a href=${url}>Reset Password</a></p>
            <p>This link is valid for 15 minutes. If it expires just login and request a new one :)</p>
            <h4>If you did not request this. Please ingnore this email and secure your account.</h4>
        `

    });



};

export default sendPasswordResetEmail;
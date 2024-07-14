import mongoose from 'mongoose';
import { ResetToken } from '../types/tokens/ResetToken';
import jwt from 'jsonwebtoken';


const generatePasswordResetToken = (userId: mongoose.Types.ObjectId): string => {

    const JWT_SECRET: string = process.env.JWT_SECRET as string;

    // Create the password reset token payload
    const iat: number = Math.floor(Date.now() / 1000);
    const exp: number = iat + (15 * 60);

    const payload: ResetToken = {
        userId,
        iat,
        exp,
        purpose: 'Password Reset'
    };

    // Create the reset token
    const token: string = jwt.sign(payload, JWT_SECRET, { algorithm: 'HS256' });

    return token;

};

export default generatePasswordResetToken;
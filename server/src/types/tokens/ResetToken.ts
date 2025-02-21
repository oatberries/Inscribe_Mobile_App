import { JwtPayload } from 'jsonwebtoken';
import mongoose from 'mongoose';

export interface ResetToken extends JwtPayload {

    userId: mongoose.Types.ObjectId,
    iat: number,
    exp: number,
    purpose: string

};
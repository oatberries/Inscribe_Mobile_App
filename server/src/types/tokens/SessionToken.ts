import { JwtPayload } from 'jsonwebtoken';
import mongoose from 'mongoose';

export interface SessionToken extends JwtPayload {

    userId: mongoose.Types.ObjectId,
    iat: number,
    exp: number,
    username: string,
    email: string,
    first_name: string,
    last_name: string,
    purpose: string

};
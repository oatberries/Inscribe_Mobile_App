import mongoose from 'mongoose';
import { UserDocument } from '../types/models/Users';
import jwt from 'jsonwebtoken';
import { SessionToken } from '../types/tokens/SessionToken';

const generateSessionToken = (user: UserDocument) : string => {

    const JWT_SECRET: string = process.env.JWT_SECRET as string;

    // Create the payload
    const iat: number = Math.floor(Date.now() / 1000);
    const exp: number = iat + (60 * 60);

    const payload: SessionToken = {
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
    const token: string = jwt.sign(payload, JWT_SECRET, { algorithm: 'HS256' });

    return token;

};

export default generateSessionToken;
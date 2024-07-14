import mongoose from 'mongoose';
import { number } from 'zod';
import { DecodedValidationToken } from '../types/tokens/DecodedValidationToken';
import jwt from 'jsonwebtoken';


const generateVerifyToken = (userId: mongoose.Types.ObjectId): string => {

    const JWT_SECRET: string = process.env.JWT_SECRET || '';
    
    // Create the jwt payload
    const iat: number = Math.floor(Date.now() / 1000);
    const exp: number = iat + (15 * 60);

    const payload: DecodedValidationToken = {userId, iat, exp, purpose: 'Account Verification'};

    // create the token
    const token: string = jwt.sign(payload, JWT_SECRET, { algorithm: 'HS256' });

    return token;
};

export default generateVerifyToken;
import * as argon2 from 'argon2';
import e, { Request, Response } from 'express';
import { ZodError } from 'zod';
import { APIResponse } from '../../types/responses/APIResponse';
import { ResetPassword } from '../../schemas/auth/ResetPassword';
import jwt, { JsonWebTokenError } from 'jsonwebtoken';
import { User } from '../../model/User';
import { ResetToken } from '../../types/tokens/ResetToken';

const resetPasswordController = async (req: Request, res: Response): Promise<void> => {

    try {

        // Validate the user entered a new strong password using the ResetPassword zod schema
        const { password, confirm_password }: ResetPassword = ResetPassword.parse(req.body);

        // Get the reset token
        const token: string = req.params.token;
        const JWT_SECRET: string = process.env.JWT_SECRET || '';

        // Validate the reset token
        const decoded: ResetToken = jwt.verify(token, JWT_SECRET) as ResetToken;

        // Find the user's record 
        const user = await User.findById(decoded.userId);

        if(!user) {

            const response: APIResponse = {
                timestamp: Date.now(),
                message: 'User Not Found',
                code: 404
            };

            res.status(response.code).json(response);
            return;

        }

        // Hash the user's new password
        const hash = await argon2.hash(password);

        // Update the password in the user's document
        user.password = hash;
        await user.save();

        // Send a success response
        const response: APIResponse = {
            timestamp: Date.now(),
            message: 'Password Reset Successfully',
            code: 200
        };

        res.status(response.code).json(response);
        return;

    }
    catch(error) {

        if(error instanceof ZodError) {

            const response: APIResponse = {
                timestamp: Date.now(),
                message: 'Validation Error',
                code: 400,
                errors: error.errors.map(err => ({ field: err.path.join('.'), message: err.message, code: err.code }))
            };

            res.status(response.code).json(response);
            return;

        }

        if(error instanceof JsonWebTokenError) {

            const response: APIResponse = {
                timestamp: Date.now(),
                message: 'Invalid or expired token',
                code: 401
            };

            res.status(response.code).json(response);
            return;

        }

        // Return generic server error
        const response: APIResponse = {
            timestamp: Date.now(),
            message: 'Internal Server Error',
            code: 500
        };

        res.status(response.code).json(response);
        return;

    }

};

export default resetPasswordController;
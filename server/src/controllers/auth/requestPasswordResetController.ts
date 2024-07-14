import e, { Request, Response } from 'express';
import { RequestPasswordReset } from '../../schemas/auth/RequestPasswordReset';
import { ZodError } from 'zod';
import { APIResponse } from '../../types/responses/APIResponse';
import { UserDocument } from '../../types/models/Users';
import { User } from '../../model/User';
import sendPasswordResetEmail from '../../services/auth/sendPasswordResetEmail';

const requestPasswordResetController = async (req: Request, res: Response): Promise<void> => {

    try {

        // Use the requestPasswordReset zod schema to validate email input
        const { email }: RequestPasswordReset = RequestPasswordReset.parse(req.body);

        // Verify the email sent is linked to a valid account
        const user: UserDocument | null = await User.findOne({ email });

        if(!user) {

            const response: APIResponse = {
                timestamp: Date.now(),
                message: 'If the email address is associated with a valid account a reset link is on the way',
                code: 200
            };

            res.status(response.code).json(response);
            return;

        }

        // Send a reset password email
        await sendPasswordResetEmail(user);

        // Send a success response
        const response: APIResponse = {
            timestamp: Date.now(),
            message: 'If the email address is associated with a valid account a reset link is on the way',
            code: 200
        };

        res.status(response.code).json(response);
        return;

    }
    catch(error) {

        console.log(error)

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


export default requestPasswordResetController;
import * as argon2 from 'argon2';
import e, { Request, Response } from 'express';
import { ZodError } from 'zod';
import { APIResponse } from '../../types/responses/APIResponse';
import { RegisterFields } from '../../schemas/auth/RegisterFields';
import { User } from '../../model/User';
import { UserDocument } from '../../types/models/Users';
import sendVerifyAccountEmail from '../../services/auth/sendVerifyAccountEmail';

const registerController = async (req:Request, res:Response): Promise<void> => {

    try {

        // Use the Zod Schema to validate the register request body
        const { first_name, last_name, username, email, password, confirm_password, terms}: RegisterFields = RegisterFields.parse(req.body);

        // Verify the provided email and/or username is not already in use
        const findUser = await User.findOne({$or: [{ email },{ username }]});

        if(findUser) {

            const response: APIResponse = {
                timestamp: Date.now(),
                message: 'Conflict Error',
                code: 409,
                errors: []
            };

            if(findUser.email === email) response.errors?.push({field: 'email', message: 'Email is taken', code: 'conflict_error'});
            if(findUser.username === username) response.errors?.push({field: 'username', message: 'Username is taken', code: 'conflict_error'});

            res.status(response.code).json(response);
            return;

        }

        // Hash the password
        const hash = await argon2.hash(password);

        // Create the new user document and save to MongoDB
        const user: UserDocument = new User({ first_name, last_name, username, email, password:hash, terms_of_services_accepted:terms, terms_of_services_timestamp: Date.now(), terms_of_services_id: parseInt(process.env.TERMS_OF_SERVICE_ID as string, 10) });
        await user.save();

        // Send a verify account email
        await sendVerifyAccountEmail(user.id, user.email);

        // Return a success response
        const response: APIResponse = {
            timestamp: Date.now(),
            message: 'User Registered Successfully',
            code: 201
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

        // Return generic Internal server error
        const response: APIResponse = {
            timestamp: Date.now(),
            message: 'Internal Server Error',
            code: 500
        }

        res.status(response.code).json(response);
        return;
    }

}

export default registerController;
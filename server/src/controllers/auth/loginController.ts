import { Request, Response, NextFunction } from 'express';
import { LoginFields } from '../../schemas/auth/LoginFields';
import { ZodError } from 'zod';
import { APIResponse } from '../../types/responses/APIResponse';
import { User } from '../../model/User';
import * as argon2 from 'argon2';
import generateSessionToken from '../../utils/generateSessionToken';


const loginController = async (req:Request, res:Response, next:NextFunction): Promise<void> => {

    try {

        // Validate the login feilds using the Zod Schema
        const { username, password }: LoginFields = LoginFields.parse(req.body);

        // Attempt to find the user's document
        const user = await User.findOne({username});

        if(!user) {

            const response: APIResponse = {
                timestamp: Date.now(),
                message: 'Invalid username or password',
                code: 401
            };

            res.status(response.code).json(response);
            return;

        }

        // Check if the user if verified
        if(!user.verifed) {

            const response: APIResponse = {
                timestamp: Date.now(),
                message: 'Account is not verifed',
                code: 401
            };

            res.status(response.code).json(response);
            return;

        }

        // Check to see if the user's account is locked
        if(user.locked) {

            const response: APIResponse = {
                timestamp: Date.now(),
                message: 'Account is locked',
                code: 403
            };

            res.status(response.code).json(response);
            return;

        }

        // Compare the passwords to see if they match
        const passwordsMatch = await argon2.verify(user.password, password);

        if(!passwordsMatch) {

            // Increment the login attempts by 1
            user.login_attempts++;

            if(user.login_attempts >= 5) {
                user.locked =true;
            }

            await user.save();

            const response: APIResponse = {
                timestamp: Date.now(),
                message: 'Invalid username or password',
                code: 401
            };

            res.status(response.code).json(response);
            return;

        }

        // Generate a user session token
        const token: string = generateSessionToken(user);

        // Reset the login attempts to zero and update the login date
        user.login_attempts = 0;
        user.last_login = new Date();
        await user.save();

        // Send the token to the user
        const response: APIResponse = {
            timestamp: Date.now(),
            message: 'Login Successful',
            code: 200,
            token
        };

        res.status(response.code).json(response);
        return;

    }
    catch(error) {

        console.log(error);

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

export default loginController;
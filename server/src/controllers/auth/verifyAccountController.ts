import { Request, Response } from 'express';
import jwt from 'jsonwebtoken';
import { DecodedValidationToken } from '../../types/tokens/DecodedValidationToken';
import { UserDocument } from '../../types/models/Users';
import { User } from '../../model/User';
import { APIResponse } from '../../types/responses/APIResponse';

const verifyAccountController = async (req:Request, res:Response): Promise<void> => {

    try {

        // Extract the validation token from the req.params
        const token: string = req.params.token;
        const JWT_SECRET: string = process.env.JWT_SECRET || '';

        // Validate the token
        const decoded: DecodedValidationToken = jwt.verify(token, JWT_SECRET) as DecodedValidationToken;

        // Find the user's document from the database using id from token
        const user: UserDocument | null = await User.findById(decoded.userId);

        if(!user) {

            const response: APIResponse = {
                timestamp: Date.now(),
                message: 'User Not Found',
                code: 404
            };

            res.status(response.code).json(response);
            return;

        }

        // Check to see if the user is already validated
        if(user.verifed) {

            res.status(200).redirect('/login');

        }

        // Update the user's verified status
        user.verifed = true;
        await user.save();

        // Redirect to the login page
        return res.status(200).redirect('/login');

    }
    catch(error) {

        
        // Redirect to error page
        return res.status(500).redirect('/error');

    }

};

export default verifyAccountController;
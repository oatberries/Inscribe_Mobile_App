import { Request, Response, NextFunction } from 'express';
import { APIResponse } from '../types/responses/APIResponse';
import { SanitizeOptions } from '../types/sanitize/SanitizeOptions';
import sanitizeHtml from 'sanitize-html';

// Blacklist array: These are fields we do not want to sanitize
const blacklist: string[] = ["password", "confirm_password", "terms"];

// define sanitization parameters
const sanitizeOptions: SanitizeOptions = {
    allowedTags: [],
    allowedAttribures: {}
};

const sanitizeRequest = (req: Request, res: Response, next: NextFunction): void => {

    if(req.body) {

        const response: APIResponse = {timestamp: Date.now(), message: 'Sanitization Error', code: 400, errors: []};

        // Loop through each of the fields in the request
        Object.keys(req.body).forEach(field => {

            if(!blacklist.includes(field)) {
                
                const clean = sanitizeHtml(req.body[field], sanitizeOptions);

                if(clean !== req.body[field]) {
                    response.errors?.push({field, message: `${field} has an illegal/invalid character(s)` , code: 'santize_error',});
                }

            }

        });

        // If there were any santize errors return response
        if(response.errors?.length !== 0) {

            res.status(400).json(response);
            return;

        }

    }

    next();

};

export default sanitizeRequest;
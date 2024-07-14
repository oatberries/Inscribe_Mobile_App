"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ResetPassword = void 0;
const zod_1 = require("zod");
exports.ResetPassword = zod_1.z.object({
    password: zod_1.z.string().trim()
        .min(8, { message: 'Password must be at least charracters long' })
        .max(64, { message: 'Password cannot exceed 64 characters in length' })
        .regex(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&_-]{8,}$/, { message: 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character' }),
    confirm_password: zod_1.z.string().trim()
        .min(8, { message: 'Confirm password must be at least 8 characters long' })
        .max(64, { message: 'Confirm password cannot exceed 64 characters in length' })
}).refine(data => data.password === data.confirm_password, { message: 'Passwords do not match' });

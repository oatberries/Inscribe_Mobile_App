"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.LoginFields = void 0;
const zod_1 = require("zod");
exports.LoginFields = zod_1.z.object({
    username: zod_1.z.string().trim()
        .min(1, { message: 'Username required' })
        .max(50, { message: 'Username cannot exceed 50 characters in length' })
        .regex(/^[a-zA-Z][a-zA-Z0-9-_]{0,49}$/, { message: 'Username must start with a letter and can only contain letters, numbers, hypens, and underscores' })
        .refine((name) => name.trim().length > 0, { message: 'Username cannot be just whitespace' }),
    password: zod_1.z.string().trim()
        .min(8, { message: 'Password must be at least 8 characters long' })
        .max(64, { message: 'Password cannot exceed 64 characters in length' }),
});

"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.RequestPasswordReset = void 0;
const zod_1 = require("zod");
exports.RequestPasswordReset = zod_1.z.object({
    email: zod_1.z.string().trim()
        .min(1, { message: 'Email address is required' })
        .max(255, { message: 'Email address cannot exceed 50 characters in length' })
        .email({ message: 'Invalid email address' }),
});

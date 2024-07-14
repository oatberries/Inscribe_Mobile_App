import { z } from 'zod';

export const ResetPassword = z.object({

    password: z.string().trim()
        .min(8, { message: 'Password must be at least charracters long' })
        .max(64, { message: 'Password cannot exceed 64 characters in length' })
        .regex(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&_-]{8,}$/, { message: 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character' }),

    confirm_password: z.string().trim()
        .min(8, { message: 'Confirm password must be at least 8 characters long' })
        .max(64, { message: 'Confirm password cannot exceed 64 characters in length' })

}).refine( data => data.password === data.confirm_password, { message: 'Passwords do not match' } );

export type ResetPassword = z.infer<typeof ResetPassword>;
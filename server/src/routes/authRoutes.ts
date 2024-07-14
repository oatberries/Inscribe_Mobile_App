import express from 'express';
import sanitizeRequest from '../middlewares/sanitzeRequest';
import registerController from '../controllers/auth/registerController';
import verifyAccountController from '../controllers/auth/verifyAccountController';
import loginController from '../controllers/auth/loginController';
import requestPasswordResetController from '../controllers/auth/requestPasswordResetController';
import redirectToPasswordResetController from '../controllers/auth/redirectToPasswordResetController';
import resetPasswordController from '../controllers/auth/resetPasswordController';

const authRouter = express.Router();

authRouter.post('/register', sanitizeRequest, registerController);
authRouter.get('/verify-account/:token', sanitizeRequest, verifyAccountController);
authRouter.post('/login', sanitizeRequest, loginController);
authRouter.post('/request-password-reset', sanitizeRequest, requestPasswordResetController);
authRouter.get('/redirect-to-password-reset/:token', redirectToPasswordResetController);
authRouter.post('/reset-password/:token', resetPasswordController);

export default authRouter;
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const redirectToPasswordResetController = (req, res) => {
    try {
        // Get the reset token
        const token = req.params.token;
        const JWT_SECRET = process.env.JWT_SECRET || '';
        // Redirect to the reset-password page
        res.status(200).redirect(`/reset-password/${token}`);
    }
    catch (error) {
        console.error(error);
        res.status(400).redirect('/login');
    }
};
exports.default = redirectToPasswordResetController;

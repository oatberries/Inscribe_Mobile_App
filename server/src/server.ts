import express, { Express } from 'express';
const path = require('path');
import * as dotenv from 'dotenv';
import mongoose from 'mongoose';
import sanitizeRequest from './middlewares/sanitzeRequest';
import authRouter from './routes/authRoutes';
import cors from 'cors';

// Load the environment variables from the .env file
dotenv.config();

// Initialize express application
const app: Express = express();

// Middleware
app.use(express.json());
app.use(cors());

// Routes
app.post('/this-is-a-test-route-remove-before-deployment', sanitizeRequest, (req, res) => {res.status(200).send('Success')});
app.use('/api/auth', authRouter);

// Serve static files from the React frontend
app.use(express.static(path.join(__dirname, '../../client/dist')));

// Handle React routing, return all requests to React app
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, '../../client/dist', 'index.html'));
});

// Connect to the database and start the server
const MONGO_URI: string = process.env.MONGO_URI ?? '';
const PORT: number = parseInt(process.env.PORT ?? '5000', 10);

mongoose.connect(MONGO_URI)
.then(() => {

    console.log('Connected to MongoDB');

    app.listen(PORT, () => {
        console.log(`Server is listening on port ${PORT}`);
    });

})
.catch((error) => {

    console.error(`ERROR: Something went wrong while connecting to MongoDB : [${error}]`);

});
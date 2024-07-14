"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
var _a, _b;
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const path = require('path');
const dotenv = __importStar(require("dotenv"));
const mongoose_1 = __importDefault(require("mongoose"));
const sanitzeRequest_1 = __importDefault(require("./middlewares/sanitzeRequest"));
const authRoutes_1 = __importDefault(require("./routes/authRoutes"));
const cors_1 = __importDefault(require("cors"));
// Load the environment variables from the .env file
dotenv.config();
// Initialize express application
const app = (0, express_1.default)();
// Middleware
app.use(express_1.default.json());
app.use((0, cors_1.default)());
// Routes
app.post('/this-is-a-test-route-remove-before-deployment', sanitzeRequest_1.default, (req, res) => { res.status(200).send('Success'); });
app.use('/api/auth', authRoutes_1.default);
// Serve static files from the React frontend
//app.use(express.static(path.join(__dirname, '../../client/dist')));
app.use(express_1.default.static(path.join(__dirname, '../../client/build')));
// Handle React routing, return all requests to React app
app.get('*', (req, res) => {
    //res.sendFile(path.join(__dirname, '../../client/dist', 'index.html'));
    res.sendFile(path.join(__dirname, '../../client/build', 'index.html'));
});
// Connect to the database and start the server
const MONGO_URI = (_a = process.env.MONGO_URI) !== null && _a !== void 0 ? _a : '';
const PORT = parseInt((_b = process.env.PORT) !== null && _b !== void 0 ? _b : '5000', 10);
mongoose_1.default.connect(MONGO_URI)
    .then(() => {
    console.log('Connected to MongoDB');
    app.listen(PORT, () => {
        console.log(`Server is listening on port ${PORT}`);
    });
})
    .catch((error) => {
    console.error(`ERROR: Something went wrong while connecting to MongoDB : [${error}]`);
});

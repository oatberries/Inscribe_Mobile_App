import mongoose, { Model, Schema } from 'mongoose';
import { UserDocument } from '../types/models/Users';


const UserSchema = new Schema<UserDocument>({

    first_name: { type: String, required: true },
    last_name: { type: String, required: true },
    username: { type: String, required: true, unique: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    verifed: { type: Boolean, default: false },
    locked: { type: Boolean, default: false },
    login_attempts: { type: Number, default: 0 },
    created_at: { type: Date, default: Date.now() },
    last_login: { type: Date, default: null },
    terms_of_services_accepted: { type: Boolean, default: false },
    terms_of_services_id: { type: Number, default: null },
    terms_of_services_timestamp: { type: Date, default: null }
     

});

export const User: Model<UserDocument> = mongoose.model<UserDocument>('User', UserSchema);
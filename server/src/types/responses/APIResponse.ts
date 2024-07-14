export interface APIResponse {

    timestamp?: number,
    message: string,
    code: number,
    errors?: Array<{

        field: string;
        message: string;
        code?: string | number;

    }>,
    token?: string

};
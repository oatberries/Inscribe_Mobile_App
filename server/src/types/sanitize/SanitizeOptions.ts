export interface SanitizeOptions {

    allowedTags: string[],
    allowedAttribures: {[key: string]: string[];},
    allowedIframeHostnames?: string[];

};
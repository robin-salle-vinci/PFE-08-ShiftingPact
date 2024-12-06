import { jwtDecode } from 'jwt-decode';

// Define the structure of the decoded token payload
export interface DecodedToken {
  id: string;
  username: string;
  role: string;
  iat: number;
}

// Function to decode the token and extract user info (username, id, role)
export const decodeToken = (token: string): DecodedToken => {
  if (!token) {
    throw new Error('No token found'); // No token in localStorage
  }

  try {
    // Decode the JWT token
    const decoded: DecodedToken = jwtDecode(token);
    return decoded; // Return the decoded payload
  } catch (error) {
    throw new Error('Invalid token: ' + error); // Error if token is invalid or expired
  }
};

// Function to check if the user is authenticated by checking if a valid token exists
export const isAuthenticated = (): boolean => {
  const token = localStorage.getItem('token');
  try {
    decodeToken(token!); // If the token is valid, this will succeed
    return true;
  } catch (error) {
    console.error(error);
    return false; // If decoding fails, the user is not authenticated
  }
};

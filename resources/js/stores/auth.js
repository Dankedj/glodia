import { defineStore } from 'pinia';
import axios from 'axios';

export const useAuthStore = defineStore('auth', {
    state: () => ({
        user: null,
        token: localStorage.getItem('token'),
        isAdmin: false,
        ready: false,
    }),

    getters: {
        isAuthenticated: (state) => !!state.user,
    },

    actions: {
        async login(credentials) {
            try {
                const response = await axios.post('/api/login', credentials);
                this.token = response.data.token;
                this.user = response.data.user;
                this.isAdmin = this.user.role === 'admin';
                localStorage.setItem('token', this.token);
                axios.defaults.headers.common['Authorization'] = `Bearer ${this.token}`;
                return true;
            } catch (error) {
                console.error('Login failed:', error.response?.data || error);
                return false;
            }
        },

        async register(userData) {
            try {
                const response = await axios.post('/api/register', userData);
                this.token = response.data.token;
                this.user = response.data.user;
                this.isAdmin = this.user.role === 'admin';
                localStorage.setItem('token', this.token);
                axios.defaults.headers.common['Authorization'] = `Bearer ${this.token}`;
                return true;
            } catch (error) {
                console.error('Register failed:', error.response?.data || error);
                const errors = error.response?.data?.errors;
                if (errors) {
                    return Object.values(errors).flat().join(' ');
                }
                return error.response?.data?.message || "Erreur lors de l'inscription";
            }
        },

        async logout() {
            try {
                if (this.token) {
                    await axios.post('/api/logout');
                }
            } catch (error) {
                console.error('Logout error:', error);
            } finally {
                this.user = null;
                this.token = null;
                this.isAdmin = false;
                localStorage.removeItem('token');
                delete axios.defaults.headers.common['Authorization'];
            }
        },

        async checkAuth() {
            if (this.token) {
                axios.defaults.headers.common['Authorization'] = `Bearer ${this.token}`;
                try {
                    const response = await axios.get('/api/user');
                    this.user = response.data;
                    this.isAdmin = this.user.role === 'admin';
                } catch (error) {
                    await this.logout();
                }
            }
        },

        async ensureReady() {
            if (this.ready) return;
            this.ready = true;
            await this.checkAuth();
        },
    },
});
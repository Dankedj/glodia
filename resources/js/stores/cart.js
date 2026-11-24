import { defineStore } from 'pinia';
import axios from 'axios';

export const useCartStore = defineStore('cart', {
    state: () => ({
        items: [],
        totalItems: 0,
        totalAmount: 0,
        currency: 'CDF',
    }),

    actions: {
        async fetchCart() {
            try {
                const response = await axios.get('/api/cart');
                this.items = response.data.items || [];
                this.totalItems = response.data.total_items;
                this.totalAmount = response.data.total_amount;
                this.currency = response.data.currency;
            } catch (error) {
                console.error('Error fetching cart:', error);
            }
        },

        async addItem(productId, quantity = 1) {
            try {
                const response = await axios.post('/api/cart/add', {
                    product_id: productId,
                    quantity: quantity,
                });
                this.items = response.data.items;
                this.totalItems = response.data.total_items;
                this.totalAmount = response.data.total_amount;
            } catch (error) {
                console.error('Error adding item:', error);
                throw error;
            }
        },

        async removeItem(productId) {
            try {
                const response = await axios.delete(`/api/cart/remove/${productId}`);
                this.items = response.data.items;
                this.totalItems = response.data.total_items;
                this.totalAmount = response.data.total_amount;
            } catch (error) {
                console.error('Error removing item:', error);
            }
        },

        async updateQuantity(productId, quantity) {
            try {
                const response = await axios.put(`/api/cart/update/${productId}`, {
                    quantity: quantity,
                });
                this.items = response.data.items;
                this.totalItems = response.data.total_items;
                this.totalAmount = response.data.total_amount;
            } catch (error) {
                console.error('Error updating quantity:', error);
            }
        },

        async clearCart() {
            try {
                await axios.post('/api/cart/clear');
                this.items = [];
                this.totalItems = 0;
                this.totalAmount = 0;
            } catch (error) {
                console.error('Error clearing cart:', error);
            }
        },
    },
});
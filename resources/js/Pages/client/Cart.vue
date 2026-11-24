<template>
  <div class="container mx-auto px-4 py-8">
    <h1 class="text-xl font-bold text-gray-900 mb-6">Mon Panier</h1>

    <div v-if="cartStore.items && Object.keys(cartStore.items).length > 0" class="grid grid-cols-1 lg:grid-cols-3 gap-8">
      <!-- Cart Items -->
      <div class="lg:col-span-2">
        <div class="bg-white rounded-xl border border-gray-200 overflow-hidden">
          <div class="divide-y divide-gray-100">
            <div v-for="(item, productId) in cartStore.items" :key="productId" class="p-4 flex gap-4">
              <img 
                :src="item.image || '/images/default-product.svg'"
                :alt="item.name"
                class="w-24 h-24 object-cover rounded"
              >
              
              <div class="flex-1">
                <h3 class="font-semibold text-lg">{{ item.name }}</h3>
                <p class="text-green-600 font-bold">{{ formatPrice(item.price, item.currency) }}</p>
                
                <div class="flex items-center gap-3 mt-2">
                  <div class="flex items-center border border-gray-200 rounded-lg">
                    <button 
                      @click="updateQuantity(productId, item.quantity - 1)"
                      :disabled="item.quantity <= 1"
                      class="px-2 py-1 hover:bg-gray-100 disabled:opacity-50"
                    >
                      -
                    </button>
                    <span class="px-3 py-1 border-x">{{ item.quantity }}</span>
                    <button 
                      @click="updateQuantity(productId, item.quantity + 1)"
                      class="px-2 py-1 hover:bg-gray-100"
                    >
                      +
                    </button>
                  </div>
                  
                  <button 
                    @click="removeItem(productId)"
                    class="text-red-600 hover:text-red-800 text-sm"
                  >
                    Supprimer
                  </button>
                </div>
              </div>
              
              <div class="text-right">
                <p class="font-bold">{{ formatPrice(item.price * item.quantity, item.currency) }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Order Summary -->
      <div class="lg:col-span-1">
        <div class="bg-white rounded-xl border border-gray-200 p-6 sticky top-4">
          <h2 class="text-xl font-bold mb-4">Récapitulatif</h2>
          
          <div class="space-y-2 mb-4">
            <div class="flex justify-between">
              <span>Sous-total</span>
              <span>{{ formatPrice(cartStore.totalAmount, cartStore.currency) }}</span>
            </div>
            <div class="flex justify-between text-sm text-gray-500">
              <span>Livraison</span>
              <span>À calculer</span>
            </div>
            <div class="border-t border-gray-100 pt-3 mt-3">
              <div class="flex justify-between font-bold text-lg">
                <span>Total</span>
                <span>{{ formatPrice(cartStore.totalAmount, cartStore.currency) }}</span>
              </div>
            </div>
          </div>
          
          <button
            @click="proceedToCheckout"
            :disabled="cartStore.totalItems === 0"
            class="w-full bg-green-600 text-white py-3 rounded-lg hover:bg-green-700 disabled:opacity-50 disabled:cursor-not-allowed transition"
          >
            Procéder au paiement
          </button>
          
          <router-link
            to="/"
            class="block text-center text-green-600 hover:underline mt-4"
          >
            Continuer mes achats
          </router-link>
        </div>
      </div>
    </div>

    <div v-else class="text-center py-12 bg-white rounded-xl border border-gray-200">
      <svg class="w-24 h-24 mx-auto text-gray-400 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
      </svg>
      <p class="text-gray-500 text-lg mb-4">Votre panier est vide</p>
      <router-link
        to="/"
        class="inline-block bg-green-600 text-white px-6 py-3 text-sm font-medium rounded-lg hover:bg-green-700"
      >
        Découvrir nos produits
      </router-link>
    </div>
  </div>
</template>

<script setup>
import { onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { useCartStore } from '../../stores/cart';
import { useAuthStore } from '../../stores/auth';
import { formatPrice } from '../../utils/format';

const router = useRouter();
const cartStore = useCartStore();
const authStore = useAuthStore();

const updateQuantity = async (productId, quantity) => {
  if (quantity <= 0) {
    await removeItem(productId);
  } else {
    await cartStore.updateQuantity(productId, quantity);
  }
};

const removeItem = async (productId) => {
  await cartStore.removeItem(productId);
};

const proceedToCheckout = () => {
  if (!authStore.isAuthenticated) {
    router.push('/login');
  } else {
    router.push('/checkout');
  }
};

onMounted(() => {
  cartStore.fetchCart();
});
</script>
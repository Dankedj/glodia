<template>
  <div class="container mx-auto px-4 py-8">
    <h1 class="text-xl font-bold text-gray-900 mb-6">Validation de la commande</h1>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
      <!-- Checkout Form -->
      <div class="lg:col-span-2">
        <div class="bg-white rounded-xl border border-gray-200 p-6">
          <h2 class="text-xl font-bold mb-4">Informations de livraison</h2>
          
          <form @submit.prevent="placeOrder">
            <div class="grid grid-cols-1 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Nom complet</label>
                <input
                  v-model="form.name"
                  type="text"
                  required
                  class="w-full px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:bg-white focus:outline-none focus:ring-2 focus:ring-green-500"
                >
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                <input
                  v-model="form.email"
                  type="email"
                  required
                  class="w-full px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:bg-white focus:outline-none focus:ring-2 focus:ring-green-500"
                >
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Téléphone</label>
                <input
                  v-model="form.phone"
                  type="tel"
                  required
                  class="w-full px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:bg-white focus:outline-none focus:ring-2 focus:ring-green-500"
                >
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Adresse de livraison</label>
                <textarea
                  v-model="form.address"
                  rows="3"
                  required
                  class="w-full px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:bg-white focus:outline-none focus:ring-2 focus:ring-green-500"
                  placeholder="Rue, numéro, ville, code postal"
                ></textarea>
              </div>
            </div>
          </form>
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
            <div class="border-t border-gray-100 pt-3 mt-3">
              <div class="flex justify-between font-bold text-lg">
                <span>Total</span>
                <span>{{ formatPrice(cartStore.totalAmount, cartStore.currency) }}</span>
              </div>
            </div>
          </div>
          
          <button
            @click="placeOrder"
            :disabled="loading || cartStore.totalItems === 0"
            class="w-full bg-green-600 text-white py-3 rounded-lg hover:bg-green-700 disabled:opacity-50 disabled:cursor-not-allowed transition"
          >
            {{ loading ? 'Traitement...' : 'Confirmer la commande' }}
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { useCartStore } from '../../stores/cart';
import { useAuthStore } from '../../stores/auth';
import { formatPrice } from '../../utils/format';
import axios from 'axios';

const router = useRouter();
const cartStore = useCartStore();
const authStore = useAuthStore();

const loading = ref(false);
const form = ref({
  name: '',
  email: '',
  phone: '',
  address: '',
});

const placeOrder = async () => {
  if (!authStore.isAuthenticated) {
    router.push('/login');
    return;
  }
  
  loading.value = true;
  
  try {
    const response = await axios.post('/api/checkout', {
      shipping_address: form.value.address,
    });
    await cartStore.clearCart();
    router.push(`/receipt/${response.data.id}?success=1`);
  } catch (error) {
    console.error('Error placing order:', error);
    alert('Erreur lors de la commande');
  } finally {
    loading.value = false;
  }
};

onMounted(() => {
  if (authStore.user) {
    form.value = {
      name: authStore.user.name || '',
      email: authStore.user.email || '',
      phone: authStore.user.phone || '',
      address: authStore.user.address || '',
    };
  }
});
</script>
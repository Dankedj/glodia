<template>
  <div class="container mx-auto px-4 py-8 max-w-5xl">
    <div class="mb-6">
      <h1 class="text-xl font-bold text-gray-900">Mes commandes</h1>
      <p class="text-sm text-gray-500 mt-0.5">{{ orders.length }} commande(s)</p>
    </div>

    <div v-if="loading" class="text-center py-16">
      <div class="inline-block animate-spin rounded-full h-8 w-8 border-2 border-gray-200 border-t-green-600"></div>
    </div>

    <div v-else-if="orders.length === 0" class="bg-white rounded-xl border border-gray-200 p-14 text-center">
      <svg class="w-16 h-16 mx-auto text-gray-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
      </svg>
      <p class="text-gray-500 mb-5">Vous n'avez pas encore de commandes</p>
      <router-link
        to="/products"
        class="inline-block px-5 py-2.5 text-sm font-medium text-white bg-green-600 rounded-lg hover:bg-green-700 transition"
      >
        Découvrir nos produits
      </router-link>
    </div>

    <div v-else class="bg-white rounded-xl border border-gray-200 overflow-hidden">
      <table class="min-w-full divide-y divide-gray-100">
        <thead>
          <tr class="bg-gray-50/60">
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Commande</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Produits</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Statut</th>
            <th class="px-5 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Total</th>
            <th class="px-5 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider"></th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-100">
          <tr v-for="order in orders" :key="order.id" class="hover:bg-gray-50/50 transition">
            <td class="px-5 py-3.5 text-sm font-medium text-gray-900">{{ order.order_number }}</td>
            <td class="px-5 py-3.5 text-sm text-gray-600">{{ formatDate(order.issued_date) }}</td>
            <td class="px-5 py-3.5">
              <span class="text-xs font-medium text-gray-700 bg-gray-100 px-2.5 py-1 rounded-full">
                {{ order.items?.length || 0 }} produit(s)
              </span>
            </td>
            <td class="px-5 py-3.5">
              <span :class="getStatusClass(order.status)" class="px-2.5 py-1 text-xs font-medium rounded-full">
                {{ getStatusLabel(order.status) }}
              </span>
            </td>
            <td class="px-5 py-3.5 text-sm font-semibold text-gray-900 text-right">
              {{ formatPrice(order.total_amount, order.currency) }}
            </td>
            <td class="px-5 py-3.5 text-right whitespace-nowrap">
              <router-link
                :to="`/receipt/${order.id}`"
                class="inline-block p-2 text-gray-400 hover:text-green-600 hover:bg-green-50 rounded-lg transition"
                title="Reçu"
              >
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M9 14l6-6m-5.5.5h.01m4.99 5h.01M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16l3.5-2 3.5 2 3.5-2 3.5 2z" />
                </svg>
              </router-link>
              <button
                @click="viewOrder(order)"
                class="p-2 text-gray-400 hover:text-green-600 hover:bg-green-50 rounded-lg transition"
                title="Détails"
              >
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                </svg>
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Order Details Modal -->
    <div v-if="selectedOrder" class="fixed inset-0 bg-black/40 flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-xl w-full max-w-2xl max-h-[85vh] overflow-y-auto border border-gray-200">
        <div class="sticky top-0 bg-white border-b border-gray-100 px-6 py-4 flex justify-between items-center">
          <div>
            <h2 class="text-lg font-bold text-gray-900">Commande #{{ selectedOrder.order_number }}</h2>
            <p class="text-xs text-gray-500 mt-0.5">{{ formatDate(selectedOrder.issued_date) }}</p>
          </div>
          <div class="flex items-center gap-3">
            <span :class="getStatusClass(selectedOrder.status)" class="px-2.5 py-1 text-xs font-medium rounded-full">
              {{ getStatusLabel(selectedOrder.status) }}
            </span>
            <button @click="selectedOrder = null" class="p-1.5 text-gray-400 hover:text-gray-600 hover:bg-gray-100 rounded-lg transition">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>
        </div>

        <div class="p-6">
          <div class="bg-gray-50 rounded-lg p-4 mb-6">
            <h3 class="text-xs font-semibold text-gray-500 uppercase mb-2">Adresse de livraison</h3>
            <p class="text-sm text-gray-700 whitespace-pre-line">{{ selectedOrder.shipping_address }}</p>
          </div>

          <h3 class="text-sm font-semibold text-gray-900 mb-3">Produits commandés</h3>
          <div class="border border-gray-100 rounded-lg divide-y divide-gray-100 mb-4">
            <div v-for="item in selectedOrder.items" :key="item.id" class="flex items-center gap-3 px-4 py-3">
              <img
                :src="item.product?.images?.[0] || '/images/default-product.svg'"
                :alt="item.product?.name"
                class="w-10 h-10 object-cover rounded-lg border border-gray-100"
              >
              <div class="flex-1 leading-tight">
                <p class="text-sm font-medium text-gray-900">{{ item.product?.name }}</p>
                <p class="text-xs text-gray-500">{{ item.quantity }} × {{ formatPrice(item.unit_price, selectedOrder.currency) }}</p>
              </div>
              <p class="text-sm font-semibold text-gray-900">{{ formatPrice(item.total_price, selectedOrder.currency) }}</p>
            </div>
          </div>

          <div class="flex justify-between items-center border-t border-gray-100 pt-4">
            <router-link
              :to="`/receipt/${selectedOrder.id}`"
              class="inline-flex items-center gap-1.5 text-sm font-medium text-green-600 hover:text-green-700 transition"
            >
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
              </svg>
              Télécharger le reçu
            </router-link>
            <p class="text-base font-bold text-gray-900">Total : {{ formatPrice(selectedOrder.total_amount, selectedOrder.currency) }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';
import { formatPrice, formatDate, getStatusClass, getStatusLabel } from '../../utils/format';

const orders = ref([]);
const loading = ref(true);
const selectedOrder = ref(null);

const viewOrder = (order) => {
  selectedOrder.value = order;
};

const loadOrders = async () => {
  try {
    const response = await axios.get('/api/orders');
    orders.value = response.data;
  } catch (error) {
    console.error('Error loading orders:', error);
  } finally {
    loading.value = false;
  }
};

onMounted(() => {
  loadOrders();
});
</script>

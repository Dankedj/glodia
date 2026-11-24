<template>
  <div>
    <!-- Header -->
    <div class="flex items-center justify-between mb-6">
      <div>
        <h1 class="text-xl font-bold text-gray-900">Commandes</h1>
        <p class="text-sm text-gray-500 mt-0.5">{{ orders.length }} commande(s)</p>
      </div>
    </div>

    <!-- Table card -->
    <div class="bg-white rounded-xl border border-gray-200 overflow-hidden">
      <table class="min-w-full divide-y divide-gray-100">
        <thead>
          <tr class="bg-gray-50/60">
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Commande</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Client</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Statut</th>
            <th class="px-5 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Total</th>
            <th class="px-5 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-100">
          <tr v-for="order in orders" :key="order.id" class="hover:bg-gray-50/50 transition">
            <td class="px-5 py-3.5 text-sm font-medium text-gray-900">{{ order.order_number }}</td>
            <td class="px-5 py-3.5">
              <div class="flex items-center gap-2.5">
                <div class="w-8 h-8 rounded-full bg-gray-100 text-gray-600 flex items-center justify-center text-xs font-semibold">
                  {{ initials(order.user?.name) }}
                </div>
                <div class="leading-tight">
                  <p class="text-sm font-medium text-gray-900">{{ order.user?.name }}</p>
                  <p class="text-xs text-gray-500">{{ order.user?.email }}</p>
                </div>
              </div>
            </td>
            <td class="px-5 py-3.5 text-sm text-gray-600">{{ formatDate(order.issued_date) }}</td>
            <td class="px-5 py-3.5">
              <select
                v-model="order.status"
                @change="updateStatus(order)"
                :class="getStatusClass(order.status)"
                class="px-2.5 py-1 text-xs font-medium rounded-full border-0 cursor-pointer focus:ring-2 focus:ring-green-500"
              >
                <option value="pending">En attente</option>
                <option value="paid">Payée</option>
                <option value="shipped">Expédiée</option>
                <option value="delivered">Livrée</option>
                <option value="cancelled">Annulée</option>
              </select>
            </td>
            <td class="px-5 py-3.5 text-sm font-semibold text-gray-900 text-right">
              {{ formatPrice(order.total_amount, order.currency) }}
            </td>
            <td class="px-5 py-3.5 text-right">
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
          <tr v-if="!orders.length">
            <td colspan="6" class="px-5 py-10 text-center text-sm text-gray-400">Aucune commande pour le moment</td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Modal Détails -->
    <div v-if="selectedOrder" class="fixed inset-0 bg-black/40 flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-xl w-full max-w-2xl max-h-[85vh] overflow-y-auto border border-gray-200">
        <div class="sticky top-0 bg-white border-b border-gray-100 px-6 py-4 flex justify-between items-center">
          <h2 class="text-lg font-bold text-gray-900">Commande #{{ selectedOrder.order_number }}</h2>
          <button @click="selectedOrder = null" class="p-1.5 text-gray-400 hover:text-gray-600 hover:bg-gray-100 rounded-lg transition">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>

        <div class="p-6">
          <div class="grid grid-cols-2 gap-4 mb-6">
            <div class="bg-gray-50 rounded-lg p-4">
              <h3 class="text-xs font-semibold text-gray-500 uppercase mb-2">Client</h3>
              <p class="text-sm font-medium text-gray-900">{{ selectedOrder.user?.name }}</p>
              <p class="text-sm text-gray-600">{{ selectedOrder.user?.email }}</p>
              <p class="text-sm text-gray-600">{{ selectedOrder.user?.phone || '-' }}</p>
            </div>
            <div class="bg-gray-50 rounded-lg p-4">
              <h3 class="text-xs font-semibold text-gray-500 uppercase mb-2">Livraison</h3>
              <p class="text-sm text-gray-600 whitespace-pre-line">{{ selectedOrder.shipping_address }}</p>
            </div>
          </div>

          <h3 class="text-sm font-semibold text-gray-900 mb-3">Produits commandés</h3>
          <div class="border border-gray-100 rounded-lg divide-y divide-gray-100 mb-4">
            <div v-for="item in selectedOrder.items" :key="item.id" class="flex items-center gap-3 px-4 py-3">
              <img
                :src="item.product?.images?.[0] || '/images/default-product.svg'"
                class="w-10 h-10 object-cover rounded-lg border border-gray-100"
                :alt="item.product?.name"
              >
              <div class="flex-1 leading-tight">
                <p class="text-sm font-medium text-gray-900">{{ item.product?.name }}</p>
                <p class="text-xs text-gray-500">{{ item.quantity }} × {{ formatPrice(item.unit_price, selectedOrder.currency) }}</p>
              </div>
              <p class="text-sm font-semibold text-gray-900">{{ formatPrice(item.total_price, selectedOrder.currency) }}</p>
            </div>
          </div>

          <div class="flex justify-end border-t border-gray-100 pt-4">
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
import { formatPrice, formatDate, getStatusClass, initials } from '../../utils/format';

const orders = ref([]);
const selectedOrder = ref(null);

const loadOrders = async () => {
  try {
    const response = await axios.get('/api/admin/orders');
    orders.value = response.data;
  } catch (error) {
    console.error('Error loading orders:', error);
  }
};

const updateStatus = async (order) => {
  try {
    await axios.put(`/api/admin/orders/${order.id}/status`, {
      status: order.status,
    });
  } catch (error) {
    console.error('Error updating order status:', error);
    alert('Erreur lors de la mise à jour du statut');
  }
};

const viewOrder = (order) => {
  selectedOrder.value = order;
};

onMounted(() => {
  loadOrders();
});
</script>

<template>
  <div>
    <!-- Header -->
    <div class="flex items-center justify-between mb-6">
      <div>
        <h1 class="text-xl font-bold text-gray-900">Dashboard</h1>
        <p class="text-sm text-gray-500 mt-0.5">Vue d'ensemble de votre ferme</p>
      </div>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4 mb-6">
      <div v-for="card in statCards" :key="card.label" class="bg-white rounded-xl border border-gray-200 p-5">
        <div class="flex items-start justify-between">
          <div>
            <p class="text-sm text-gray-500">{{ card.label }}</p>
            <p class="text-2xl font-bold text-gray-900 mt-1">{{ card.value }}</p>
          </div>
          <div class="w-10 h-10 rounded-lg flex items-center justify-center" :class="card.bg">
            <span v-html="card.icon" class="w-5 h-5" :class="card.color"></span>
          </div>
        </div>
        <p v-if="card.sub" class="text-xs mt-3" :class="card.subClass">{{ card.sub }}</p>
      </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-4 mb-6">
      <!-- Ventes par devise -->
      <div class="bg-white rounded-xl border border-gray-200 p-5">
        <h2 class="text-sm font-semibold text-gray-900 mb-4">Total des ventes</h2>
        <div v-if="totalsByCurrency.length" class="space-y-3">
          <div v-for="total in totalsByCurrency" :key="total.currency" class="flex justify-between items-center">
            <span class="text-sm text-gray-600">{{ total.currency === 'CDF' ? 'Francs Congolais' : 'Dollars US' }}</span>
            <span class="text-sm font-bold text-gray-900">{{ formatPrice(total.total, total.currency) }}</span>
          </div>
        </div>
        <p v-else class="text-sm text-gray-400">Aucune vente pour le moment</p>
      </div>

      <!-- Top produits -->
      <div class="bg-white rounded-xl border border-gray-200 p-5 lg:col-span-2">
        <h2 class="text-sm font-semibold text-gray-900 mb-4">Produits les plus vendus</h2>
        <div v-if="topProducts.length" class="divide-y divide-gray-100">
          <div v-for="(product, index) in topProducts.slice(0, 5)" :key="product.id" class="flex items-center gap-3 py-2.5">
            <span class="w-5 text-xs text-gray-400 font-medium">{{ index + 1 }}</span>
            <img :src="product.images?.[0] || '/images/default-product.svg'" class="w-9 h-9 object-cover rounded-lg" alt="">
            <p class="flex-1 text-sm font-medium text-gray-900 truncate">{{ product.name }}</p>
            <span class="text-xs font-medium text-green-700 bg-green-50 px-2 py-1 rounded-full">{{ product.total_sold }} vendus</span>
          </div>
        </div>
        <p v-else class="text-sm text-gray-400">Aucune vente pour le moment</p>
      </div>
    </div>

    <!-- Commandes récentes -->
    <div class="bg-white rounded-xl border border-gray-200 overflow-hidden">
      <div class="flex items-center justify-between px-5 py-4 border-b border-gray-100">
        <h2 class="text-sm font-semibold text-gray-900">Commandes récentes</h2>
        <router-link to="/admin/orders" class="text-sm text-green-600 hover:text-green-700 font-medium">
          Tout voir
        </router-link>
      </div>
      <table class="min-w-full divide-y divide-gray-100">
        <thead>
          <tr class="bg-gray-50/60">
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">N°</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Client</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Statut</th>
            <th class="px-5 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Total</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-100">
          <tr v-for="order in recentOrders" :key="order.id" class="hover:bg-gray-50/50 transition">
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
              <span :class="getStatusClass(order.status)" class="px-2.5 py-1 text-xs font-medium rounded-full">
                {{ getStatusLabel(order.status) }}
              </span>
            </td>
            <td class="px-5 py-3.5 text-sm font-semibold text-gray-900 text-right">
              {{ formatPrice(order.total_amount, order.currency) }}
            </td>
          </tr>
          <tr v-if="!recentOrders.length">
            <td colspan="5" class="px-5 py-8 text-center text-sm text-gray-400">Aucune commande pour le moment</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import axios from 'axios';
import { formatPrice, formatDate, getStatusClass, getStatusLabel, initials } from '../../utils/format';

const stats = ref({
  total_orders: 0,
  total_users: 0,
  total_products: 0,
  pending_orders: 0,
});
const totalsByCurrency = ref([]);
const topProducts = ref([]);
const recentOrders = ref([]);

const icon = (path) => `<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="${path}" /></svg>`;

const statCards = computed(() => [
  {
    label: 'Commandes',
    value: stats.value.total_orders,
    icon: icon('M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z'),
    bg: 'bg-blue-50', color: 'text-blue-600',
    sub: `${stats.value.pending_orders} en attente`, subClass: 'text-amber-600',
  },
  {
    label: 'Clients',
    value: stats.value.total_users,
    icon: icon('M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z'),
    bg: 'bg-green-50', color: 'text-green-600',
  },
  {
    label: 'Produits',
    value: stats.value.total_products,
    icon: icon('M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4'),
    bg: 'bg-purple-50', color: 'text-purple-600',
  },
  {
    label: 'En attente',
    value: stats.value.pending_orders,
    icon: icon('M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z'),
    bg: 'bg-amber-50', color: 'text-amber-600',
    sub: 'À traiter', subClass: 'text-amber-600',
  },
]);

onMounted(async () => {
  try {
    const [dashRes, ordersRes] = await Promise.all([
      axios.get('/api/admin/dashboard'),
      axios.get('/api/admin/orders'),
    ]);
    stats.value = dashRes.data.stats;
    totalsByCurrency.value = dashRes.data.totals_by_currency;
    topProducts.value = dashRes.data.top_products;
    recentOrders.value = ordersRes.data.slice(0, 6);
  } catch (error) {
    console.error('Error loading dashboard:', error);
  }
});
</script>

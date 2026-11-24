<template>
  <div>
    <!-- Header -->
    <div class="flex items-center justify-between mb-6">
      <div>
        <h1 class="text-xl font-bold text-gray-900">Clients</h1>
        <p class="text-sm text-gray-500 mt-0.5">{{ users.length }} client(s) inscrit(s)</p>
      </div>
    </div>

    <!-- Table card -->
    <div class="bg-white rounded-xl border border-gray-200 overflow-hidden">
      <table class="min-w-full divide-y divide-gray-100">
        <thead>
          <tr class="bg-gray-50/60">
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Client</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Contact</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Commandes</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Inscrit le</th>
            <th class="px-5 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Total dépensé</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-100">
          <tr v-for="user in users" :key="user.id" class="hover:bg-gray-50/50 transition">
            <td class="px-5 py-3.5">
              <div class="flex items-center gap-2.5">
                <div class="w-9 h-9 rounded-full bg-green-100 text-green-700 flex items-center justify-center text-xs font-semibold">
                  {{ initials(user.name) }}
                </div>
                <p class="text-sm font-medium text-gray-900">{{ user.name }}</p>
              </div>
            </td>
            <td class="px-5 py-3.5">
              <div class="leading-tight">
                <p class="text-sm text-gray-700">{{ user.email }}</p>
                <p class="text-xs text-gray-500">{{ user.phone || '-' }}</p>
              </div>
            </td>
            <td class="px-5 py-3.5">
              <span class="text-xs font-medium text-gray-700 bg-gray-100 px-2.5 py-1 rounded-full">
                {{ user.orders_count }} commande(s)
              </span>
            </td>
            <td class="px-5 py-3.5 text-sm text-gray-600">{{ formatDate(user.created_at, { hour: undefined, minute: undefined }) }}</td>
            <td class="px-5 py-3.5 text-sm font-semibold text-gray-900 text-right">
              {{ formatPrice(user.total_spent, 'CDF', { minimumFractionDigits: 0, maximumFractionDigits: 0 }) }}
            </td>
          </tr>
          <tr v-if="!users.length">
            <td colspan="5" class="px-5 py-10 text-center text-sm text-gray-400">Aucun client pour le moment</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';
import { formatPrice, formatDate, initials } from '../../utils/format';

const users = ref([]);

const loadUsers = async () => {
  try {
    const response = await axios.get('/api/admin/users');
    users.value = response.data;
  } catch (error) {
    console.error('Error loading users:', error);
  }
};

onMounted(() => {
  loadUsers();
});
</script>

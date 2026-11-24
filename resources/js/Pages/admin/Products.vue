<template>
  <div>
    <!-- Header -->
    <div class="flex items-center justify-between mb-6">
      <div>
        <h1 class="text-xl font-bold text-gray-900">Produits</h1>
        <p class="text-sm text-gray-500 mt-0.5">{{ filteredProducts.length }} produit(s)</p>
      </div>
      <router-link
        to="/admin/products/create"
        class="flex items-center gap-1.5 px-4 py-2 text-sm font-medium text-white bg-green-600 rounded-lg hover:bg-green-700 transition"
      >
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
        </svg>
        Nouveau produit
      </router-link>
    </div>

    <!-- Table card -->
    <div class="bg-white rounded-xl border border-gray-200 overflow-hidden">
      <!-- Toolbar -->
      <div class="flex flex-col sm:flex-row gap-3 px-5 py-4 border-b border-gray-100">
        <div class="relative flex-1 max-w-sm">
          <svg class="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-4.35-4.35M17 10a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
          <input
            v-model="search"
            type="search"
            placeholder="Rechercher un produit..."
            class="w-full pl-9 pr-4 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
          >
        </div>
        <select
          v-model="filterCategory"
          class="px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
        >
          <option value="">Toutes les catégories</option>
          <option v-for="cat in categories" :key="cat.id" :value="cat.id">
            {{ cat.name }}
          </option>
        </select>
      </div>

      <table class="min-w-full divide-y divide-gray-100">
        <thead>
          <tr class="bg-gray-50/60">
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Produit</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Catégorie</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Stock</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Statut</th>
            <th class="px-5 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Prix</th>
            <th class="px-5 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-100">
          <tr v-for="product in filteredProducts" :key="product.id" class="hover:bg-gray-50/50 transition">
            <td class="px-5 py-3.5">
              <div class="flex items-center gap-3">
                <img
                  :src="product.images?.[0] || '/images/default-product.svg'"
                  class="w-10 h-10 object-cover rounded-lg border border-gray-100"
                  :alt="product.name"
                >
                <div class="leading-tight">
                  <p class="text-sm font-medium text-gray-900">{{ product.name }}</p>
                  <p class="text-xs text-gray-500 max-w-xs truncate">{{ product.description }}</p>
                </div>
              </div>
            </td>
            <td class="px-5 py-3.5 text-sm text-gray-600">{{ product.category?.name || '—' }}</td>
            <td class="px-5 py-3.5">
              <span :class="product.quantity > 0 ? 'text-gray-700' : 'text-red-600'" class="text-sm">
                {{ product.quantity }}
              </span>
            </td>
            <td class="px-5 py-3.5">
              <span
                :class="product.is_active ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'"
                class="px-2.5 py-1 text-xs font-medium rounded-full"
              >
                {{ product.is_active ? 'Actif' : 'Inactif' }}
              </span>
            </td>
            <td class="px-5 py-3.5 text-sm font-semibold text-gray-900 text-right">
              {{ formatPrice(product.price, product.currency) }}
            </td>
            <td class="px-5 py-3.5 text-right">
              <div class="flex items-center justify-end gap-1">
                <router-link
                  :to="`/admin/products/${product.id}/edit`"
                  class="p-2 text-gray-400 hover:text-green-600 hover:bg-green-50 rounded-lg transition"
                  title="Modifier"
                >
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                  </svg>
                </router-link>
                <button
                  @click="deleteProduct(product.id)"
                  class="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition"
                  title="Supprimer"
                >
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                  </svg>
                </button>
              </div>
            </td>
          </tr>
          <tr v-if="!filteredProducts.length">
            <td colspan="6" class="px-5 py-10 text-center text-sm text-gray-400">Aucun produit trouvé</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import axios from 'axios';
import { formatPrice } from '../../utils/format';

const products = ref([]);
const categories = ref([]);
const search = ref('');
const filterCategory = ref('');

const filteredProducts = computed(() => {
  let filtered = products.value;

  if (search.value) {
    filtered = filtered.filter(p =>
      p.name.toLowerCase().includes(search.value.toLowerCase())
    );
  }

  if (filterCategory.value) {
    filtered = filtered.filter(p => p.category_id === parseInt(filterCategory.value));
  }

  return filtered;
});

const loadProducts = async () => {
  try {
    const response = await axios.get('/api/admin/products');
    products.value = response.data;
  } catch (error) {
    console.error('Error loading products:', error);
  }
};

const loadCategories = async () => {
  try {
    const response = await axios.get('/api/admin/categories');
    categories.value = response.data;
  } catch (error) {
    console.error('Error loading categories:', error);
  }
};

const deleteProduct = async (id) => {
  if (confirm('Êtes-vous sûr de vouloir supprimer ce produit ?')) {
    try {
      await axios.delete(`/api/admin/products/${id}`);
      await loadProducts();
    } catch (error) {
      console.error('Error deleting product:', error);
      alert('Erreur lors de la suppression');
    }
  }
};

onMounted(() => {
  loadProducts();
  loadCategories();
});
</script>

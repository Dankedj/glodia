<template>
  <div class="container mx-auto px-4 py-8">
    <h1 class="text-xl font-bold text-gray-900 mb-6">
      {{ currentCategory ? currentCategory.name : 'Nos produits' }}
    </h1>
    <p v-if="currentCategory?.description" class="text-gray-600 mb-6">
      {{ currentCategory.description }}
    </p>

    <!-- Filters -->
    <div class="flex flex-col md:flex-row gap-4 mb-8">
      <input
        v-model="search"
        type="search"
        placeholder="Rechercher un produit..."
        class="flex-1 px-4 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:bg-white focus:outline-none focus:ring-2 focus:ring-green-500"
        @input="debouncedLoad"
      >
      <div class="flex gap-2 overflow-x-auto">
        <router-link
          to="/products"
          class="px-4 py-2 rounded-lg whitespace-nowrap"
          :class="!route.params.slug ? 'bg-green-600 text-white' : 'bg-white text-gray-700 hover:bg-gray-100'"
        >
          Tout
        </router-link>
        <router-link
          v-for="category in categories"
          :key="category.id"
          :to="`/category/${category.slug}`"
          class="px-4 py-2 rounded-lg whitespace-nowrap"
          :class="route.params.slug === category.slug ? 'bg-green-600 text-white' : 'bg-white text-gray-700 hover:bg-gray-100'"
        >
          {{ category.name }}
        </router-link>
      </div>
    </div>

    <!-- Products grid -->
    <div v-if="loading" class="text-center py-12">
      <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-green-600"></div>
    </div>

    <div v-else-if="products.length === 0" class="text-center py-12 bg-white rounded-xl border border-gray-200">
      <p class="text-gray-500 text-lg">Aucun produit trouvé</p>
    </div>

    <div v-else class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
      <div
        v-for="product in products"
        :key="product.id"
        class="bg-white rounded-xl border border-gray-200 overflow-hidden hover:border-gray-300 transition"
      >
        <router-link :to="`/products/${product.slug}`">
          <img
            :src="product.images?.[0] || '/images/default-product.svg'"
            :alt="product.name"
            class="w-full h-48 object-cover"
          >
        </router-link>
        <div class="p-4">
          <router-link :to="`/products/${product.slug}`" class="font-semibold text-lg mb-1 block hover:text-green-600">
            {{ product.name }}
          </router-link>
          <p class="text-gray-600 text-sm mb-2">{{ product.description?.substring(0, 80) }}...</p>
          <p class="text-xs text-gray-500 mb-3">
            {{ product.quantity > 0 ? `${product.quantity} en stock` : 'Rupture de stock' }}
          </p>
          <div class="flex justify-between items-center">
            <span class="text-xl font-bold text-green-600">
              {{ formatPrice(product.price, product.currency) }}
            </span>
            <button
              @click="addToCart(product)"
              :disabled="product.quantity === 0"
              class="bg-green-600 text-white px-3 py-2 text-sm font-medium rounded-lg hover:bg-green-700 disabled:opacity-50 disabled:cursor-not-allowed text-sm"
            >
              Ajouter
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios';
import { useCartStore } from '../../stores/cart';
import { useAuthStore } from '../../stores/auth';
import { formatPrice } from '../../utils/format';

const route = useRoute();
const router = useRouter();
const cartStore = useCartStore();
const authStore = useAuthStore();

const categories = ref([]);
const products = ref([]);
const search = ref('');
const loading = ref(true);

const currentCategory = computed(() =>
  categories.value.find(c => c.slug === route.params.slug) || null
);

let debounceTimer = null;
const debouncedLoad = () => {
  clearTimeout(debounceTimer);
  debounceTimer = setTimeout(loadProducts, 300);
};

const loadCategories = async () => {
  try {
    const response = await axios.get('/api/public/categories');
    categories.value = response.data;
  } catch (error) {
    console.error('Error loading categories:', error);
  }
};

const loadProducts = async () => {
  loading.value = true;
  try {
    const params = {};
    if (search.value) params.search = search.value;

    const response = route.params.slug
      ? await axios.get(`/api/public/categories/${route.params.slug}/products`, { params })
      : await axios.get('/api/public/products', { params });

    products.value = response.data;
  } catch (error) {
    console.error('Error loading products:', error);
    products.value = [];
  } finally {
    loading.value = false;
  }
};

const addToCart = async (product) => {
  if (!authStore.isAuthenticated) {
    router.push('/login');
    return;
  }
  try {
    await cartStore.addItem(product.id);
    alert('Produit ajouté au panier');
  } catch (error) {
    alert(error.response?.data?.message || 'Erreur lors de l\'ajout au panier');
  }
};

watch(() => route.params.slug, loadProducts);

onMounted(() => {
  loadCategories();
  loadProducts();
});
</script>

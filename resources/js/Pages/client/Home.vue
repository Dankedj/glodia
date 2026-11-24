<template>
  <div class="container mx-auto px-4 py-8">
    <!-- Hero -->
    <div class="relative bg-green-50 border border-green-100 rounded-2xl overflow-hidden mb-14">
      <div class="grid lg:grid-cols-2 gap-8 items-center px-8 py-12 lg:px-14">
        <div>
          <span class="inline-flex items-center gap-1.5 px-3 py-1 text-xs font-semibold text-green-700 bg-green-100 rounded-full mb-5">
            <span class="w-1.5 h-1.5 bg-green-600 rounded-full"></span>
            Ferme locale · Produits du jour
          </span>
          <h1 class="text-3xl lg:text-4xl font-bold text-gray-900 leading-tight mb-4">
            Des produits fermiers frais,<br>
            <span class="text-green-600">directement à votre table</span>
          </h1>
          <p class="text-gray-600 mb-7 max-w-md">
            Fruits, légumes, volaille et produits laitiers récoltés chaque jour dans notre ferme. Qualité garantie, sans intermédiaire.
          </p>
          <div class="flex flex-wrap gap-3">
            <router-link
              to="/products"
              class="inline-flex items-center gap-2 px-5 py-2.5 text-sm font-semibold text-white bg-green-600 rounded-lg hover:bg-green-700 transition"
            >
              Découvrir nos produits
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3" />
              </svg>
            </router-link>
            <a
              href="#categories"
              class="inline-flex items-center px-5 py-2.5 text-sm font-semibold text-green-700 bg-white border border-green-200 rounded-lg hover:bg-green-100/60 transition"
            >
              Voir les catégories
            </a>
          </div>
        </div>

        <!-- Collage d'images produits -->
        <div class="hidden lg:grid grid-cols-2 gap-4">
          <div
            v-for="(product, i) in heroProducts"
            :key="product.id"
            :class="i % 2 === 1 ? 'mt-8' : ''"
            class="bg-white rounded-xl border border-green-100 overflow-hidden"
          >
            <router-link :to="`/products/${product.slug}`">
              <img
                :src="product.images?.[0] || '/images/default-product.svg'"
                :alt="product.name"
                class="w-full h-36 object-cover"
              >
              <div class="px-3 py-2.5">
                <p class="text-xs font-semibold text-gray-900 truncate">{{ product.name }}</p>
                <p class="text-xs font-medium text-green-600">{{ formatPrice(product.price, product.currency) }}</p>
              </div>
            </router-link>
          </div>
        </div>
      </div>
    </div>

    <!-- Catégories -->
    <div id="categories" class="mb-14">
      <div class="flex items-end justify-between mb-5">
        <div>
          <h2 class="text-xl font-bold text-gray-900">Nos catégories</h2>
          <p class="text-sm text-gray-500 mt-0.5">Parcourez nos produits par famille</p>
        </div>
      </div>
      <div class="flex flex-wrap gap-3">
        <router-link
          v-for="category in categories"
          :key="category.id"
          :to="`/category/${category.slug}`"
          class="group inline-flex items-center gap-2.5 pl-2 pr-4 py-2 bg-white border border-gray-200 rounded-full hover:border-green-300 hover:bg-green-50/50 transition"
        >
          <span class="w-8 h-8 flex items-center justify-center bg-green-50 text-green-600 rounded-full group-hover:bg-green-100 transition">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l5 5a2 2 0 01.586 1.414V19a2 2 0 01-2 2H7a2 2 0 01-2-2V5a2 2 0 012-2z" />
            </svg>
          </span>
          <span class="text-sm font-medium text-gray-800">{{ category.name }}</span>
          <span class="text-xs text-gray-400">{{ category.products_count }}</span>
        </router-link>
      </div>
    </div>

    <!-- Produits -->
    <div class="mb-14">
      <div class="flex items-end justify-between mb-5">
        <div>
          <h2 class="text-xl font-bold text-gray-900">Produits populaires</h2>
          <p class="text-sm text-gray-500 mt-0.5">Les favoris de nos clients</p>
        </div>
        <router-link to="/products" class="text-sm font-medium text-green-600 hover:text-green-700 transition">
          Tout voir →
        </router-link>
      </div>

      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
        <div
          v-for="product in products"
          :key="product.id"
          class="group bg-white rounded-xl border border-gray-200 overflow-hidden hover:border-green-300 hover:shadow-sm transition"
        >
          <router-link :to="`/products/${product.slug}`" class="relative block">
            <img
              :src="product.images?.[0] || '/images/default-product.svg'"
              :alt="product.name"
              class="w-full h-44 object-cover"
            >
            <span
              v-if="product.quantity === 0"
              class="absolute top-2.5 left-2.5 px-2.5 py-1 text-xs font-medium text-red-700 bg-red-50 border border-red-100 rounded-full"
            >
              Épuisé
            </span>
            <span
              v-else-if="product.category"
              class="absolute top-2.5 left-2.5 px-2.5 py-1 text-xs font-medium text-gray-600 bg-white/90 backdrop-blur border border-gray-100 rounded-full"
            >
              {{ product.category.name }}
            </span>
          </router-link>
          <div class="p-4">
            <router-link :to="`/products/${product.slug}`" class="text-sm font-semibold text-gray-900 hover:text-green-600 transition line-clamp-1">
              {{ product.name }}
            </router-link>
            <p class="text-xs text-gray-500 mt-1 line-clamp-2 min-h-[2rem]">{{ product.description }}</p>
            <div class="flex items-center justify-between mt-3">
              <span class="text-base font-bold text-gray-900">
                {{ formatPrice(product.price, product.currency) }}
              </span>
              <button
                @click="addToCart(product)"
                :disabled="product.quantity === 0 || addingId === product.id"
                class="inline-flex items-center gap-1.5 px-3 py-1.5 text-xs font-semibold text-white bg-green-600 rounded-lg hover:bg-green-700 disabled:opacity-40 disabled:cursor-not-allowed transition"
              >
                <svg v-if="addingId !== product.id" class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                </svg>
                {{ addingId === product.id ? '...' : 'Ajouter' }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Bandeau confiance -->
    <div class="grid sm:grid-cols-3 gap-4 mb-14">
      <div
        v-for="feature in features"
        :key="feature.title"
        class="flex items-start gap-3.5 bg-white rounded-xl border border-gray-200 p-5"
      >
        <span class="w-10 h-10 flex items-center justify-center bg-green-50 text-green-600 rounded-lg shrink-0" v-html="feature.icon"></span>
        <div>
          <p class="text-sm font-semibold text-gray-900">{{ feature.title }}</p>
          <p class="text-xs text-gray-500 mt-0.5">{{ feature.text }}</p>
        </div>
      </div>
    </div>

    <!-- CTA final -->
    <div class="bg-gray-900 rounded-2xl px-8 py-10 text-center">
      <h2 class="text-2xl font-bold text-white mb-2">Prêt à commander ?</h2>
      <p class="text-sm text-gray-400 mb-6">Livraison rapide sur commande · Paiement à la livraison</p>
      <router-link
        to="/products"
        class="inline-flex items-center gap-2 px-6 py-2.5 text-sm font-semibold text-gray-900 bg-white rounded-lg hover:bg-gray-100 transition"
      >
        Commander maintenant
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3" />
        </svg>
      </router-link>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';
import { useCartStore } from '../../stores/cart';
import { useAuthStore } from '../../stores/auth';
import { formatPrice } from '../../utils/format';

const router = useRouter();
const cartStore = useCartStore();
const authStore = useAuthStore();
const categories = ref([]);
const products = ref([]);
const addingId = ref(null);

const heroProducts = computed(() => products.value.slice(0, 4));

const features = [
  {
    title: 'Fraîcheur garantie',
    text: 'Récolté le jour même, livré rapidement',
    icon: '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"/></svg>',
  },
  {
    title: 'Producteurs locaux',
    text: 'Sans intermédiaire, de notre ferme à vous',
    icon: '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>',
  },
  {
    title: 'Paiement à la livraison',
    text: 'Reçu fourni pour chaque commande',
    icon: '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/></svg>',
  },
];

const addToCart = async (product) => {
  if (product.quantity === 0) return;
  if (!authStore.isAuthenticated) {
    router.push('/login');
    return;
  }
  addingId.value = product.id;
  try {
    await cartStore.addItem(product.id);
  } catch (error) {
    alert(error.response?.data?.message || 'Erreur lors de l\'ajout au panier');
  } finally {
    addingId.value = null;
  }
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
  try {
    const response = await axios.get('/api/public/products');
    products.value = response.data.slice(0, 8);
  } catch (error) {
    console.error('Error loading products:', error);
  }
};

onMounted(() => {
  loadCategories();
  loadProducts();
});
</script>

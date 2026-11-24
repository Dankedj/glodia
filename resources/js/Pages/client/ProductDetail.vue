<template>
  <div class="container mx-auto px-4 py-8">
    <div v-if="loading" class="text-center py-12">
      <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-green-600"></div>
    </div>
    
    <div v-else-if="product" class="bg-white rounded-xl border border-gray-200 overflow-hidden">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-8 p-6">
        <!-- Images Gallery -->
        <div>
          <div class="mb-4">
            <img 
              :src="currentImage" 
              :alt="product.name"
              class="w-full h-96 object-cover rounded-lg"
            >
          </div>
          <div class="flex gap-2 overflow-x-auto">
            <img
              v-for="(image, index) in product.images"
              :key="index"
              :src="image"
              :alt="product.name"
              class="w-20 h-20 object-cover rounded cursor-pointer hover:opacity-75"
              :class="{ 'border-2 border-green-600': currentImage === image }"
              @click="currentImage = image"
            >
          </div>
        </div>

        <!-- Product Info -->
        <div>
          <h1 class="text-3xl font-bold text-gray-900 mb-2">{{ product.name }}</h1>
          <div class="flex items-center gap-2 mb-4">
            <span class="text-sm text-gray-500">Catégorie:</span>
            <router-link 
              :to="`/category/${product.category?.slug}`" 
              class="text-green-600 hover:underline"
            >
              {{ product.category?.name }}
            </router-link>
          </div>
          
          <div class="mb-4">
            <span class="text-3xl font-bold text-green-600">
              {{ formatPrice(product.price, product.currency) }}
            </span>
            <span class="text-sm text-gray-500 ml-2">
              {{ product.currency === 'CDF' ? 'Francs Congolais' : 'Dollars US' }}
            </span>
          </div>

          <div class="mb-4">
            <div class="flex items-center gap-2">
              <span class="text-sm font-medium">Disponibilité:</span>
              <span :class="product.quantity > 0 ? 'text-green-600' : 'text-red-600'" class="font-semibold">
                {{ product.quantity > 0 ? `En stock (${product.quantity} unités)` : 'Rupture de stock' }}
              </span>
            </div>
          </div>

          <div class="mb-6">
            <h3 class="font-semibold mb-2">Description</h3>
            <p class="text-gray-700 whitespace-pre-line">{{ product.description }}</p>
          </div>

          <div class="flex items-center gap-4 mb-6">
            <div class="flex items-center border border-gray-200 rounded-lg">
              <button 
                @click="decrementQuantity"
                :disabled="quantity <= 1"
                class="px-3 py-2 hover:bg-gray-100 disabled:opacity-50"
              >
                -
              </button>
              <span class="px-4 py-2 border-x">{{ quantity }}</span>
              <button 
                @click="incrementQuantity"
                :disabled="quantity >= product.quantity"
                class="px-3 py-2 hover:bg-gray-100 disabled:opacity-50"
              >
                +
              </button>
            </div>
            
            <button
              @click="addToCart"
              :disabled="product.quantity === 0"
              class="flex-1 bg-green-600 text-white px-6 py-3 text-sm font-medium rounded-lg hover:bg-green-700 disabled:opacity-50 disabled:cursor-not-allowed transition"
            >
              Ajouter au panier
            </button>
          </div>

          <div class="border-t border-gray-100 pt-4">
            <div class="flex items-center gap-2 text-sm text-gray-600">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
              </svg>
              <span>Livraison gratuite à partir de 50$</span>
            </div>
            <div class="flex items-center gap-2 text-sm text-gray-600 mt-2">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
              </svg>
              <span>Paiement sécurisé</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div v-else class="text-center py-12">
      <p class="text-gray-500">Produit non trouvé</p>
      <router-link to="/" class="text-green-600 hover:underline mt-2 inline-block">
        Retour à l'accueil
      </router-link>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios';
import { useCartStore } from '../../stores/cart';
import { useAuthStore } from '../../stores/auth';
import { formatPrice } from '../../utils/format';

const route = useRoute();
const router = useRouter();
const cartStore = useCartStore();
const authStore = useAuthStore();

const product = ref(null);
const loading = ref(true);
const quantity = ref(1);
const currentImage = ref('/images/default-product.svg');

const incrementQuantity = () => {
  if (product.value && quantity.value < product.value.quantity) {
    quantity.value++;
  }
};

const decrementQuantity = () => {
  if (quantity.value > 1) {
    quantity.value--;
  }
};

const addToCart = async () => {
  if (!product.value || product.value.quantity === 0) return;
  if (!authStore.isAuthenticated) {
    router.push('/login');
    return;
  }

  try {
    await cartStore.addItem(product.value.id, quantity.value);
    alert(`${quantity.value} x ${product.value.name} ajouté au panier`);
    quantity.value = 1;
  } catch (error) {
    console.error('Error adding to cart:', error);
    alert(error.response?.data?.message || 'Erreur lors de l\'ajout au panier');
  }
};

const loadProduct = async () => {
  loading.value = true;
  try {
    const slug = route.params.slug;
    const response = await axios.get(`/api/public/products/${slug}`);
    product.value = response.data;
    currentImage.value = product.value.images?.[0] || '/images/default-product.svg';
  } catch (error) {
    console.error('Error loading product:', error);
    product.value = null;
  } finally {
    loading.value = false;
  }
};

onMounted(() => {
  loadProduct();
});
</script>
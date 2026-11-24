<template>
  <div class="min-h-screen bg-gray-50 flex flex-col">
    <!-- Header -->
    <header class="sticky top-0 z-20 bg-white border-b border-gray-200">
      <nav class="container mx-auto px-4 h-16 flex items-center gap-6">
        <!-- Logo -->
        <router-link to="/" class="flex items-center gap-2.5 shrink-0">
          <div class="w-8 h-8 rounded-full bg-green-600 flex items-center justify-center">
            <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
            </svg>
          </div>
          <span class="text-lg font-bold text-gray-900">Glodia <span class="text-green-600">Ferme</span></span>
        </router-link>

        <!-- Nav links -->
        <div class="hidden md:flex items-center gap-1">
          <router-link
            to="/"
            class="px-3 py-2 text-sm text-gray-600 rounded-lg hover:bg-gray-50 hover:text-gray-900 transition"
            active-class="text-green-700 font-medium"
          >
            Accueil
          </router-link>
          <router-link
            to="/products"
            class="px-3 py-2 text-sm text-gray-600 rounded-lg hover:bg-gray-50 hover:text-gray-900 transition"
            active-class="text-green-700 font-medium"
          >
            Produits
          </router-link>
        </div>

        <div class="flex items-center gap-2 ml-auto">
          <!-- Cart -->
          <router-link
            to="/cart"
            class="relative p-2 text-gray-500 hover:text-gray-900 hover:bg-gray-50 rounded-lg transition"
            title="Panier"
          >
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
            </svg>
            <span
              v-if="cartStore.totalItems > 0"
              class="absolute -top-0.5 -right-0.5 bg-green-600 text-white text-[10px] font-semibold rounded-full min-w-4 h-4 px-1 flex items-center justify-center"
            >
              {{ cartStore.totalItems }}
            </span>
          </router-link>

          <!-- User menu -->
          <div v-if="authStore.isAuthenticated" class="relative">
            <button
              @click="showDropdown = !showDropdown"
              class="flex items-center gap-2.5 pl-1 pr-2 py-1 rounded-lg hover:bg-gray-50 transition"
            >
              <div class="w-8 h-8 rounded-full bg-green-100 text-green-700 flex items-center justify-center text-xs font-semibold">
                {{ initials }}
              </div>
              <span class="hidden sm:block text-sm font-medium text-gray-700">{{ authStore.user?.name }}</span>
              <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
              </svg>
            </button>

            <div
              v-if="showDropdown"
              class="absolute right-0 mt-2 w-48 bg-white rounded-xl border border-gray-200 py-1.5 z-30"
            >
              <router-link
                v-if="authStore.isAdmin"
                to="/admin/dashboard"
                class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50"
                @click="showDropdown = false"
              >
                Administration
              </router-link>
              <router-link
                to="/profile"
                class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50"
                @click="showDropdown = false"
              >
                Mon profil
              </router-link>
              <router-link
                to="/orders"
                class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50"
                @click="showDropdown = false"
              >
                Mes commandes
              </router-link>
              <hr class="my-1.5 border-gray-100">
              <button
                @click="logout"
                class="block w-full text-left px-4 py-2 text-sm text-red-600 hover:bg-red-50"
              >
                Déconnexion
              </button>
            </div>
          </div>

          <!-- Auth buttons -->
          <div v-else class="flex items-center gap-2">
            <router-link
              to="/login"
              class="px-3.5 py-2 text-sm font-medium text-gray-700 border border-gray-200 rounded-lg hover:bg-gray-50 transition"
            >
              Connexion
            </router-link>
            <router-link
              to="/register"
              class="px-3.5 py-2 text-sm font-medium text-white bg-green-600 rounded-lg hover:bg-green-700 transition"
            >
              Inscription
            </router-link>
          </div>
        </div>
      </nav>
    </header>

    <!-- Main Content -->
    <main class="flex-1" @click="showDropdown = false">
      <router-view />
    </main>

    <!-- Footer -->
    <footer class="bg-white border-t border-gray-200 mt-12">
      <div class="container mx-auto px-4 py-6 flex flex-col sm:flex-row items-center justify-between gap-2">
        <div class="flex items-center gap-2">
          <div class="w-6 h-6 rounded-full bg-green-600 flex items-center justify-center">
            <svg class="w-3.5 h-3.5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
            </svg>
          </div>
          <span class="text-sm font-medium text-gray-700">Glodia Ferme</span>
        </div>
        <p class="text-sm text-gray-500">&copy; {{ new Date().getFullYear() }} — Produits fermiers de qualité, du champ à votre table</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { useAuthStore } from '../stores/auth';
import { useCartStore } from '../stores/cart';
import { initials as getInitials } from '../utils/format';

const showDropdown = ref(false);
const router = useRouter();
const authStore = useAuthStore();
const cartStore = useCartStore();

const initials = computed(() => getInitials(authStore.user?.name));

const logout = async () => {
  await authStore.logout();
  router.push('/');
};

watch(
  () => authStore.isAuthenticated,
  (isAuth) => {
    if (isAuth) {
      cartStore.fetchCart();
    } else {
      cartStore.items = [];
      cartStore.totalItems = 0;
      cartStore.totalAmount = 0;
    }
  }
);

onMounted(() => {
  if (authStore.isAuthenticated) {
    cartStore.fetchCart();
  }
});
</script>

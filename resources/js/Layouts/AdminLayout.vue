<template>
  <div class="min-h-screen bg-gray-100 flex">
    <!-- Sidebar -->
    <aside class="fixed inset-y-0 left-0 w-60 bg-white border-r border-gray-200 flex flex-col z-20">
      <!-- Logo -->
      <div class="flex items-center gap-2.5 h-16 px-5 border-b border-gray-100">
        <div class="w-8 h-8 rounded-full bg-green-600 flex items-center justify-center">
          <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
          </svg>
        </div>
        <span class="text-lg font-bold text-gray-900">Glodia <span class="text-green-600">Ferme</span></span>
      </div>

      <!-- Nav -->
      <nav class="flex-1 px-3 py-5 overflow-y-auto">
        <p class="px-3 mb-2 text-xs font-semibold text-gray-400 uppercase tracking-wider">Menu</p>
        <router-link
          v-for="item in menuItems"
          :key="item.to"
          :to="item.to"
          class="flex items-center gap-3 px-3 py-2 mb-0.5 text-sm text-gray-600 rounded-lg hover:bg-gray-50 hover:text-gray-900 transition"
          active-class="!bg-green-50 !text-green-700 font-medium"
        >
          <span v-html="item.icon" class="w-5 h-5 shrink-0"></span>
          {{ item.label }}
        </router-link>

        <p class="px-3 mt-6 mb-2 text-xs font-semibold text-gray-400 uppercase tracking-wider">Boutique</p>
        <router-link
          to="/"
          class="flex items-center gap-3 px-3 py-2 mb-0.5 text-sm text-gray-600 rounded-lg hover:bg-gray-50 hover:text-gray-900 transition"
        >
          <svg class="w-5 h-5 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
          </svg>
          Voir la boutique
        </router-link>
        <button
          @click="logout"
          class="flex items-center gap-3 w-full px-3 py-2 text-sm text-gray-600 rounded-lg hover:bg-red-50 hover:text-red-600 transition"
        >
          <svg class="w-5 h-5 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
          </svg>
          Déconnexion
        </button>
      </nav>
    </aside>

    <!-- Main -->
    <div class="flex-1 ml-60 flex flex-col min-h-screen">
      <!-- Topbar -->
      <header class="sticky top-0 z-10 h-16 bg-white border-b border-gray-200 flex items-center gap-4 px-6">
        <div class="relative flex-1 max-w-md">
          <svg class="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-4.35-4.35M17 10a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
          <input
            type="search"
            placeholder="Rechercher..."
            class="w-full pl-9 pr-4 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
          >
        </div>

        <div class="flex items-center gap-3 ml-auto">
          <router-link
            to="/admin/products/create"
            class="hidden sm:flex items-center gap-1.5 px-3.5 py-2 text-sm font-medium text-white bg-green-600 rounded-lg hover:bg-green-700 transition"
          >
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
            </svg>
            Nouveau produit
          </router-link>

          <div class="h-6 w-px bg-gray-200"></div>

          <div class="flex items-center gap-2.5">
            <div class="w-9 h-9 rounded-full bg-green-100 text-green-700 flex items-center justify-center text-sm font-semibold">
              {{ initials }}
            </div>
            <div class="hidden md:block leading-tight">
              <p class="text-sm font-medium text-gray-900">{{ authStore.user?.name }}</p>
              <p class="text-xs text-gray-500">Administrateur</p>
            </div>
          </div>
        </div>
      </header>

      <!-- Content -->
      <main class="flex-1 p-6">
        <router-view />
      </main>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue';
import { useRouter } from 'vue-router';
import { useAuthStore } from '../stores/auth';

const router = useRouter();
const authStore = useAuthStore();

const initials = computed(() => {
  const name = authStore.user?.name || 'A';
  return name.split(' ').map(w => w[0]).slice(0, 2).join('').toUpperCase();
});

const icons = {
  dashboard: '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zm10 0a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zm10 0a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z" /></svg>',
  products: '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" /></svg>',
  categories: '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l5 5a2 2 0 01.586 1.414V19a2 2 0 01-2 2H7a2 2 0 01-2-2V5a2 2 0 012-2z" /></svg>',
  orders: '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" /></svg>',
  users: '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" /></svg>',
};

const menuItems = [
  { to: '/admin/dashboard', label: 'Dashboard', icon: icons.dashboard },
  { to: '/admin/products', label: 'Produits', icon: icons.products },
  { to: '/admin/categories', label: 'Catégories', icon: icons.categories },
  { to: '/admin/orders', label: 'Commandes', icon: icons.orders },
  { to: '/admin/users', label: 'Clients', icon: icons.users },
];

const logout = async () => {
  await authStore.logout();
  router.push('/login');
};
</script>

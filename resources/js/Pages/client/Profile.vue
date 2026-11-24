<template>
  <div class="container mx-auto px-4 py-8 max-w-3xl">
    <div class="mb-6">
      <h1 class="text-xl font-bold text-gray-900">Mon profil</h1>
      <p class="text-sm text-gray-500 mt-0.5">Gérez vos informations personnelles</p>
    </div>

    <!-- Profile card -->
    <div class="bg-white rounded-xl border border-gray-200 overflow-hidden">
      <div class="flex items-center gap-4 px-6 py-5 border-b border-gray-100 bg-gray-50/60">
        <div class="w-14 h-14 rounded-full bg-green-100 text-green-700 flex items-center justify-center text-lg font-bold">
          {{ initials }}
        </div>
        <div>
          <p class="text-base font-semibold text-gray-900">{{ form.name || authStore.user?.name }}</p>
          <p class="text-sm text-gray-500">{{ authStore.user?.email }}</p>
        </div>
      </div>

      <form @submit.prevent="updateProfile" class="p-6">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1.5">Nom complet</label>
            <input
              v-model="form.name"
              type="text"
              required
              class="w-full px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
            >
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1.5">Email</label>
            <input
              v-model="form.email"
              type="email"
              required
              class="w-full px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
            >
          </div>

          <div class="md:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-1.5">Téléphone</label>
            <input
              v-model="form.phone"
              type="tel"
              class="w-full px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
            >
          </div>

          <div class="md:col-span-2">
            <label class="block text-sm font-medium text-gray-700 mb-1.5">Adresse</label>
            <textarea
              v-model="form.address"
              rows="3"
              class="w-full px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
            ></textarea>
          </div>
        </div>

        <div class="mt-6 pt-5 border-t border-gray-100 flex items-center justify-between">
          <div>
            <p v-if="success" class="text-sm text-green-600 font-medium flex items-center gap-1.5">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
              </svg>
              Profil mis à jour avec succès
            </p>
            <p v-if="error" class="text-sm text-red-600">{{ error }}</p>
          </div>
          <button
            type="submit"
            :disabled="loading"
            class="px-4 py-2 text-sm font-medium text-white bg-green-600 rounded-lg hover:bg-green-700 disabled:opacity-50 transition"
          >
            {{ loading ? 'Enregistrement...' : 'Mettre à jour' }}
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import axios from 'axios';
import { useAuthStore } from '../../stores/auth';
import { initials as getInitials } from '../../utils/format';

const authStore = useAuthStore();
const loading = ref(false);
const success = ref(false);
const error = ref('');

const initials = computed(() => getInitials(form.value.name || authStore.user?.name));

const form = ref({
  name: '',
  email: '',
  phone: '',
  address: '',
});

const loadProfile = async () => {
  try {
    const response = await axios.get('/api/profile');
    form.value = {
      name: response.data.name,
      email: response.data.email,
      phone: response.data.phone || '',
      address: response.data.address || '',
    };
  } catch (err) {
    console.error('Error loading profile:', err);
  }
};

const updateProfile = async () => {
  loading.value = true;
  success.value = false;
  error.value = '';

  try {
    await axios.put('/api/profile', form.value);
    success.value = true;
    authStore.user = { ...authStore.user, ...form.value };
    setTimeout(() => {
      success.value = false;
    }, 3000);
  } catch (err) {
    error.value = 'Erreur lors de la mise à jour du profil';
    console.error('Error updating profile:', err);
  } finally {
    loading.value = false;
  }
};

onMounted(() => {
  loadProfile();
});
</script>

<template>
  <div>
    <!-- Header -->
    <div class="flex items-center justify-between mb-6">
      <div>
        <h1 class="text-xl font-bold text-gray-900">Catégories</h1>
        <p class="text-sm text-gray-500 mt-0.5">{{ categories.length }} catégorie(s)</p>
      </div>
      <button
        @click="openModal()"
        class="flex items-center gap-1.5 px-4 py-2 text-sm font-medium text-white bg-green-600 rounded-lg hover:bg-green-700 transition"
      >
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
        </svg>
        Nouvelle catégorie
      </button>
    </div>

    <!-- Table card -->
    <div class="bg-white rounded-xl border border-gray-200 overflow-hidden">
      <table class="min-w-full divide-y divide-gray-100">
        <thead>
          <tr class="bg-gray-50/60">
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nom</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Description</th>
            <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Produits</th>
            <th class="px-5 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-100">
          <tr v-for="category in categories" :key="category.id" class="hover:bg-gray-50/50 transition">
            <td class="px-5 py-3.5">
              <div class="flex items-center gap-2.5">
                <div class="w-9 h-9 rounded-lg bg-green-50 text-green-600 flex items-center justify-center">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l5 5a2 2 0 01.586 1.414V19a2 2 0 01-2 2H7a2 2 0 01-2-2V5a2 2 0 012-2z" />
                  </svg>
                </div>
                <p class="text-sm font-medium text-gray-900">{{ category.name }}</p>
              </div>
            </td>
            <td class="px-5 py-3.5 text-sm text-gray-600 max-w-md truncate">{{ category.description || '—' }}</td>
            <td class="px-5 py-3.5">
              <span class="text-xs font-medium text-gray-700 bg-gray-100 px-2.5 py-1 rounded-full">
                {{ category.products_count }} produit(s)
              </span>
            </td>
            <td class="px-5 py-3.5 text-right">
              <div class="flex items-center justify-end gap-1">
                <button
                  @click="openModal(category)"
                  class="p-2 text-gray-400 hover:text-green-600 hover:bg-green-50 rounded-lg transition"
                  title="Modifier"
                >
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                  </svg>
                </button>
                <button
                  @click="deleteCategory(category.id)"
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
          <tr v-if="!categories.length">
            <td colspan="4" class="px-5 py-10 text-center text-sm text-gray-400">Aucune catégorie</td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Modal -->
    <div v-if="showModal" class="fixed inset-0 bg-black/40 flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-xl w-full max-w-md border border-gray-200">
        <div class="border-b border-gray-100 px-6 py-4 flex justify-between items-center">
          <h2 class="text-lg font-bold text-gray-900">{{ editingCategory ? 'Modifier' : 'Nouvelle' }} catégorie</h2>
          <button @click="closeModal" class="p-1.5 text-gray-400 hover:text-gray-600 hover:bg-gray-100 rounded-lg transition">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>

        <form @submit.prevent="saveCategory" class="p-6">
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-1.5">Nom</label>
            <input
              v-model="form.name"
              type="text"
              required
              class="w-full px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
            >
          </div>

          <div class="mb-5">
            <label class="block text-sm font-medium text-gray-700 mb-1.5">Description</label>
            <textarea
              v-model="form.description"
              rows="3"
              class="w-full px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
            ></textarea>
          </div>

          <div class="flex justify-end gap-2">
            <button
              type="button"
              @click="closeModal"
              class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-200 rounded-lg hover:bg-gray-50 transition"
            >
              Annuler
            </button>
            <button
              type="submit"
              :disabled="loading"
              class="px-4 py-2 text-sm font-medium text-white bg-green-600 rounded-lg hover:bg-green-700 disabled:opacity-50 transition"
            >
              {{ loading ? 'Enregistrement...' : 'Enregistrer' }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';

const categories = ref([]);
const showModal = ref(false);
const editingCategory = ref(null);
const loading = ref(false);
const form = ref({
  name: '',
  description: '',
});

const loadCategories = async () => {
  try {
    const response = await axios.get('/api/admin/categories');
    categories.value = response.data;
  } catch (error) {
    console.error('Error loading categories:', error);
  }
};

const openModal = (category = null) => {
  if (category) {
    editingCategory.value = category;
    form.value = {
      name: category.name,
      description: category.description || '',
    };
  } else {
    editingCategory.value = null;
    form.value = {
      name: '',
      description: '',
    };
  }
  showModal.value = true;
};

const closeModal = () => {
  showModal.value = false;
  editingCategory.value = null;
  form.value = {
    name: '',
    description: '',
  };
};

const saveCategory = async () => {
  loading.value = true;

  try {
    if (editingCategory.value) {
      await axios.put(`/api/admin/categories/${editingCategory.value.id}`, form.value);
    } else {
      await axios.post('/api/admin/categories', form.value);
    }
    await loadCategories();
    closeModal();
  } catch (error) {
    console.error('Error saving category:', error);
    alert('Erreur lors de l\'enregistrement');
  } finally {
    loading.value = false;
  }
};

const deleteCategory = async (id) => {
  if (confirm('Êtes-vous sûr de vouloir supprimer cette catégorie ?')) {
    try {
      await axios.delete(`/api/admin/categories/${id}`);
      await loadCategories();
    } catch (error) {
      console.error('Error deleting category:', error);
      alert('Erreur lors de la suppression');
    }
  }
};

onMounted(() => {
  loadCategories();
});
</script>

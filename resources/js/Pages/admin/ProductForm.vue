<template>
  <div class="max-w-3xl">
    <!-- Header -->
    <div class="flex items-center gap-3 mb-6">
      <router-link
        to="/admin/products"
        class="p-2 text-gray-400 hover:text-gray-600 hover:bg-gray-100 rounded-lg transition"
      >
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
        </svg>
      </router-link>
      <div>
        <h1 class="text-xl font-bold text-gray-900">
          {{ isEditing ? 'Modifier le produit' : 'Nouveau produit' }}
        </h1>
        <p class="text-sm text-gray-500 mt-0.5">
          {{ isEditing ? 'Mettez à jour les informations du produit' : 'Ajoutez un produit à votre catalogue' }}
        </p>
      </div>
    </div>

    <form @submit.prevent="saveProduct" class="bg-white rounded-xl border border-gray-200 p-6">
      <div class="grid grid-cols-2 gap-5">
        <div class="col-span-2">
          <label class="block text-sm font-medium text-gray-700 mb-1.5">Nom du produit</label>
          <input
            v-model="form.name"
            type="text"
            required
            class="w-full px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
          >
        </div>

        <div class="col-span-2">
          <label class="block text-sm font-medium text-gray-700 mb-1.5">Description</label>
          <textarea
            v-model="form.description"
            rows="4"
            required
            class="w-full px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
          ></textarea>
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1.5">Prix</label>
          <input
            v-model="form.price"
            type="number"
            step="0.01"
            min="0"
            required
            class="w-full px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
          >
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1.5">Devise</label>
          <select
            v-model="form.currency"
            class="w-full px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
          >
            <option value="CDF">Franc Congolais (CDF)</option>
            <option value="USD">Dollar US (USD)</option>
          </select>
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1.5">Quantité en stock</label>
          <input
            v-model="form.quantity"
            type="number"
            min="0"
            required
            class="w-full px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
          >
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1.5">Catégorie</label>
          <select
            v-model="form.category_id"
            class="w-full px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
          >
            <option value="">Sélectionner une catégorie</option>
            <option v-for="cat in categories" :key="cat.id" :value="cat.id">
              {{ cat.name }}
            </option>
          </select>
        </div>

        <div class="col-span-2">
          <div class="flex items-center justify-between mb-1.5">
            <label class="block text-sm font-medium text-gray-700">Images du produit</label>
            <span class="text-xs text-gray-400">{{ totalImages }}/4 · min 1</span>
          </div>

          <div class="grid grid-cols-4 gap-3">
            <!-- Images existantes -->
            <div
              v-for="(img, i) in existingImages"
              :key="'existing-' + i"
              class="relative aspect-square rounded-lg overflow-hidden border border-gray-200 bg-gray-50 group"
            >
              <img :src="img" class="w-full h-full object-cover" alt="">
              <button
                type="button"
                @click="removeExisting(i)"
                class="absolute top-1.5 right-1.5 w-6 h-6 flex items-center justify-center bg-white/90 text-gray-500 hover:text-red-600 rounded-md shadow-sm border border-gray-200 opacity-0 group-hover:opacity-100 transition"
                title="Supprimer"
              >
                <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>

            <!-- Nouvelles images (prévisualisation) -->
            <div
              v-for="(img, i) in newFiles"
              :key="'new-' + i"
              class="relative aspect-square rounded-lg overflow-hidden border border-green-200 bg-gray-50 group"
            >
              <img :src="img.preview" class="w-full h-full object-cover" alt="">
              <span class="absolute bottom-1.5 left-1.5 px-1.5 py-0.5 text-[10px] font-medium bg-green-600 text-white rounded">
                Nouveau
              </span>
              <button
                type="button"
                @click="removeNew(i)"
                class="absolute top-1.5 right-1.5 w-6 h-6 flex items-center justify-center bg-white/90 text-gray-500 hover:text-red-600 rounded-md shadow-sm border border-gray-200 opacity-0 group-hover:opacity-100 transition"
                title="Supprimer"
              >
                <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>

            <!-- Bouton ajouter -->
            <button
              v-if="canAddMore"
              type="button"
              @click="fileInput.click()"
              class="aspect-square rounded-lg border-2 border-dashed border-gray-300 hover:border-green-500 hover:bg-green-50/50 text-gray-400 hover:text-green-600 flex flex-col items-center justify-center gap-1.5 transition"
            >
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
              </svg>
              <span class="text-xs font-medium">Ajouter</span>
            </button>
          </div>

          <input
            ref="fileInput"
            type="file"
            accept="image/jpeg,image/png,image/webp,image/svg+xml"
            multiple
            class="hidden"
            @change="onFilesSelected"
          >

          <!-- Ajout par URL (optionnel) -->
          <div v-if="canAddMore" class="flex gap-2 mt-3">
            <input
              v-model="urlInput"
              type="text"
              placeholder="ou collez une URL d'image…"
              class="flex-1 px-3 py-2 text-sm bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
              @keyup.enter.prevent="addUrlImage"
            >
            <button
              type="button"
              @click="addUrlImage"
              class="px-3 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-200 rounded-lg hover:bg-gray-50 transition"
            >
              Ajouter URL
            </button>
          </div>

          <p v-if="imageError" class="mt-1.5 text-sm text-red-600">{{ imageError }}</p>
          <p v-else class="mt-1.5 text-xs text-gray-400">JPG, PNG, WEBP ou SVG · 4 Mo max par image · 1 à 4 images</p>
        </div>

        <div class="col-span-2">
          <label class="flex items-center gap-2">
            <input
              v-model="form.is_active"
              type="checkbox"
              class="w-4 h-4 rounded border-gray-300 text-green-600 focus:ring-green-500"
            >
            <span class="text-sm text-gray-700">Produit actif (visible dans la boutique)</span>
          </label>
        </div>
      </div>

      <div class="flex justify-end gap-2 mt-6 pt-5 border-t border-gray-100">
        <router-link
          to="/admin/products"
          class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-200 rounded-lg hover:bg-gray-50 transition"
        >
          Annuler
        </router-link>
        <button
          type="submit"
          :disabled="loading"
          class="px-4 py-2 text-sm font-medium text-white bg-green-600 rounded-lg hover:bg-green-700 disabled:opacity-50 transition"
        >
          {{ loading ? 'Enregistrement...' : (isEditing ? 'Modifier' : 'Créer') }}
        </button>
      </div>
    </form>
  </div>
</template>

<script setup>
import { ref, onMounted, computed, onUnmounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios';

const route = useRoute();
const router = useRouter();

const isEditing = computed(() => !!route.params.id);
const loading = ref(false);
const categories = ref([]);
const fileInput = ref(null);

const existingImages = ref([]);
const newFiles = ref([]);
const urlInput = ref('');
const imageError = ref('');

const form = ref({
  name: '',
  description: '',
  price: '',
  currency: 'CDF',
  quantity: '',
  category_id: '',
  is_active: true,
});

const totalImages = computed(() => existingImages.value.length + newFiles.value.length);
const canAddMore = computed(() => totalImages.value < 4);

const onFilesSelected = (e) => {
  const files = Array.from(e.target.files || []);
  for (const file of files) {
    if (!canAddMore.value) break;
    if (!file.type.startsWith('image/')) continue;
    newFiles.value.push({ file, preview: URL.createObjectURL(file) });
  }
  e.target.value = '';
  imageError.value = '';
};

const removeExisting = (index) => {
  existingImages.value.splice(index, 1);
};

const removeNew = (index) => {
  URL.revokeObjectURL(newFiles.value[index].preview);
  newFiles.value.splice(index, 1);
};

const addUrlImage = () => {
  const url = urlInput.value.trim();
  if (url && canAddMore.value) {
    existingImages.value.push(url);
    urlInput.value = '';
    imageError.value = '';
  }
};

const buildFormData = () => {
  const fd = new FormData();
  fd.append('name', form.value.name);
  fd.append('description', form.value.description);
  fd.append('price', form.value.price);
  fd.append('currency', form.value.currency);
  fd.append('quantity', form.value.quantity);
  fd.append('category_id', form.value.category_id ?? '');
  fd.append('is_active', form.value.is_active ? '1' : '0');
  existingImages.value.forEach((img) => fd.append('existing_images[]', img));
  newFiles.value.forEach((img) => fd.append('new_images[]', img.file));
  return fd;
};

const loadProduct = async () => {
  if (!isEditing.value) return;

  try {
    const response = await axios.get(`/api/admin/products/${route.params.id}`);
    const product = response.data;
    form.value = {
      name: product.name,
      description: product.description,
      price: product.price,
      currency: product.currency,
      quantity: product.quantity,
      category_id: product.category_id,
      is_active: product.is_active,
    };
    existingImages.value = product.images || [];
  } catch (error) {
    console.error('Error loading product:', error);
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

const saveProduct = async () => {
  if (totalImages.value < 1) {
    imageError.value = 'Ajoutez au moins une image (1 à 4 maximum).';
    return;
  }

  loading.value = true;
  imageError.value = '';

  try {
    const fd = buildFormData();
    if (isEditing.value) {
      fd.append('_method', 'PUT');
      await axios.post(`/api/admin/products/${route.params.id}`, fd);
    } else {
      await axios.post('/api/admin/products', fd);
    }
    router.push('/admin/products');
  } catch (error) {
    const errors = error.response?.data?.errors;
    if (errors?.images || errors?.new_images || errors?.existing_images) {
      imageError.value = (errors.images || errors.new_images || errors.existing_images)[0];
    } else {
      alert('Erreur lors de l\'enregistrement');
    }
    console.error('Error saving product:', error);
  } finally {
    loading.value = false;
  }
};

onMounted(() => {
  loadCategories();
  loadProduct();
});

onUnmounted(() => {
  newFiles.value.forEach((img) => URL.revokeObjectURL(img.preview));
});
</script>

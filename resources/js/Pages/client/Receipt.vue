<template>
  <div class="container mx-auto px-4 py-8 max-w-3xl">
    <!-- Bandeau succès (juste après l'achat) -->
    <div v-if="isNew" class="no-print mb-6 bg-green-50 border border-green-200 rounded-xl px-5 py-4 flex items-center gap-3">
      <span class="w-9 h-9 flex items-center justify-center bg-green-600 text-white rounded-full shrink-0">
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
        </svg>
      </span>
      <div>
        <p class="text-sm font-semibold text-green-800">Commande confirmée, merci !</p>
        <p class="text-xs text-green-700">Téléchargez votre reçu ci-dessous comme preuve d'achat.</p>
      </div>
    </div>

    <div v-if="loading" class="text-center py-16">
      <div class="inline-block animate-spin rounded-full h-8 w-8 border-2 border-gray-200 border-t-green-600"></div>
    </div>

    <div v-else-if="!order" class="bg-white rounded-xl border border-gray-200 p-14 text-center">
      <p class="text-gray-500 mb-5">Reçu introuvable</p>
      <router-link to="/orders" class="inline-block px-5 py-2.5 text-sm font-medium text-white bg-green-600 rounded-lg hover:bg-green-700 transition">
        Mes commandes
      </router-link>
    </div>

    <template v-else>
      <!-- Actions -->
      <div class="no-print flex flex-wrap items-center justify-between gap-3 mb-6">
        <router-link to="/orders" class="inline-flex items-center gap-1.5 text-sm font-medium text-gray-600 hover:text-gray-900 transition">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
          </svg>
          Mes commandes
        </router-link>
        <div class="flex gap-2">
          <button
            @click="printReceipt"
            class="inline-flex items-center gap-1.5 px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-200 rounded-lg hover:bg-gray-50 transition"
          >
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4H7v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z" />
            </svg>
            Imprimer
          </button>
          <button
            @click="downloadReceipt"
            class="inline-flex items-center gap-1.5 px-4 py-2 text-sm font-medium text-white bg-green-600 rounded-lg hover:bg-green-700 transition"
          >
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
            </svg>
            Télécharger le reçu
          </button>
        </div>
      </div>

      <!-- Reçu -->
      <div class="receipt-sheet bg-white rounded-xl border border-gray-200 overflow-hidden">
        <!-- En-tête -->
        <div class="px-8 py-6 border-b border-gray-100 flex items-start justify-between">
          <div class="flex items-center gap-3">
            <span class="w-11 h-11 flex items-center justify-center bg-green-600 text-white rounded-xl font-bold text-lg">G</span>
            <div>
              <p class="font-bold text-gray-900">Glodia Ferme</p>
              <p class="text-xs text-gray-500">Produits fermiers frais &amp; locaux</p>
            </div>
          </div>
          <div class="text-right">
            <p class="text-xs font-semibold text-gray-400 uppercase tracking-widest">Reçu</p>
            <p class="font-bold text-gray-900">#{{ order.order_number }}</p>
            <p class="text-xs text-gray-500 mt-0.5">{{ formatDate(order.issued_date) }}</p>
          </div>
        </div>

        <!-- Client / livraison -->
        <div class="px-8 py-5 grid grid-cols-2 gap-6 border-b border-gray-100">
          <div>
            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-1.5">Client</p>
            <p class="text-sm font-medium text-gray-900">{{ authStore.user?.name }}</p>
            <p class="text-sm text-gray-500">{{ authStore.user?.email }}</p>
          </div>
          <div>
            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-1.5">Livraison</p>
            <p class="text-sm text-gray-700 whitespace-pre-line">{{ order.shipping_address }}</p>
          </div>
        </div>

        <!-- Articles -->
        <div class="px-8 py-5">
          <table class="w-full">
            <thead>
              <tr class="text-left text-xs font-semibold text-gray-400 uppercase tracking-wider">
                <th class="pb-2">Produit</th>
                <th class="pb-2 text-center w-16">Qté</th>
                <th class="pb-2 text-right w-28">Prix unit.</th>
                <th class="pb-2 text-right w-28">Total</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-gray-100">
              <tr v-for="item in order.items" :key="item.id">
                <td class="py-3 text-sm text-gray-900">{{ item.product?.name }}</td>
                <td class="py-3 text-sm text-gray-600 text-center">{{ item.quantity }}</td>
                <td class="py-3 text-sm text-gray-600 text-right">{{ formatPrice(item.unit_price, order.currency) }}</td>
                <td class="py-3 text-sm font-medium text-gray-900 text-right">{{ formatPrice(item.total_price, order.currency) }}</td>
              </tr>
            </tbody>
          </table>

          <div class="mt-4 pt-4 border-t border-gray-100 flex items-center justify-between">
            <span :class="getStatusClass(order.status)" class="px-2.5 py-1 text-xs font-medium rounded-full">
              {{ getStatusLabel(order.status) }}
            </span>
            <div class="text-right">
              <p class="text-xs text-gray-500">Total payé</p>
              <p class="text-xl font-bold text-gray-900">{{ formatPrice(order.total_amount, order.currency) }}</p>
            </div>
          </div>
        </div>

        <!-- Pied -->
        <div class="px-8 py-5 bg-gray-50/70 border-t border-gray-100 text-center">
          <p class="text-sm font-medium text-gray-700">Merci pour votre achat !</p>
          <p class="text-xs text-gray-400 mt-1">Ce reçu fait office de preuve d'achat · Glodia Ferme</p>
        </div>
      </div>

      <div class="no-print mt-6 text-center">
        <router-link to="/products" class="text-sm font-medium text-green-600 hover:text-green-700 transition">
          Continuer mes achats →
        </router-link>
      </div>
    </template>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import { useRoute } from 'vue-router';
import axios from 'axios';
import { useAuthStore } from '../../stores/auth';
import { formatPrice, formatDate, getStatusClass, getStatusLabel } from '../../utils/format';

const route = useRoute();
const authStore = useAuthStore();

const order = ref(null);
const loading = ref(true);
const isNew = computed(() => route.query.success === '1');

const loadOrder = async () => {
  try {
    const response = await axios.get(`/api/orders/${route.params.id}`);
    order.value = response.data;
  } catch (error) {
    console.error('Error loading receipt:', error);
  } finally {
    loading.value = false;
  }
};

const printReceipt = () => window.print();

const escapeHtml = (s) => String(s ?? '').replace(/[&<>"']/g, (c) => ({
  '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;',
}[c]));

const downloadReceipt = () => {
  const o = order.value;
  const rows = (o.items || []).map((item) => `
      <tr>
        <td>${escapeHtml(item.product?.name)}</td>
        <td style="text-align:center">${item.quantity}</td>
        <td style="text-align:right">${escapeHtml(formatPrice(item.unit_price, o.currency))}</td>
        <td style="text-align:right;font-weight:600">${escapeHtml(formatPrice(item.total_price, o.currency))}</td>
      </tr>`).join('');

  const html = `<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Reçu ${escapeHtml(o.order_number)} - Glodia Ferme</title>
<style>
  body{font-family:system-ui,-apple-system,'Segoe UI',sans-serif;color:#111827;margin:0;padding:40px;background:#f9fafb}
  .sheet{max-width:640px;margin:0 auto;background:#fff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden}
  .head{display:flex;justify-content:space-between;align-items:flex-start;padding:28px 32px;border-bottom:1px solid #f3f4f6}
  .brand{display:flex;gap:12px;align-items:center}
  .logo{width:44px;height:44px;background:#16a34a;color:#fff;border-radius:12px;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:20px}
  .label{font-size:11px;color:#9ca3af;text-transform:uppercase;letter-spacing:.08em;font-weight:600}
  .cols{display:grid;grid-template-columns:1fr 1fr;gap:24px;padding:20px 32px;border-bottom:1px solid #f3f4f6}
  table{width:100%;border-collapse:collapse;margin:8px 32px;max-width:calc(100% - 64px)}
  th{font-size:11px;color:#9ca3af;text-transform:uppercase;letter-spacing:.06em;text-align:left;padding:8px 0;border-bottom:1px solid #f3f4f6}
  td{padding:12px 0;font-size:14px;border-bottom:1px solid #f9fafb}
  .total{display:flex;justify-content:space-between;align-items:center;padding:16px 32px}
  .foot{padding:20px 32px;background:#f9fafb;border-top:1px solid #f3f4f6;text-align:center}
  .status{display:inline-block;padding:4px 10px;font-size:12px;font-weight:500;border-radius:999px;background:#fef3c7;color:#92400e}
</style>
</head>
<body>
<div class="sheet">
  <div class="head">
    <div class="brand">
      <div class="logo">G</div>
      <div>
        <div style="font-weight:700">Glodia Ferme</div>
        <div style="font-size:12px;color:#6b7280">Produits fermiers frais &amp; locaux</div>
      </div>
    </div>
    <div style="text-align:right">
      <div class="label">Reçu</div>
      <div style="font-weight:700">#${escapeHtml(o.order_number)}</div>
      <div style="font-size:12px;color:#6b7280">${escapeHtml(formatDate(o.issued_date))}</div>
    </div>
  </div>
  <div class="cols">
    <div>
      <div class="label" style="margin-bottom:6px">Client</div>
      <div style="font-size:14px;font-weight:500">${escapeHtml(authStore.user?.name)}</div>
      <div style="font-size:14px;color:#6b7280">${escapeHtml(authStore.user?.email)}</div>
    </div>
    <div>
      <div class="label" style="margin-bottom:6px">Livraison</div>
      <div style="font-size:14px;color:#374151;white-space:pre-line">${escapeHtml(o.shipping_address)}</div>
    </div>
  </div>
  <table>
    <thead><tr><th>Produit</th><th style="text-align:center">Qté</th><th style="text-align:right">Prix unit.</th><th style="text-align:right">Total</th></tr></thead>
    <tbody>${rows}</tbody>
  </table>
  <div class="total">
    <span class="status">${escapeHtml(getStatusLabel(o.status))}</span>
    <div style="text-align:right">
      <div class="label">Total payé</div>
      <div style="font-size:22px;font-weight:700">${escapeHtml(formatPrice(o.total_amount, o.currency))}</div>
    </div>
  </div>
  <div class="foot">
    <div style="font-size:14px;font-weight:500;color:#374151">Merci pour votre achat !</div>
    <div style="font-size:12px;color:#9ca3af;margin-top:4px">Ce reçu fait office de preuve d'achat · Glodia Ferme</div>
  </div>
</div>
</body>
</html>`;

  const blob = new Blob([html], { type: 'text/html;charset=utf-8' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = `recu-${o.order_number}.html`;
  a.click();
  URL.revokeObjectURL(url);
};

onMounted(() => {
  loadOrder();
});
</script>

<style scoped>
@media print {
  .no-print {
    display: none !important;
  }
  .receipt-sheet {
    border: none;
    border-radius: 0;
  }
}
</style>

export const formatPrice = (price, currency = 'CDF', options = {}) => {
    return new Intl.NumberFormat('fr-FR', {
        style: 'currency',
        currency: currency || 'CDF',
        ...options,
    }).format(price);
};

export const formatDate = (date, options = {}) => {
    if (!date) return '-';
    return new Date(date).toLocaleDateString('fr-FR', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
        ...options,
    });
};

const STATUS_CLASSES = {
    pending: 'bg-yellow-100 text-yellow-800',
    paid: 'bg-blue-100 text-blue-800',
    shipped: 'bg-purple-100 text-purple-800',
    delivered: 'bg-green-100 text-green-800',
    cancelled: 'bg-red-100 text-red-800',
};

const STATUS_LABELS = {
    pending: 'En attente',
    paid: 'Payée',
    shipped: 'Expédiée',
    delivered: 'Livrée',
    cancelled: 'Annulée',
};

export const getStatusClass = (status) => STATUS_CLASSES[status] || 'bg-gray-100 text-gray-600';

export const getStatusLabel = (status) => STATUS_LABELS[status] || status;

export const initials = (name) => {
    if (!name) return '?';
    return name.split(' ').map(w => w[0]).slice(0, 2).join('').toUpperCase();
};

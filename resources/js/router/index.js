import { createRouter, createWebHistory } from 'vue-router';
import { useAuthStore } from '../stores/auth';
import Login from '@/Pages/Auth/Login.vue';
import Register from '@/Pages/Auth/Register.vue';
import ClientLayout from '@/Layouts/ClientLayout.vue';
import Home from '@/Pages/client/Home.vue';
import Products from '@/Pages/client/Products.vue';
import ProductDetail from '@/Pages/client/ProductDetail.vue';
import Cart from '@/Pages/client/Cart.vue';
import Profile from '@/Pages/client/Profile.vue';
import ClientOrders from '@/Pages/client/Orders.vue';
import Checkout from '@/Pages/client/Checkout.vue';
import Receipt from '@/Pages/client/Receipt.vue';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import AdminDashboard from '@/Pages/admin/Dashboard.vue';
import AdminOrders from '@/Pages/admin/Orders.vue';
import AdminProducts from '@/Pages/admin/Products.vue';
import ProductForm from '@/Pages/admin/ProductForm.vue';
import Users from '@/Pages/admin/Users.vue';
import Categories from '@/Pages/admin/Categories.vue';

const routes = [
    {
        path: '/login',
        name: 'login',
        component: Login,
        meta: { guest: true },
    },
    {
        path: '/register',
        name: 'register',
        component: Register,
        meta: { guest: true },
    },
    {
        path: '/admin',
        component: AdminLayout,
        meta: { requiresAuth: true, isAdmin: true },
        children: [
            {
                path: '',
                redirect: { name: 'admin.dashboard' },
            },
            {
                path: 'dashboard',
                name: 'admin.dashboard',
                component: AdminDashboard,
            },
            {
                path: 'products',
                name: 'admin.products',
                component: AdminProducts,
            },
            {
                path: 'products/create',
                name: 'admin.products.create',
                component: ProductForm,
            },
            {
                path: 'products/:id/edit',
                name: 'admin.products.edit',
                component: ProductForm,
            },
            {
                path: 'orders',
                name: 'admin.orders',
                component: AdminOrders,
            },
            {
                path: 'users',
                name: 'admin.users',
                component: Users,
            },
            {
                path: 'categories',
                name: 'admin.categories',
                component: Categories,
            },
        ],
    },
    {
        path: '/',
        component: ClientLayout,
        children: [
            {
                path: '',
                name: 'home',
                component: Home,
            },
            {
                path: 'products',
                name: 'products',
                component: Products,
            },
            {
                path: 'products/:slug',
                name: 'product.detail',
                component: ProductDetail,
            },
            {
                path: 'category/:slug',
                name: 'category.products',
                component: Products,
            },
            {
                path: 'cart',
                name: 'cart',
                component: Cart,
            },
            {
                path: 'profile',
                name: 'profile',
                component: Profile,
                meta: { requiresAuth: true },
            },
            {
                path: 'orders',
                name: 'orders',
                component: ClientOrders,
                meta: { requiresAuth: true },
            },
            {
                path: 'checkout',
                name: 'checkout',
                component: Checkout,
                meta: { requiresAuth: true },
            },
            {
                path: 'receipt/:id',
                name: 'receipt',
                component: Receipt,
                meta: { requiresAuth: true },
            },
        ],
    },
    {
        path: '/:pathMatch(.*)*',
        redirect: { name: 'home' },
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

router.beforeEach(async (to, from, next) => {
    const authStore = useAuthStore();
    await authStore.ensureReady();

    const requiresAuth = to.matched.some(record => record.meta.requiresAuth);
    const isAdminRoute = to.matched.some(record => record.meta.isAdmin);

    if (requiresAuth && !authStore.isAuthenticated) {
        next('/login');
    } else if (isAdminRoute && !authStore.isAdmin) {
        next('/');
    } else if ((to.name === 'login' || to.name === 'register') && authStore.isAuthenticated) {
        next(authStore.isAdmin ? '/admin/dashboard' : '/');
    } else {
        next();
    }
});

export default router;

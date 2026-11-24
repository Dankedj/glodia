# Glodia — Boutique Fermière

Site e-commerce pour une ferme : catalogue de produits, panier, commandes et
back-office d'administration.

## Stack

- **Backend** : Laravel 12+ (API REST, Sanctum pour l'auth par token)
- **Frontend** : SPA Vue 3 + Vue Router + Pinia + Tailwind CSS (via Vite)
- **Base de données** : MySQL (base `glodia`)

## Installation

```bash
composer install
npm install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
npm run build        # ou `npm run dev` pour le hot-reload
php artisan serve
```

Le site est ensuite accessible sur http://localhost:8000

## Comptes de test (seeder)

| Rôle   | Email             | Mot de passe |
|--------|-------------------|--------------|
| Admin  | admin@fermier.com | password     |
| Client | client@test.com   | password     |

## Structure

- `routes/api.php` — toutes les routes API (`/api/*`) : auth, boutique publique,
  panier/checkout (client) et back-office (`/api/admin/*`, middleware `admin`)
- `routes/web.php` — catch-all qui sert la SPA Vue (`resources/views/app.blade.php`)
- `resources/js/router` — routes Vue : `/`, `/products`, `/products/:slug`,
  `/category/:slug`, `/cart`, `/checkout`, `/orders`, `/profile`, `/admin/*`
- `resources/js/stores` — stores Pinia `auth` (token Sanctum dans localStorage)
  et `cart`
- `app/Models` — `Product`, `Category`, `Cart`, `Order`, `OrderItem`, `User`

## Tests

```bash
php artisan test
```

Les tests couvrent le flux complet : catalogue public, recherche,
inscription/connexion, panier, vérification de stock et commande.

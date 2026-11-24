<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Category;
use App\Models\Product;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run()
    {
        // Créer l'admin
        User::firstOrCreate(
            ['email' => 'admin@fermier.com'],
            [
                'name' => 'Administrateur',
                'password' => Hash::make('password'),
                'role' => 'admin',
                'phone' => '+243123456789',
                'address' => 'Kinshasa, RDC'
            ]
        );

        // Créer un client test
        User::firstOrCreate(
            ['email' => 'client@test.com'],
            [
                'name' => 'Client Test',
                'password' => Hash::make('password'),
                'role' => 'client',
                'phone' => '+243987654321',
                'address' => 'Lubumbashi, RDC'
            ]
        );

        // Créer des catégories
        $categories = [
            ['name' => 'Légumes', 'slug' => 'legumes', 'description' => 'Légumes frais de saison'],
            ['name' => 'Fruits', 'slug' => 'fruits', 'description' => 'Fruits tropicaux'],
            ['name' => 'Produits laitiers', 'slug' => 'produits-laitiers', 'description' => 'Lait, fromage, beurre'],
            ['name' => 'Viandes', 'slug' => 'viandes', 'description' => 'Viandes fraîches'],
            ['name' => 'Céréales', 'slug' => 'cereales', 'description' => 'Riz, maïs, etc.'],
        ];

        foreach ($categories as $cat) {
            Category::updateOrCreate(['slug' => $cat['slug']], $cat);
        }

        // Créer des produits
        $products = [
            [
                'name' => 'Tomates fraîches',
                'slug' => 'tomates-fraiches',
                'description' => 'Tomates rouges et juteuses, cultivées sans pesticides',
                'price' => 2500,
                'currency' => 'CDF',
                'quantity' => 100,
                'category_id' => 1,
                'images' => ['/images/products/tomates-1.svg', '/images/products/tomates-2.svg']
            ],
            [
                'name' => 'Bananes plantain',
                'slug' => 'bananes-plantain',
                'description' => 'Bananes plantain mûres, idéales pour la cuisson',
                'price' => 1500,
                'currency' => 'CDF',
                'quantity' => 200,
                'category_id' => 2,
                'images' => ['/images/products/bananes-1.svg']
            ],
            [
                'name' => 'Lait frais',
                'slug' => 'lait-frais',
                'description' => 'Lait frais pasteurisé, 1 litre',
                'price' => 3000,
                'currency' => 'CDF',
                'quantity' => 50,
                'category_id' => 3,
                'images' => ['/images/products/lait-1.svg']
            ],
            [
                'name' => 'Poulet fermier',
                'slug' => 'poulet-fermier',
                'description' => 'Poulet élevé en plein air',
                'price' => 15,
                'currency' => 'USD',
                'quantity' => 30,
                'category_id' => 4,
                'images' => ['/images/products/poulet-1.svg']
            ],
            [
                'name' => 'Riz local',
                'slug' => 'riz-local',
                'description' => 'Riz blanc de qualité supérieure, 5kg',
                'price' => 10000,
                'currency' => 'CDF',
                'quantity' => 80,
                'category_id' => 5,
                'images' => ['/images/products/riz-1.svg']
            ],
        ];

        foreach ($products as $product) {
            Product::updateOrCreate(['slug' => $product['slug']], $product);
        }
    }
}
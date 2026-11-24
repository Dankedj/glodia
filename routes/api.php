<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\ProductController;
use App\Http\Controllers\Admin\CategoryController;
use App\Http\Controllers\Admin\OrderController;
use App\Http\Controllers\Admin\UserController;
use App\Http\Controllers\Client\CartController;
use App\Http\Controllers\Client\CheckoutController;
use App\Http\Controllers\Client\ProfileController;
use App\Http\Controllers\Client\OrderController as ClientOrderController;
use App\Http\Controllers\Public\ProductController as PublicProductController;
use App\Http\Controllers\Public\CategoryController as PublicCategoryController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

// Routes d'authentification
Route::post('login', [AuthController::class, 'login']);
Route::post('register', [AuthController::class, 'register']);

// Routes publiques
Route::prefix('public')->group(function () {
    Route::get('products', [PublicProductController::class, 'index']);
    Route::get('products/{slug}', [PublicProductController::class, 'show']);
    Route::get('categories', [PublicCategoryController::class, 'index']);
    Route::get('categories/{slug}/products', [PublicCategoryController::class, 'products']);
});

// Routes protégées (nécessitent authentification)
Route::middleware(['auth:sanctum'])->group(function () {
    // Auth
    Route::post('logout', [AuthController::class, 'logout']);
    Route::get('user', [AuthController::class, 'user']);
    
    // Client routes
    Route::get('cart', [CartController::class, 'index']);
    Route::post('cart/add', [CartController::class, 'add']);
    Route::delete('cart/remove/{productId}', [CartController::class, 'remove']);
    Route::put('cart/update/{productId}', [CartController::class, 'update']);
    Route::post('cart/clear', [CartController::class, 'clear']);
    Route::post('checkout', [CheckoutController::class, 'checkout']);
    Route::get('orders', [ClientOrderController::class, 'index']);
    Route::get('orders/{id}', [ClientOrderController::class, 'show']);
    Route::get('profile', [ProfileController::class, 'show']);
    Route::put('profile', [ProfileController::class, 'update']);
});

// Routes Admin (nécessitent authentification + rôle admin)
Route::middleware(['auth:sanctum', 'admin'])->prefix('admin')->group(function () {
    Route::get('dashboard', [DashboardController::class, 'index']);
    Route::apiResource('products', ProductController::class);
    Route::apiResource('categories', CategoryController::class);
    Route::apiResource('orders', OrderController::class)->except(['store', 'update']);
    Route::put('orders/{id}/status', [OrderController::class, 'updateStatus']);
    Route::apiResource('users', UserController::class)->only(['index', 'show', 'destroy']);
});
<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Le frontend est une SPA Vue (vue-router en mode history). Toutes les
| routes non-API renvoient la même vue Blade qui monte l'application.
|
*/

Route::view('/{any?}', 'app')
    ->where('any', '^(?!api(?:/|$)|sanctum(?:/|$)|storage(?:/|$)|up$).*$');

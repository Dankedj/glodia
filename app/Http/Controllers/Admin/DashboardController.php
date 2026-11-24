<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\Product;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function index()
    {
        // 10 produits les plus vendus
        $topProducts = Product::select('products.id', 'products.name', 'products.images')
            ->withSum('orderItems as total_sold', 'quantity')
            ->get()
            ->filter(fn ($product) => $product->total_sold > 0)
            ->sortByDesc('total_sold')
            ->take(10)
            ->values();

        // Montant total accumulé par devise
        $totalsByCurrency = Order::where('status', '!=', 'cancelled')
            ->select('currency', DB::raw('SUM(total_amount) as total'))
            ->groupBy('currency')
            ->get();

        // Statistiques générales
        $stats = [
            'total_orders' => Order::count(),
            'total_users' => User::where('role', 'client')->count(),
            'total_products' => Product::count(),
            'pending_orders' => Order::where('status', 'pending')->count(),
        ];

        // Ventes des 7 derniers jours
        $salesLastWeek = Order::where('status', '!=', 'cancelled')
            ->where('created_at', '>=', now()->subDays(7))
            ->select(DB::raw('DATE(created_at) as date'), DB::raw('SUM(total_amount) as total'))
            ->groupBy('date')
            ->get();

        return response()->json([
            'top_products' => $topProducts,
            'totals_by_currency' => $totalsByCurrency,
            'stats' => $stats,
            'sales_last_week' => $salesLastWeek,
        ]);
    }
}
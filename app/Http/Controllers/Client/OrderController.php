<?php

namespace App\Http\Controllers\Client;

use App\Http\Controllers\Controller;
use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class OrderController extends Controller
{
    public function index()
    {
        $orders = Auth::user()
            ->orders()
            ->with('items.product')
            ->orderBy('created_at', 'desc')
            ->get();
        
        return response()->json($orders);
    }

    public function show($id)
    {
        $order = Auth::user()
            ->orders()
            ->with('items.product')
            ->findOrFail($id);
        
        return response()->json($order);
    }
}
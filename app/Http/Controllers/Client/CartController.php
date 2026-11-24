<?php

namespace App\Http\Controllers\Client;

use App\Http\Controllers\Controller;
use App\Models\Cart;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CartController extends Controller
{
    private function getCart(): Cart
    {
        return Auth::user()->cart()->firstOrCreate([], [
            'items' => [],
            'total_items' => 0,
            'total_amount' => 0,
            'currency' => 'CDF'
        ]);
    }

    public function index()
    {
        return response()->json($this->getCart());
    }

    public function add(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
            'quantity' => 'required|integer|min:1'
        ]);

        $cart = $this->getCart();

        $product = Product::findOrFail($request->product_id);

        $items = $cart->items ?? [];
        $currentQuantity = $items[$request->product_id]['quantity'] ?? 0;

        if (!$product->is_active) {
            return response()->json(['message' => 'Ce produit n\'est plus disponible'], 422);
        }

        if ($product->quantity < $currentQuantity + $request->quantity) {
            return response()->json([
                'message' => "Stock insuffisant pour {$product->name} ({$product->quantity} disponible(s))"
            ], 422);
        }

        if (isset($items[$request->product_id])) {
            $items[$request->product_id]['quantity'] += $request->quantity;
        } else {
            $items[$request->product_id] = [
                'product_id' => $product->id,
                'name' => $product->name,
                'price' => $product->price,
                'currency' => $product->currency,
                'quantity' => $request->quantity,
                'image' => $product->first_image
            ];
        }
        
        $cart->items = $items;
        $cart->recalculateTotals();
        $cart->save();
        
        return response()->json($cart);
    }

    public function remove($productId)
    {
        $cart = $this->getCart();
        $items = $cart->items ?? [];
        unset($items[$productId]);
        $cart->items = $items;
        $cart->recalculateTotals();
        $cart->save();
        
        return response()->json($cart);
    }

    public function update(Request $request, $productId)
    {
        $request->validate([
            'quantity' => 'required|integer|min:0'
        ]);
        
        $cart = $this->getCart();
        $items = $cart->items ?? [];

        if ($request->quantity <= 0) {
            unset($items[$productId]);
        } elseif (isset($items[$productId])) {
            $product = Product::find($productId);
            if ($product && $product->quantity < $request->quantity) {
                return response()->json([
                    'message' => "Stock insuffisant pour {$product->name} ({$product->quantity} disponible(s))"
                ], 422);
            }
            $items[$productId]['quantity'] = $request->quantity;
        }
        
        $cart->items = $items;
        $cart->recalculateTotals();
        $cart->save();
        
        return response()->json($cart);
    }

    public function clear()
    {
        $cart = $this->getCart();
        $cart->items = [];
        $cart->total_items = 0;
        $cart->total_amount = 0;
        $cart->save();
        
        return response()->json($cart);
    }
}
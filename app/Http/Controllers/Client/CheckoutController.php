<?php

namespace App\Http\Controllers\Client;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CheckoutController extends Controller
{
    public function checkout(Request $request)
    {
        $request->validate([
            'shipping_address' => 'required|string',
            'billing_address' => 'nullable|string'
        ]);
        
        $user = Auth::user();
        $cart = $user->cart()->first();

        if (!$cart || $cart->total_items == 0) {
            return response()->json(['message' => 'Panier vide'], 400);
        }
        
        DB::beginTransaction();

        try {
            // Vérifier le stock avant de créer la commande
            foreach ($cart->items as $item) {
                $product = Product::lockForUpdate()->find($item['product_id']);

                if (!$product || !$product->is_active) {
                    DB::rollBack();
                    return response()->json([
                        'message' => "Le produit « {$item['name']} » n'est plus disponible"
                    ], 422);
                }

                if ($product->quantity < $item['quantity']) {
                    DB::rollBack();
                    return response()->json([
                        'message' => "Stock insuffisant pour « {$product->name} » ({$product->quantity} disponible(s))"
                    ], 422);
                }
            }

            // Créer la commande
            $order = Order::create([
                'order_number' => Order::generateOrderNumber(),
                'user_id' => $user->id,
                'total_amount' => $cart->total_amount,
                'currency' => $cart->currency,
                'status' => 'pending',
                'shipping_address' => $request->shipping_address,
                'billing_address' => $request->billing_address ?? $request->shipping_address,
                'issued_date' => now()
            ]);
            
            // Créer les items de commande
            foreach ($cart->items as $item) {
                OrderItem::create([
                    'order_id' => $order->id,
                    'product_id' => $item['product_id'],
                    'quantity' => $item['quantity'],
                    'unit_price' => $item['price'],
                    'total_price' => $item['price'] * $item['quantity']
                ]);
                
                // Mettre à jour le stock
                Product::where('id', $item['product_id'])->decrement('quantity', $item['quantity']);
            }
            
            // Vider le panier
            $cart->clear();
            
            DB::commit();
            
            return response()->json($order, 201);
            
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Erreur lors de la commande'], 500);
        }
    }
}
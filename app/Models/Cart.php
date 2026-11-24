<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Cart extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id', 'items', 'total_items', 'total_amount', 'currency'
    ];

    protected $casts = [
        'items' => 'array',
        'total_amount' => 'decimal:2'
    ];

    // Relations
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Méthodes utilitaires
    public function addItem($productId, $quantity = 1)
    {
        $items = $this->items ?? [];
        $product = Product::findOrFail($productId);

        if (isset($items[$productId])) {
            $items[$productId]['quantity'] += $quantity;
        } else {
            $items[$productId] = [
                'product_id' => $productId,
                'name' => $product->name,
                'price' => $product->price,
                'currency' => $product->currency,
                'quantity' => $quantity,
                'image' => $product->first_image
            ];
        }

        $this->items = $items;
        $this->recalculateTotals();
        $this->save();
    }

    public function removeItem($productId)
    {
        $items = $this->items ?? [];
        unset($items[$productId]);
        $this->items = $items;
        $this->recalculateTotals();
        $this->save();
    }

    public function updateQuantity($productId, $quantity)
    {
        $items = $this->items ?? [];
        
        if ($quantity <= 0) {
            unset($items[$productId]);
        } elseif (isset($items[$productId])) {
            $items[$productId]['quantity'] = $quantity;
        }

        $this->items = $items;
        $this->recalculateTotals();
        $this->save();
    }

    public function recalculateTotals()
    {
        $items = $this->items ?? [];
        $totalItems = 0;
        $totalAmount = 0;

        foreach ($items as $item) {
            $totalItems += $item['quantity'];
            $totalAmount += $item['price'] * $item['quantity'];
        }

        $this->total_items = $totalItems;
        $this->total_amount = $totalAmount;
    }

    public function clear()
    {
        $this->items = [];
        $this->total_items = 0;
        $this->total_amount = 0;
        $this->save();
    }
}
<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class ProductController extends Controller
{
    public function index()
    {
        $products = Product::with('category')->orderBy('created_at', 'desc')->get();
        return response()->json($products);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'required|string',
            'price' => 'required|numeric|min:0',
            'currency' => 'required|in:CDF,USD',
            'quantity' => 'required|integer|min:0',
            'category_id' => 'nullable|exists:categories,id',
            'is_active' => 'boolean',
            'new_images' => 'nullable|array|max:4',
            'new_images.*' => 'file|extensions:jpg,jpeg,png,webp,svg|max:4096',
            'existing_images' => 'nullable|array|max:4',
            'existing_images.*' => 'string|max:500',
        ]);

        $validated['images'] = $this->processImages($request, []);
        $validated['slug'] = Str::slug($validated['name']) . '-' . uniqid();
        unset($validated['new_images'], $validated['existing_images']);

        $product = Product::create($validated);

        return response()->json($product, 201);
    }

    public function show($id)
    {
        $product = Product::with('category')->findOrFail($id);
        return response()->json($product);
    }

    public function update(Request $request, $id)
    {
        $product = Product::findOrFail($id);

        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'description' => 'sometimes|string',
            'price' => 'sometimes|numeric|min:0',
            'currency' => 'sometimes|in:CDF,USD',
            'quantity' => 'sometimes|integer|min:0',
            'category_id' => 'nullable|exists:categories,id',
            'is_active' => 'boolean',
            'new_images' => 'nullable|array|max:4',
            'new_images.*' => 'file|extensions:jpg,jpeg,png,webp,svg|max:4096',
            'existing_images' => 'nullable|array|max:4',
            'existing_images.*' => 'string|max:500',
        ]);

        if ($request->has('new_images') || $request->has('existing_images')) {
            $previous = $product->images ?? [];
            $validated['images'] = $this->processImages($request, $previous);
            $this->deleteRemovedImages($previous, $validated['images']);
        }
        unset($validated['new_images'], $validated['existing_images']);

        if (isset($validated['name']) && $validated['name'] !== $product->name) {
            $validated['slug'] = Str::slug($validated['name']) . '-' . uniqid();
        }

        $product->update($validated);

        return response()->json($product);
    }

    public function destroy($id)
    {
        $product = Product::findOrFail($id);
        $product->delete();

        return response()->json(null, 204);
    }

    private function processImages(Request $request, array $previous): array
    {
        $paths = (array) $request->input('existing_images', $previous);

        foreach ((array) $request->file('new_images', []) as $file) {
            $paths[] = '/storage/' . $file->store('products', 'public');
        }

        $paths = array_values(array_filter(array_slice($paths, 0, 4)));

        if (empty($paths)) {
            throw ValidationException::withMessages([
                'images' => ['Au moins une image est requise (1 à 4 maximum).'],
            ]);
        }

        return $paths;
    }

    private function deleteRemovedImages(array $previous, array $current): void
    {
        foreach (array_diff($previous, $current) as $path) {
            if (is_string($path) && str_starts_with($path, '/storage/')) {
                Storage::disk('public')->delete(substr($path, strlen('/storage/')));
            }
        }
    }
}
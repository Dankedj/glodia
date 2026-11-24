<?php

namespace Tests\Feature;

use App\Models\Category;
use App\Models\Product;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ShopApiTest extends TestCase
{
    use RefreshDatabase;

    private function client(): User
    {
        return User::factory()->create(['role' => 'client']);
    }

    private function product(array $attributes = []): Product
    {
        $category = Category::firstOrCreate(['slug' => 'legumes'], ['name' => 'Légumes']);

        return Product::create(array_merge([
            'name' => 'Tomates',
            'slug' => 'tomates',
            'description' => 'Tomates fraîches',
            'price' => 2500,
            'currency' => 'CDF',
            'quantity' => 10,
            'category_id' => $category->id,
            'is_active' => true,
        ], $attributes));
    }

    public function test_public_can_list_products(): void
    {
        $this->product();

        $this->getJson('/api/public/products')
            ->assertOk()
            ->assertJsonCount(1)
            ->assertJsonPath('0.name', 'Tomates');
    }

    public function test_products_can_be_searched(): void
    {
        $this->product();
        $this->product(['name' => 'Bananes', 'slug' => 'bananes']);

        $this->getJson('/api/public/products?search=banane')
            ->assertOk()
            ->assertJsonCount(1)
            ->assertJsonPath('0.name', 'Bananes');
    }

    public function test_client_can_register_and_login(): void
    {
        $this->postJson('/api/register', [
            'name' => 'Jean',
            'email' => 'jean@test.com',
            'password' => 'password123',
            'password_confirmation' => 'password123',
        ])->assertCreated()->assertJsonStructure(['token', 'user']);

        $this->postJson('/api/login', [
            'email' => 'jean@test.com',
            'password' => 'password123',
        ])->assertOk()->assertJsonStructure(['token']);
    }

    public function test_guest_cannot_access_cart(): void
    {
        $this->getJson('/api/cart')->assertUnauthorized();
    }

    public function test_full_checkout_flow(): void
    {
        $user = $this->client();
        $product = $this->product(['quantity' => 5]);

        $this->actingAs($user)
            ->postJson('/api/cart/add', ['product_id' => $product->id, 'quantity' => 2])
            ->assertOk()
            ->assertJsonPath('total_items', 2);

        $this->actingAs($user)
            ->postJson('/api/checkout', ['shipping_address' => 'Kinshasa'])
            ->assertCreated()
            ->assertJsonPath('status', 'pending');

        $this->assertEquals(3, $product->fresh()->quantity);
        $this->assertEquals(0, $user->cart->fresh()->total_items);
        $this->assertCount(1, $user->orders()->get());
    }

    public function test_cannot_order_more_than_stock(): void
    {
        $user = $this->client();
        $product = $this->product(['quantity' => 2]);

        $this->actingAs($user)
            ->postJson('/api/cart/add', ['product_id' => $product->id, 'quantity' => 10])
            ->assertStatus(422);
    }

    public function test_client_cannot_access_admin_routes(): void
    {
        $user = $this->client();

        $this->actingAs($user)
            ->getJson('/api/admin/dashboard')
            ->assertForbidden();
    }

    public function test_admin_can_access_dashboard(): void
    {
        $admin = User::factory()->create(['role' => 'admin']);

        $this->actingAs($admin)
            ->getJson('/api/admin/dashboard')
            ->assertOk()
            ->assertJsonStructure(['stats', 'totals_by_currency', 'top_products']);
    }
}

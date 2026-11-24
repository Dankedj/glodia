<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index()
    {
        $users = User::where('role', 'client')
            ->withCount('orders')
            ->orderBy('created_at', 'desc')
            ->get();
        
        // Ajouter le total dépensé
        foreach ($users as $user) {
            $user->total_spent = $user->total_spent;
        }
        
        return response()->json($users);
    }

    public function show($id)
    {
        $user = User::where('role', 'client')
            ->with('orders.items.product')
            ->findOrFail($id);
        
        return response()->json($user);
    }

    public function destroy($id)
    {
        $user = User::findOrFail($id);
        
        if ($user->orders()->count() > 0) {
            return response()->json(['message' => 'Impossible de supprimer un utilisateur qui a des commandes'], 400);
        }
        
        $user->delete();
        
        return response()->json(null, 204);
    }
}
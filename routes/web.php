<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductController;

// Default welcome route (optional)
Route::get('/', function () {
    return view('welcome');
});

// Products CRUD routes
Route::resource('products', ProductController::class);

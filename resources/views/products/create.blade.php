@extends('layout')

@section('content')
<h1>Add New Product</h1>

<form action="{{ route('products.store') }}" method="POST">
    @csrf

    <div class="mb-3">
        <label for="name" class="form-label">Name</label>
        <input type="text" name="name" class="form-control" placeholder="Enter product name" required>
    </div>

    <div class="mb-3">
        <label for="description" class="form-label">Description</label>
        <textarea name="description" class="form-control" placeholder="Enter product description"></textarea>
    </div>

    <div class="mb-3">
        <label for="price" class="form-label">Price</label>
        <input type="number" step="0.01" name="price" class="form-control" placeholder="Enter product price" required>
    </div>

    <button type="submit" class="btn btn-success">Add Product</button>
    <a href="{{ route('products.index') }}" class="btn btn-secondary">Back</a>
</form>
@endsection

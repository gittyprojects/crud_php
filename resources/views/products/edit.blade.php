@extends('layout')

@section('content')
<h1>Edit Product</h1>

<form action="{{ route('products.update', $product->id) }}" method="POST">
    @csrf
    @method('PUT')

    <div class="mb-3">
        <label for="name" class="form-label">Name</label>
        <input type="text" name="name" class="form-control" value="{{ $product->name }}" required>
    </div>

    <div class="mb-3">
        <label for="description" class="form-label">Description</label>
        <textarea name="description" class="form-control">{{ $product->description }}</textarea>
    </div>

    <div class="mb-3">
        <label for="price" class="form-label">Price</label>
        <input type="number" step="0.01" name="price" class="form-control" value="{{ $product->price }}" required>
    </div>

    <button type="submit" class="btn btn-primary">Update Product</button>
    <a href="{{ route('products.index') }}" class="btn btn-secondary">Back</a>
</form>
@endsection

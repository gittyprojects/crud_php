@extends('layout')

@section('content')
<h1>Products</h1>
<a href="{{ route('products.create') }}" class="btn btn-primary mb-3">Add Product</a>

<table class="table table-bordered">
    <tr>
        <th>Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Action</th>
    </tr>
    @foreach($products as $product)
        <tr>
            <td>{{ $product->name }}</td>
            <td>{{ $product->description }}</td>
            <td>{{ $product->price }}</td>
            <td>
                <a href="{{ route('products.edit', $product->id) }}" class="btn btn-warning btn-sm">Edit</a>
                <form action="{{ route('products.destroy', $product->id) }}" method="POST" style="display:inline;">
                    @csrf
                    @method('DELETE')
                    <button class="btn btn-danger btn-sm">Delete</button>
                </form>
            </td>
        </tr>
    @endforeach
</table>
@endsection

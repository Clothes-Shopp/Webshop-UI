document.addEventListener('DOMContentLoaded', () => {
  const cartIcon = document.getElementById('cart-icon');
  const cartSidebar = document.getElementById('cart-sidebar');
  const cartBackdrop = document.getElementById('cart-backdrop');
  const closeCartBtn = document.getElementById('close-cart');
  const continueShoppingBtn = document.getElementById('closeCartBtn');

  cartIcon.addEventListener('click', (e) => {
    e.stopPropagation();
    openCart();
  });

  closeCartBtn.addEventListener('click', () => {
    closeCart();
  });

  cartBackdrop.addEventListener('click', () => {
    closeCart();
  });
    continueShoppingBtn.addEventListener('click', () => {
    closeCart();
  });

  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && !cartSidebar.classList.contains('translate-x-full')) {
      closeCart();
    }
  });

  function openCart() {
    cartSidebar.classList.remove('translate-x-full');
    cartBackdrop.classList.remove('hidden');
  }

  function closeCart() {
    cartSidebar.classList.add('translate-x-full');
    cartBackdrop.classList.add('hidden');
  }

  window.cartFunctions = {
    openCart,
    closeCart,
    updateCartCount: updateCartCount,
    addToCart: addToCart
  };

  function updateCartCount(count) {
    const cartCount = document.getElementById('cart-count');
    cartCount.textContent = count;
  }

  function addToCart(product) {
    let cart = JSON.parse(localStorage.getItem('cart')) || [];
    
    const existingProduct = cart.find(item => item.id === product.id);
    
    if (existingProduct) {
      existingProduct.quantity += product.quantity || 1;
    } else {
      cart.push({
        ...product,
        quantity: product.quantity || 1
      });
    }
    
    localStorage.setItem('cart', JSON.stringify(cart));
    
    updateCartDisplay();
  }

  function updateCartDisplay() {
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    const cartItems = document.getElementById('cart-items');
    const cartTotal = document.getElementById('cart-total');
    const cartCount = document.getElementById('cart-count');

    const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
    cartCount.textContent = totalItems;

    if (cart.length === 0) {
      cartItems.innerHTML = '<p class="text-gray-500 text-center">Votre panier est vide</p>';
      cartTotal.textContent = '0 MUR';
      return;
    }

    let html = '';
    let total = 0;

    cart.forEach(item => {
      const itemTotal = (item.price || 0) * item.quantity;
      total += itemTotal;

      html += `
        <div class="flex items-start gap-4 pb-4 border-b">
          <img src="${item.image || 'img/homepage/chemise_en_lin.jpg'}" alt="${item.name}" class="w-20 h-20 object-cover rounded">
          <div class="flex-1">
            <h3 class="font-semibold text-sm">${item.name}</h3>
            <p class="text-gray-500 text-xs">${item.price} MUR × ${item.quantity}</p>
            <p class="font-semibold text-sm mt-1">${itemTotal} MUR</p>
          </div>
          <button onclick="window.cartFunctions.removeFromCart('${item.id}')" class="text-gray-400 hover:text-red-500">
            <i class="fas fa-trash text-sm"></i>
          </button>
        </div>
      `;
    });

    cartItems.innerHTML = html;
    cartTotal.textContent = total + ' MUR';
  }

  window.cartFunctions.removeFromCart = function(productId) {
    let cart = JSON.parse(localStorage.getItem('cart')) || [];
    cart = cart.filter(item => item.id !== productId);
    localStorage.setItem('cart', JSON.stringify(cart));
    updateCartDisplay();
  };

  updateCartDisplay();
});

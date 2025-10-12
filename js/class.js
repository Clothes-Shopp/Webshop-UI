
// Gestion de la sélection des couleurs
document.addEventListener('DOMContentLoaded', function () {
    const colorOptions = document.querySelectorAll('.color-option');
    const selectedColorText = document.getElementById('selected-color');

    colorOptions.forEach(option => {
        option.addEventListener('click', function () {
            // Retirer la classe active de toutes les options
            colorOptions.forEach(opt => opt.classList.remove('active'));

            // Ajouter la classe active à l'option cliquée
            this.classList.add('active');

            // Mettre à jour le texte de la couleur sélectionnée
            const colorName = this.getAttribute('title');
            selectedColorText.textContent = colorName;
        });
    });
});

// color-switch.js
document.addEventListener('DOMContentLoaded', function () {
    const colorOptions = document.querySelectorAll('.color-option');
    const selectedColorText = document.getElementById('selected-color');
    const productImage = document.getElementById('product-image');

    colorOptions.forEach(option => {
        option.addEventListener('click', function () {
            // Retirer la classe active de toutes les options
            colorOptions.forEach(opt => opt.classList.remove('active'));

            // Ajouter la classe active à l'option cliquée
            this.classList.add('active');

            // Mettre à jour le texte de la couleur sélectionnée
            const colorName = this.getAttribute('title');
            selectedColorText.textContent = colorName;

            // Changer l'image du produit
            const newSrc = this.getAttribute('data-src');
            productImage.src = newSrc;
        });
    });
});

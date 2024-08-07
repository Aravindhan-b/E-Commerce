document.addEventListener('DOMContentLoaded', () => {
  const parentFilter = document.getElementById('parent-filter');
  const dynamicFilters = document.getElementById('dynamic-filters');

  parentFilter.addEventListener('change', (event) => {
    dynamicFilters.innerHTML = '';
    const selectedFilters = Array.from(event.target.selectedOptions).map(option => option.value);
    let contentHtml = '';

    if (selectedFilters.includes('color')) {
      contentHtml += '<div><h3>Filter by Color</h3>';
      window.ProductData.colors.forEach(color => {
        contentHtml += `<input type="checkbox" name="filters[color][]" value="${color}" id="filters_color_${color}">
                        <label for="filters_color_${color}">${color.charAt(0).toUpperCase() + color.slice(1)}</label><br>`;
      });
      contentHtml += '</div>';
    }

    if (selectedFilters.includes('size')) {
      contentHtml += '<div><h3>Filter by Size</h3>';
      window.ProductData.sizes.forEach(size => {
        contentHtml += `<input type="checkbox" name="filters[size][]" value="${size}" id="filters_size_${size}">
                        <label for="filters_size_${size}">${size.charAt(0).toUpperCase() + size.slice(1)}</label><br>`;
      });
      contentHtml += '</div>';
    }

    if (selectedFilters.includes('price')) {
      contentHtml += '<div><h3>Filter by Price</h3>';
      window.ProductData.prices.forEach(price => {
        contentHtml += `<input type="checkbox" name="filters[price][]" value="${price}" id="filters_price_${price}">
                        <label for="filters_price_${price}">${price}</label><br>`;
      });
      contentHtml += '</div>';
    }

    dynamicFilters.innerHTML = contentHtml;
  });
});
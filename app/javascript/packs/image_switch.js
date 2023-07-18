document.addEventListener('DOMContentLoaded', function(){
  const thumbnails = document.querySelectorAll('.thumbnail');
  const mainImage = document.getElementById('main-image');

  thumbnails.forEach((thumbnail) => {
    thumbnail.addEventListener('click', (event) => {
      mainImage.src = event.currentTarget.dataset.src;
    });
  });
});
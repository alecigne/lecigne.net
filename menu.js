(function () {
  var dropdown = document.querySelector('.topnav-dropdown');
  var summary = dropdown.querySelector('.topnav-button');

  function closeDropdown() {
    dropdown.open = false;
    dropdown.removeAttribute('data-opened-by-hover');
  }

  dropdown.addEventListener('pointerenter', function (event) {
    if (event.pointerType === 'mouse') {
      dropdown.open = true;
      dropdown.setAttribute('data-opened-by-hover', '');
    }
  });

  dropdown.addEventListener('pointerleave', function (event) {
    if (event.pointerType === 'mouse') {
      closeDropdown();
    }
  });

  summary.addEventListener('click', function (event) {
    if (event.detail !== 0 && dropdown.hasAttribute('data-opened-by-hover')) {
      event.preventDefault();
    }
  });

  window.addEventListener('pagehide', closeDropdown);
  window.addEventListener('pageshow', closeDropdown);
}());

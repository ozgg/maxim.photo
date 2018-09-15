"use strict";

document.addEventListener('DOMContentLoaded', function () {
    const gallery = document.getElementById('photo-gallery');
    if (gallery) {
        gallery.querySelectorAll('input[type="radio"]').forEach(function (radio) {
            radio.addEventListener('click', function () {
                const div = gallery.querySelector('input:checked + div');
                if (div) {
                    this.focus();
                    div.scrollIntoView();
                }
            });
        })
    }
});

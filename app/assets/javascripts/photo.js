"use strict";

const Photos = {
    initialized: false,
    components: {},
    autoInitComponents: true
};

Photos.components.gallery = {
    initialized: false,
    container: undefined,
    items: [],
    selector: ".photo-preview a",
    current: null,
    image: undefined,
    init: function () {
        const items = document.querySelectorAll(this.selector);
        if (items.length > 0) {
            items.forEach(this.apply);
            this.container = document.getElementById("gallery");
            if (!this.container) {
                this.createContainer();
            }
            document.addEventListener("keyup", this.keyUp);
            this.initialized = true;
        }
    },
    apply: function (element) {
        const component = Photos.components.gallery;
        component.items.push(element);
        element.addEventListener("click", component.handler);
    },
    handler: function (event) {
        event.preventDefault();
        const component = Photos.components.gallery;
        const element = event.target.closest("a");
        component.showPhoto(element);
        component.container.querySelector(".next").focus();
    },
    showPhoto: function (element) {
        const component = Photos.components.gallery;
        const image = element.querySelector("img");
        component.image.setAttribute("src", element.href);
        component.image.setAttribute("alt", image.getAttribute("alt"));
        component.image.setAttribute("title", element.getAttribute("title"));
        component.current = parseInt(element.getAttribute("data-index"));
        component.container.classList.remove("hidden");
    },
    createContainer: function () {
        this.container = document.createElement("div");
        this.image = document.createElement("img");
        this.container.setAttribute("id", "gallery");
        this.container.classList.add("hidden");

        const prevButton = document.createElement("button");
        prevButton.classList.add("prev");
        prevButton.addEventListener("click", this.previousImage);
        prevButton.addEventListener("blur", this.blur);
        this.container.append(prevButton);

        const figure = document.createElement("figure");
        const imageContainer = document.createElement("div");
        figure.addEventListener("click", this.hide);
        figure.append(imageContainer);
        figure.append(document.createElement("figcaption"));
        imageContainer.classList.add("image");
        imageContainer.append(this.image);
        this.container.append(figure);

        const nextButton = document.createElement("button");
        nextButton.classList.add("next");
        nextButton.addEventListener("click", this.nextImage);
        nextButton.addEventListener("blur", this.blur);
        this.container.append(nextButton);

        document.querySelector("body").append(this.container);
    },
    nextImage: function () {
        const component = Photos.components.gallery;
        let newIndex;
        if (component.current < component.items.length - 1) {
            newIndex = component.current + 1;
        } else {
            newIndex = 0;
        }
        component.current = newIndex;
        component.showPhoto(component.items[newIndex]);
        component.container.querySelector(".next").focus();
    },
    previousImage: function () {
        const component = Photos.components.gallery;
        let newIndex;
        if (component.current === 0) {
            newIndex = component.items.length - 1;
        } else {
            newIndex = component.current - 1;
        }
        component.current = newIndex;
        component.showPhoto(component.items[newIndex]);
        component.container.querySelector(".prev").focus();
    },
    keyUp: function (event) {
        const component = Photos.components.gallery;
        if (!component.container.classList.contains("hidden")) {
            switch (event.code.toUpperCase()) {
                case 'ESCAPE':
                    component.hide();
                    break;
                case 'ARROWLEFT':
                    component.previousImage();
                    break;
                case "ARROWRIGHT":
                    component.nextImage();
                    break;
            }
        }
    },
    hide: function () {
        const component = Photos.components.gallery;
        component.container.classList.add("hidden");
        component.items[component.current].focus();
    },
    blur: function () {
        const component = Photos.components.gallery;
        const check = function () {
            if (!document.activeElement.matches("#gallery button")) {
                component.hide();
            }
        };
        window.setTimeout(check, 100);
    }
};

Biovision.components.photos = Photos;

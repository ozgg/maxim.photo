"use strict";

const Photo = {
    initialized: false,
    autoInitComponents: true,
    components: {}
};

Photo.components.featuredPhotoList = {
    initialized: false,
    selector: ".js-featured-photo-list",
    container: undefined,
    nextButton: undefined,
    prevButton: undefined,
    url: undefined,
    buttons: [],
    init: function () {
        const section = document.querySelector(this.selector);
        if (section) {
            this.container = section.querySelector(".container");
            this.url = this.container.getAttribute("data-url");
            this.prevButton = section.querySelector(".pagination .prev");
            this.nextButton = section.querySelector(".pagination .next");
            this.initialized = true;

            this.loadPage(section.getAttribute("data-url"));
        }
    },
    loadPage: function (url) {
        const component = Photo.components.featuredPhotoList;
        const request = Biovision.jsonAjaxRequest("get", url, function() {
            const response = JSON.parse(this.responseText);
            if (response.hasOwnProperty("data")) {
                response.data.forEach((item) => {
                    const div = document.createElement("div");
                    const image = document.createElement("img");
                    image.setAttribute("src", item["meta"]["image_url"]);
                    image.setAttribute("alt", item["attributes"]["image_alt_text"]);

                    div.append(image);

                    if (!item["meta"]["featured"]) {
                        const button = document.createElement("button");
                        button.innerHTML = "+";
                        button.setAttribute("data-id", item.id);
                        component.addButton(button);
                        div.append(button);
                    }
                    component.container.append(div);
                })
            }
        });

        request.send();
    },
    addButton: function (button) {
        const component = Photo.components.featuredPhotoList;
        component.buttons.push(button);
        button.addEventListener("click", component.addImage);
    },
    addImage: function (event) {
        const button = event.target;
        const component = Photo.components.featuredPhotoList;
        const url = component.url;
        const data = {"id": button.getAttribute("data-id")};
        const request = Biovision.jsonAjaxRequest("post", url, () => {
            button.remove();
        });

        request.send(JSON.stringify(data));
    }
};

Biovision.components.photo = Photo;

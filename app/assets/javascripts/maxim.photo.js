"use strict";

document.addEventListener('ajax:beforeSend', function(e) {
    var formData = e.detail[1].data
    if (!(formData instanceof window.FormData)) return
    if (!formData.keys) return // unsupported browser
    var newFormData = new window.FormData()
    Array.from(formData.entries()).forEach(function(entry) {
        var value = entry[1]
        if (value instanceof window.File && value.name === '' && value.size === 0) {
            newFormData.append(entry[0], new window.Blob([]), '')
        } else {
            newFormData.append(entry[0], value)
        }
    })
    e.detail[1].data = newFormData
})

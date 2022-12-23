
import "@hotwired/turbo-rails"
import "channels"
import "controllers"

import "core-js/stable"
import "regenerator-runtime/runtime"
import * as ActiveStorage from "@rails/activestorage"
import Rails from "@rails/ujs"
import  "../stylesheets/application";
const images = require.context("../images", true)
const imagePath = (name) => images(name, true)


Rails.start()
ActiveStorage.start()

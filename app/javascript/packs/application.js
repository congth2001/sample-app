import Rails from '@rails/ujs'
import Turbolinks from 'turbolinks'
import * as ActiveStorage from '@rails/activestorage'
import 'channels'
import I18n from 'i18n-js'
window.I18n = I18n 

window.jQuery = window.$ = require('jquery')

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')
require('jquery')
import 'bootstrap'

import './../scss/entry.scss';
import Vue from 'vue'
import Top from './Top'

Vue.config.productionTip = false

new Vue({
    el: '#top',
    template: '<Top/>',
    components: { Top }
})

import './../scss/entry.scss';
import Vue from 'vue'
import Top from './Top'
import ProjectList from './ProjectList'

Vue.config.productionTip = false

if(document.getElementById('top')) {
    new Vue({
        el: '#top',
        template: '<Top/>',
        components: { Top }
    })
}

if(document.getElementById('project-list')) {
    new Vue({
        el: '#project-list',
        template: '<ProjectList/>',
        components: { ProjectList }
    })
}

if(document.getElementById('project-manage')) {
    new Vue({
        el: '#project-manage',
        template: '<ProjectManaget/>',
        components: { projectManage }
    })
}

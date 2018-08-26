import './../scss/entry.scss';
import Vue from 'vue'
import Top from './Top'
import ProjectList from './ProjectList'

Vue.config.productionTip = false

if(document.getElementById('project-manage')) {
    new Vue({
        el: '#project-manage',
        template: '<ProjectManage/>',
        components: { ProjectManage }
    })
}

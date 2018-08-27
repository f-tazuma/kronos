import Vue from 'vue'
import ProjectManage from './projects/ProjectManage'

Vue.config.productionTip = false

if(document.getElementById('project-manage')) {
    new Vue({
        el: '#project-manage',
        template: '<ProjectManage/>',
        components: { ProjectManage }
    })
}

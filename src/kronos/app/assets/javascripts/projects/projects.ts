import Logger from './../common/logger'
import * as $ from 'jquery';
import Vue from 'vue';

import ProjectComponent from './project-component.vue';

class Projects {
    message: string
    id: string;
    data: any;

    constructor() {
        let pathInfo = location.pathname.split('/');
        this.id = String(pathInfo.pop());
        this.main();
    }

    main() {
        this.apiGetData().done((data) => {

            this.showProject();

            // // 取得データ保持
            // this.data = data;
            // // プロジェクト情報表示
            // this.showProject();
        })
    }

    apiGetData() {
        let defer = $.Deferred();
        let url = "/api/projects/" + this.id;
        $.ajax({
            url: url,
            method: "GET"
        })
            .done((data) => {
                Logger.info(url + " success to call api.");
                Logger.debug(data);
                defer.resolve(data);
            })
            .fail(() => {
                Logger.error(url + " failed to call api.");
                defer.reject;
            })
        return defer.promise();
    }

    // 初期化処理
    drawWorkedAndPlanedHours() {

    }

    /**
     * vue.js による画面描画
     */
    showProject() {
        let app = new Vue({
            el: '#vue-app',
            components: { ProjectComponent },
            template: '<project-component>'
        });
    }
}
export default Projects;
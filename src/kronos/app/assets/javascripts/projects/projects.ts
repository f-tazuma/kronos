import Logger from './../common/logger'
import * as $ from 'jquery';
import Vue from 'vue';

class Projects {
    id: any;
    data: any;

    constructor() {
        let pathInfo = location.pathname.split('/');
        this.id = pathInfo.pop();
    }

    main() {
        this.data = this.apiGetData()

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
            data: this.data,
        });
    }
}
export default Projects;
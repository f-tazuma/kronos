import Logger from './../common/logger'
import * as $ from 'jquery';
import Vue from 'vue';

import BaseComponent from "./components/base.vue";
import ProgressComponent from "./components/progress.vue";

class Projects {
    id: string;
    data: any;

    constructor() {
        let pathInfo = location.pathname.split('/');
        this.id = String(pathInfo.pop());
        this.main();
    }

    main() {
        this.apiGetData().done((data) => {
            let prepareData = {
                project : data.project,
                progress : {
                    workHours: data.work_hours,
                    planHours: data.planed_work_hours,
                    terms: data.terms
                }
            }
            this.data = prepareData;
            this.showProject();
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

    /**
     * vue.js による画面描画
     */
    showProject() {
        let data = this.data
        let app = new Vue({
            el: '#app',
            components: { BaseComponent, ProgressComponent },
            data() {
                return data
            }
        });
    }
}
export default Projects;

// 処理実行
(new Projects())
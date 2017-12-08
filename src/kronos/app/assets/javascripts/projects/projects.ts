import Logger from './../common/logger'
import * as $ from 'jquery';
import Vue from 'vue';

import ProjectComponent from './components/project.vue';
import ProgressComponent from './components/progress.vue';




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
            // 計画作業時間入力行とバイディングするための配列を作るため、作業者ごとに配列を保持
            let workerPlanedHours: { [key: string]: any; } = {};

            for(let workerId in data.work_hours) {
                workerPlanedHours[workerId] = {}
                for(let term in data.terms) {
                    workerPlanedHours[workerId][term] = null
                }
            }

            let prepareData = {
                project : data.project,
                progress : {
                    workHours: data.work_hours,
                    planHours: data.planed_work_hours,
                    terms: data.terms,
                    inputPlanHours: workerPlanedHours
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
            template: `
                <div>
                <section>
                    <project-component v-bind:project="project"></project-component>
                </section>
                <section>
                    <progress-component v-bind:progress="progress" v-on:project-upadtePlanWorkHours="upadtePlanWorkHours"></progress-component>
                </section>
                </div>
            `,
            components: { ProjectComponent, ProgressComponent },
            data() {
                return data
            },
            methods : {
                upadtePlanWorkHours : () => {
                    Logger.debug("親関数呼び出し")
                }
            }
        });
    }
}
export default Projects;

// 処理実行
(new Projects())
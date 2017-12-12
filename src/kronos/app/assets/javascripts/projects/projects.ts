import Logger from './../common/logger'
import axios from 'axios';
import Vue from 'vue';

import ProjectComponent from './components/project.vue';
import ProgressComponent from './components/progress.vue';

let app = new Vue({
    el: '#app',
    template: `
                <div>
                <section>
                    <project-component v-bind:project="project"></project-component>
                </section>
                <section>
                    <progress-component v-bind:progress="progress" v-on:project-updatePlanWorkHours="updatePlanWorkHours"></progress-component>
                </section>
                </div>
            `,
    created : function() {
        this.setInitialDisplayData();
    },
    components: { ProjectComponent, ProgressComponent },
    data() {
        return {
            project: {},
            progress: {}
        }
    }
    ,
    methods : {
        //　初期表示
        setInitialDisplayData: function() {
            let pathInfo = location.pathname.split('/');
            let url = "/api/projects/" + String(pathInfo.pop());
            let self = this;

            axios.get(url)
                .then(function (response :any) {
                    Logger.debug("sucsess to call: " + url);
                    Logger.debug(response.data);
                    self.prepareData(response.data)
                })
                .catch(function (error) {
                    Logger.error("sucsess to call: " + url);
                });
        },

        // APIで取得したデータを表示に適したオブジェクトに整形する
        prepareData: function(data :any) {
            // 計画作業時間入力行とバイディングするための配列を作るため、作業者ごとに配列を保持
            let workerPlanedHours: { [key: string]: any; } = {};

            for(let workerId in data.work_hours) {
                workerPlanedHours[workerId] = {}
                for(let term in data.terms) {
                    if(workerId in data.planed_work_hours
                        && term in data.planed_work_hours[workerId]['hours']) {
                        workerPlanedHours[workerId][term] = data.planed_work_hours[workerId]['hours'][term]
                    }else{
                        workerPlanedHours[workerId][term] = null
                    }
                }
            }

            let prepareData = {
                project : data.project,
                progress : {
                    workHours: data.work_hours,
                    // planHours: data.planed_work_hours,
                    terms: data.terms,
                    inputPlanHours: workerPlanedHours
                }
            }
            // dataに値を設定
            this.$data.project = prepareData.project;
            this.$data.progress = prepareData.progress;
        },

        // 作業予定時間を登録する
        updatePlanWorkHours: function() {
            let pathInfo = location.pathname.split('/');

            let url = "/api/projects/plan-work-hours/" + String(pathInfo.pop())
            let self = this;

            axios({
                method: 'post',
                url: url,
                data: self.progress.inputPlanHours
                // data: self.$data.progress.planHours
            }).then(function (response) {
                    console.log(response);
                })
                .catch(function (error) {
                    console.log(error);
                });
        }
    }
});

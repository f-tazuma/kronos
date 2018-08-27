<template>
    <div>
        <section>
            <project-component v-bind:project="project"></project-component>
        </section>
        <section>
            <progress-component v-bind:progress="progress"
                                v-on:project-updatePlanWorkHours="updatePlanWorkHours"
                                v-on:project-searchWorkers="searchWorkers">
            </progress-component>
        </section>
    </div>
</template>

<script>
    import Progress from './components/Progress'
    import Project from './components/Project'

    export default {
        name: "ProjectManage",
        components: {
            Progress,
            Project
        },

        created: function() {
            this.setInitialDisplayData();
        },

        data: function() {
            return {
                project: {
                    project: {},
                    orders: {},
                    total: {}
                },
                progress: {
                    hours: {},
                    weeks: {},
                    weeksOfYearMonth: {},
                    workersSearchConditions: {},
                    isModal: false
                }
            }
        },

        methods: {
            //　初期表示
            setInitialDisplayData: function() {
                let pathInfo = location.pathname.split('/');
                let url = "/api/projects/" + String(pathInfo.pop());
                let self = this;

                axios.get(url)
                    .then(function (response) {
                        Logger.debug("sucsess to call: " + url);
                        Logger.debug(response.data);
                        self.prepareData(response.data)
                    })
                    .catch(function (error) {
                        Logger.error("sucsess to call: " + url);
                    });
            },

            // APIで取得したデータを表示に適したオブジェクトに整形する
            prepareData: function(data) {
                // 計画作業時間入力行とバイディングするための配列を作るため、作業者ごとに配列を保持
                let workerPlanedHours = {};

                for(let workerId in data.work_hours) {
                    workerPlanedHours[workerId] = {}
                    for(let week in data.weeks) {
                        if(workerId in data.planed_work_hours
                            && week in data.planed_work_hours[workerId]['hours']) {
                            workerPlanedHours[workerId][week] = data.planed_work_hours[workerId]['hours'][week]
                        }else{
                            workerPlanedHours[workerId][week] = null
                        }
                    }
                }

                let prepareData = {
                    project: {
                        project: data.project,
                        orders: data.orders,
                        total: data.total
                    },
                    progress : {
                        hours: data.hours,
                        weeks: data.weeks,
                        weeksOfYearMonth: data.weeks_of_year_month,
                        workersSearchConditions: {},
                        isModal: false
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
                let postJson = {'hours' : self.progress.hours}

                axios({
                    method: 'post',
                    url: url,
                    data: postJson
                    // data: self.$data.progress.planHours
                }).then(function (response) {
                    Logger.debug("sucsess to call: " + url);
                    Logger.debug(JSON.stringify(response));
                }).catch(function (error) {
                    console.log(error);
                });
            },

            // 作業者を検索する
            searchWorkers: function() {
                let url = "/api/workers/search"
                let self = this;
                axios({
                    method: 'get',
                    url: url,
                    data: self.progress.workersSearchConditions
                }).then(function (response) {
                    Logger.debug("sucsess to call: " + url);
                    Logger.debug(JSON.stringify(response));
                    self.$data.progress.workers = response.data
                }).catch(function (error) {
                    Logger.error(JSON.stringify(error));
                });
            }
        }
    }
</script>

<style scoped>

</style>
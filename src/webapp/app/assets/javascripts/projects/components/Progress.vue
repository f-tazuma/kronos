<template>
    <div>
        <div class="progress">
            <table>
                <colgroup>
                    <col style='width:120px;'>
                    <col style='width:80px;'>
                    <template v-for="(weeks, key) in progress.weeks">
                        <col style='width:60px;'>
                    </template>
                </colgroup>
                <tbody>
                <tr>
                    <td rowspan="3">氏名</td>
                    <td rowspan="3">予定<br>実績</td>
                    <template v-for="(elem, year) in progress.weeksOfYearMonth">
                        <td :colspan="elem.total">{{year}}年</td>
                    </template>
                </tr>
                <tr>
                    <template v-for="(obj) in progress.weeksOfYearMonth">
                        <template v-for="(elem, month) in obj">
                            <template v-if="month!='total'">
                                <td :colspan="elem">{{month}}月</td>
                            </template>
                        </template>
                    </template>
                </tr>
                <tr>
                    <td v-for="(weeks, key) in progress.weeks">
                        {{weeks.cweek}}
                    </td>
                </tr>

                <template v-for="(elem, workerId) in progress.hours">
                    <tr>
                        <td rowspan="2">{{elem.family_name}}{{elem.first_name}}</td>
                        <td>予定</td>
                        <td v-for="(hours, key) in elem.plan">
                            <input type="number" size="4" width="50px" v-model="progress.hours[workerId]['plan'][key]">
                        </td>
                    </tr>
                    <tr>
                        <td>実績</td>
                        <td v-for="(hours, key) in elem.work">
                            {{hours}}
                        </td>
                    </tr>
                </template>

                </tbody>
            </table>
            <button v-on:click="searchWorkers">作業者追加</button>
            <button v-on:click="updatePlanWorkHours">予定時間更新</button>
        </div>

        <div class="workers" v-if="progress.isModal">
            <table>
                <thead>
                    <td class="check">選択</td>
                    <td class="worker_name">氏名</td>
                </thead>

                    <tr v-for="(elem) in progress.workers">
                        <td class="check"><button v-on:click="addWorker(elem.worker_number)">追加</button></td>
                        <td class="worker_name">{{elem.family_name}}{{elem.first_name}}</td>
                    </tr>
            </table>
            <button class="btn" @click="progress.isModal = false">閉じる</button>
        </div>
    </div>
</template>

<script>
    import Vue from "vue";
    import Logger from './../../common/Logger'
    // import WorkHours from './../../model/work_hours_model'

    export default Vue.extend({
        props: ["progress"],
        methods: {
            // 作業予定登録
            updatePlanWorkHours: function() {
                this.$emit('project-updatePlanWorkHours');
            },
            // 作業者検索
            searchWorkers: function() {
                this.progress.isModal = true;
                this.$emit('project-searchWorkers');
            },
            // 作業者追加
            addWorker: function(workerNumber) {
                Logger.debug(workerNumber)
                let targetWorker = this.progress.workers[workerNumber]

                let workHours = {}
                let planWorkHours = {}
                workHours['family_name'] = targetWorker.family_name
                workHours['first_name'] = targetWorker.first_name
                workHours['hours'] = {}
                for(let key in this.progress.weeks) {
                    workHours['hours'][key] = null
                }

                for(let key in this.progress.weeks) {
                    planWorkHours[key] = null
                }

                // 作業実績と作業予定に対象の作業者を追加
                this.$set(this.progress.workHours, workerNumber, workHours)
                this.$set(this.progress.inputPlanHours, workerNumber, planWorkHours)
            }
        }
    })
</script>

<style scoped>
    .progress {
        width: 900px;
        overflow-y:scroll;
    }

    table {
        border-collapse: collapse;
        table-layout: fixed;
        width: 100%;
    }

    table thead td,
    table tr th,
    table tr td {
        padding: 0 5px;
        border: 1px solid #DDD;
        text-align: center;
        vertical-align: middle;
        width: 50px;
    }
    table tr td input {
        width: 90%;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    table tr th {
        text-align: center;
        font-weight: bold;
    }
</style>
<template>
    <div>
        <div class="progress">
            <table>
                <thead>
                <td class="worker_name">氏名</td>
                <td>予定<br>実績</td>
                <td v-for="(term, key) in progress.terms">
                    {{term.cweek}}
                </td>
                </thead>

                <template v-for="(elem, workerId) in progress.workHours">
                    <tr>
                        <td class="worker_name" rowspan="2">{{elem.family_name}}{{elem.first_name}}</td>
                        <td>予定</td>
                        <td v-for="(hours, key) in elem.hours">
                            <input type="number" size="4" v-model="progress.inputPlanHours[workerId][key]">
                        </td>
                    </tr>
                    <tr>
                        <td>実績</td>
                        <td v-for="(hours, key) in elem.hours">
                            {{hours}}
                        </td>
                    </tr>
                </template>
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

<script lang="ts">
    import Vue from "vue";
    import Logger from './../../common/logger'
    import WorkHours from './../../model/work_hours_model'

    export default Vue.extend({
        props: ["progress"],
        methods: {
            // 作業予定登録
            updatePlanWorkHours() {
                this.$emit('project-updatePlanWorkHours');
            },
            // 作業者検索
            searchWorkers() {
                this.progress.isModal = true;
                this.$emit('project-searchWorkers');
            },
            // 作業者追加
            addWorker(workerNumber :any) {
                Logger.debug(workerNumber)
                let targetWorker = this.progress.workers[workerNumber]

                let workHours = new WorkHours()
                workHours.family_name = targetWorker.family_name
                workHours.first_name = targetWorker.first_name

                // progress.termsをループして対象期間のキーを作成
                let hours = {}
                for(let key in this.progress.terms) {
                    workHours.hours[key] = null
                }

                this.prgress.workHours.push(workHours)
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

    table thead td.worker_name,
    table tr td.worker_name
    {
        width: 100px;
    }

    table tr th {
        text-align: center;
        font-weight: bold;
    }
</style>
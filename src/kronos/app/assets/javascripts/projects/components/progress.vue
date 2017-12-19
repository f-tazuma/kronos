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

        <div class="workers">
            <transition name="modal" v-if="progress.isModal">
                <table>
                    <thead>
                        <td class="check">選択</td>
                        <td class="worker_name">氏名</td>
                    </thead>

                    <template v-for="(elem) in progress.workers">
                        <tr>
                            <td class="check"><input type="checkbox" value={elem.worker_number}/></td>
                            <td class="worker_name">{{elem.family_name}}{{elem.first_name}}</td>
                        </tr>
                    </template>
                </table>
                <button class="btn" @click="progress.isModal = false">閉じる</button>
            </transition>
        </div>
    </div>
</template>

<script lang="ts">
    import Vue from "vue";
    import Logger from './../../common/logger'

    export default Vue.extend({
        props: ["progress"],
        methods: {
            updatePlanWorkHours() {
                this.$emit('project-updatePlanWorkHours');
            },
            searchWorkers() {
                this.progress.isModal = true;
                this.$emit('project-searchWorkers');
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
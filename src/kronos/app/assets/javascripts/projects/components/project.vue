<template>
    <div>
        <section>
            <table>
                <tr>
                    <td>プロジェクトNo</td><td>{{project.project.project_no}}</td>
                </tr>
                <tr>
                    <td>プロジェクト名</td><td>{{project.project.name}}</td>
                </tr>
                <tr>
                    <td>開始日</td><td>{{project.project.work_start_date}}</td>
                </tr>
                <tr>
                    <td>終了(予定)日</td><td>{{project.project.work_end_date}}</td>
                </tr>
            </table>
        </section>

        <section>
            <h2>工数情報</h2>
            <table>
                <tr><td>受注工数</td><td>{{ getSumTotalOrderedWorkHours }}</td></tr>
                <tr><td>作業済工数</td><td>{{ getSumTotalConsumeWorkedHours }}</td></tr>
                <tr><td>予定作業工数</td><td>{{ getSumTotalPlanWorkedHours }}</td></tr>
            </table>
        </section>

        <section>
            <h2>受注情報</h2>
            <table>
                <tr v-for="(order, key) in project.orders">
                    <td></td>
                    <td>{{order.order_no}}</td>
                    <td>{{order.name}}</td>
                    <td>{{order.estimate_work_hours}}</td>
                    <td>{{order.ordered_volume | money}}</td>
                </tr>
            </table>
        </section>
    </div>
</template>

<script lang="ts">
    import Vue from "vue";
    import Logger from "./../../common/logger"

    export default Vue.extend({
        props: ["project"],
        computed: {
            getSumTotalConsumeWorkedHours: function() {
                let sum_hours = 0
                let data = this.project.total_consume_worked_hours
                for (var key in data) {
                    if (data.hasOwnProperty(key)) {
                        let elem = data[key];
                        sum_hours += parseFloat(elem.worked_hours)
                    }
                }
                return sum_hours
            },
            getSumTotalPlanWorkedHours: function() {
                let sum_hours = 0
                let data = this.project.total_planed_work_hours
                for (var key in data) {
                    if (data.hasOwnProperty(key)) {
                        let elem = data[key];
                        sum_hours += parseFloat(elem.worked_hours)
                    }
                }
                return sum_hours
            },
            getSumTotalOrderedWorkHours: function() {
                let sum_hours = 0
                let data = this.project.orders
                for (var key in data) {
                    if (data.hasOwnProperty(key)) {
                        let elem = data[key];
                        if(elem.estimate_work_hours != null) {
                            sum_hours += parseFloat(elem.estimate_work_hours)
                        }
                    }
                }
                return sum_hours
            }
        }
    })
</script>

<style scoped>
    ul.project {
        display:table;
        table-layout:fixed;
    }
    ul.project li {
        display:table-cell;
        vertical-align:middle;
        text-align:center;
    }
    ul.project li:first-child {
        border:none;
    }

    ul.orders {
        display:table;
        table-layout:fixed;
    }
    ul.orders li {
        display:table-cell;
        vertical-align:middle;
        text-align:center;
    }
    ul.orders li:first-child {
        border:none;
    }

</style>
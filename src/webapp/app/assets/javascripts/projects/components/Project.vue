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

        <section class="work-hours">
            <h2>工数情報</h2>
            <table>
                <tr>
                    <td>受注工数</td><td>{{ project.total.total_estimate_work_hours }}</td>
                </tr>
                <tr>
                    <td>作業済工数</td><td>{{ project.total.total_consume_worked_hours }} ({{ project.total.current_rate_of_work_hour_progress }}%)</td>
                </tr>
                <tr>
                    <td>予定作業工数</td><td>{{ project.total.total_planed_work_hours }}</td>
                </tr>
                <tr>
                    <td>着地見込工数</td><td>{{ project.total.landing_total_work_hours }}</td>
                </tr>
            </table>
        </section>

        <section class="orders">
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

<script>
    import Vue from "vue";
    import Logger from "./../../common/logger"

    export default Vue.extend({
        props: ["project"],
        computed: {
            getEstimateTotalWorkHours: function() {
                return parseFloat(this.project.total.total_consume_worked_hours) + parseFloat(this.project.total.total_planed_work_hours)
            },
            getWorkHourRate: function() {
                let rate = this.project.total.total_consume_worked_hours / this.project.total.total_estimate_work_hours * 100
                return rate.toFixed(2)
            },
            getEstimateWorkHourRate: function() {
                let rate = (parseFloat(this.project.total.total_consume_worked_hours) + parseFloat(this.project.total.total_planed_work_hours)) / parseFloat(this.project.total.total_estimate_work_hours) * 100
                return rate.toFixed(2)
            }
        }
    })
</script>

<style scoped>
    .work-hours {
        display: inline-block;
    }
    .orders {
        display: inline-block;
    }

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
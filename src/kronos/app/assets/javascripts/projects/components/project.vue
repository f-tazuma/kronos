<template>
    <div>
        <ul class="project">
            <li>{{project.project.name}}</li>
            <li>{{project.project.project_no}}</li>
            <li>{{project.project.work_start_date}}</li>
            <li>{{project.project.work_wnd_date}}</li>
        </ul>
        <p>受注情報</p>
        <ul class="orders" v-for="(order, key) in project.orders">
            <li>{{order.order_no}}</li>
            <li>{{order.name}}</li>
            <li>{{order.estimate_work_hours}}</li>
            <li>{{order.ordered_volume | money}}</li>
        </ul>
    </div>
</template>

<script lang="ts">
    import Vue from "vue";

    export default Vue.extend({
        props: ["project"]
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
<template>
    <table>
        <thead>
            <td class="worker_name">氏名</td>
            <td v-for="(term, key) in progress.terms">
                {{term.cweek}}
            </td>
        </thead>

        <tr v-for="(elem, key) in progress.workHours">
            <td class="worker_name">{{elem.family_name}}{{elem.first_name}}</td>
            <td v-for="(hours, key) in elem.hours">
                {{hours}}
            </td>
        </tr>

    </table>
</template>

<script lang="ts">
    import Vue from "vue";

    export default Vue.extend({
        props: ["progress"]
    })
</script>

<style scoped>
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
        vertical-align: middle;
        width: 50px;
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
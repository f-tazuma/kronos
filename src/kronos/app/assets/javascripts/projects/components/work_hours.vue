<template>
    <table>
        <tr v-for="(elem, key) in work_hours">
            <td>{{elem.family_name}}</td>
            <td>{{elem.first_name}}</td>

            <td v-for="(hours, key) in elem.hours" v-if="">
                {{hours}}
            </td>
        </tr>

    </table>
</template>

<script lang="ts">
    import Vue from "vue";

    export default Vue.extend({
        props: ["work_hours"]
    })
</script>

<style scoped>

</style>
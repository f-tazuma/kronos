<template>
    <div>
        <ul>
            <li>{{project.name }}</li>
            <li>{{project.project_no }}</li>
            <li>{{project.work_start_date }}</li>
            <li>{{project.work_wnd_date }}</li>
        </ul>
    </div>
</template>

<script lang="ts">
    import Vue from "vue";

    export default Vue.extend({
        name: "project-component",
        data() {
            return {
                project : {
                    name : "名前",
                    project_no : "00001"
                }
            }
        }
    });
</script>

<style scoped>

</style>
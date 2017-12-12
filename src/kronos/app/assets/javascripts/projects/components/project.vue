<template>
    <div>
        <ul>
            <li>{{project.name}}</li>
            <li>{{project.project_no}}</li>
            <li>{{project.work_start_date}}</li>
            <li>{{project.work_wnd_date}}</li>
            <li>{{project.work_wnd_date}}</li>
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

</style>
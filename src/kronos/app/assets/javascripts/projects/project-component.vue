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

<script>
    export default {
        props: ['project']
    }
</script>

<style scoped>

</style>
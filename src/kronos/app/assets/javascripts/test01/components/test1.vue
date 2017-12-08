<template>
    <div>{{test1.text1}}</div>
</template>

<script lang="ts">
    import Vue from "vue";
    export default Vue.extend({
        props: ["test1"]
    })
</script>

<style scoped>

</style>
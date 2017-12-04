<template>
    <ul>
        <li>{{greet}}</li>
    </ul>
</template>

<script lang="ts">
    import Vue from "vue";
    export default {
        name: "base",
        data() {
            return {
                greet : "こんにちわ"
            }
        }
    }
</script>

<style scoped>

</style>
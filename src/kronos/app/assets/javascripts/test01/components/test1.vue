<template>
    <section>

        <div>
            <ul>
                <li v-for="(val, key) in param.param1">
                    {{key}} - {{val}}
                </li>
            </ul>
        </div>

    </section>
</template>

<script lang="ts">
    import Vue from "vue";
    export default Vue.extend({
        props: ["param"]
    })
</script>

<style scoped>

</style>
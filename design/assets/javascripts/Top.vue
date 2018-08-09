
<template>
    <div>
        <section class="app-header">
        </section>

        <section class="app-menu">
            <Menu/>
        </section>

        <section class="app-contents">

        </section>
    </div>
</template>

<script>
    import Menu from './Menu.vue'
    export default {
        name: "Top",
        components: {Menu}
    }
</script>

<style scoped>

</style>

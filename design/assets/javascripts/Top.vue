
<template>
    <div>
        <section class="app-section-header">
        </section>

        <section class="app-section-menu">
            <div class="app-top-menu"><Menu/></div>
            <div class="app-top-user"><LoginUser v-bind:loginUser="loginUser"></LoginUser></div>
        </section>

        <section class="app-section-contents">

        </section>
    </div>
</template>

<script>
    import Menu from './common/Menu.vue'
    import LoginUser from './common/LoginUser'
    import dataLoginUser from './data/LoginUser.json';

    export default {
        name: "Top",
        components: {
            Menu,
            LoginUser
        },
        data: function() {
            return {
                loginUser: dataLoginUser
            }
        }
    }
</script>

<style scoped lang="scss">
</style>

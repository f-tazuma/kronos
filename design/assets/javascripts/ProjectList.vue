
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
    import dataLoginUser from './data/LoginUser.json'

    export default {
        name: "ProjectList",
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
    .app-section-menu {
        background-color: #00008b;
        height: 80px;
        line-height: 80px;
        .app-top-menu {
            float: left;
            height: 80px;
            line-height: 80px;
        }
        .app-top-user {
            float: right;
            height: 80px;
            line-height: 80px;
        }
    }
</style>

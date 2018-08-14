
<template>
    <div>
        <section class="app-section-header">
        </section>

        <section class="app-section-menu">
            <Menu/>
            <LoginUser v-bind:user="user"></LoginUser>
        </section>

        <section class="app-section-contents">

        </section>
    </div>
</template>

<script>
    import Menu from './common/Menu.vue'
    import LoginUser from './common/LoginUser'
    export default {
        name: "Top",
        components: {
            Menu,
            LoginUser
        },
        data: function() {
            return {
                user: {
                    first_name: "太郎",
                    family_name: "山田",
                    full_name: "山田 太郎",
                    having_roles: ["プロジェクトマネージャ", "エンジニア", "営業"],
                    role: "プロジェクトマネージャ"
                }
            }
        }
    }
</script>

<style scoped>
</style>

<template>
    <div class="app-login-user">
        <ul>
            <li>{{loginUser.full_name}} {{loginUser.role}}</li>
            <li><button>ログアウト</button></li>
        </ul>
    </div>
</template>

<script>
    export default {
        name: "LoginUser",
        props: ["loginUser"],
    }
</script>

<style scoped lang="scss">
    .app-login-user {
        ul {
            margin: 0;
            vertical-align: middle;
        }
        li {
            display: inline-block;
            margin: 0 10px;
            color: #ffffff;
        }
    }
</style>

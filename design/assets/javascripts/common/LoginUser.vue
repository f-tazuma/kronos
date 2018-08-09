<template>
    <div>
        <ul>
            <li>{{user.full_name}}</li>
            <li>{{user.role}}</li>
            <li><button>ログアウト</button></li>
        </ul>
    </div>
</template>

<script>
    export default {
        name: "LoginUser",
        props: [user],
    }
</script>

<style scoped>

</style>

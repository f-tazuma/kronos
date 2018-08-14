<template>
    <div class="app-menu">
        <ul>
            <li><a href="/projects">プロジェクト管理</a></li>
            <li><a href="/orders">受注管理</a></li>
            <li><a href="/sales-outputs">売上管理</a></li>
            <li><a href="/staffs">社員管理</a></li>
        </ul>
    </div>
</template>

<script>
    export default {
        name: "Menu"
    }
</script>

<style scoped lang="scss">
    .app-menu {
        background-color: #fdd35c;
        height: 50px;
        line-height: 50px;
        ul {
            text-align: center;
            vertical-align: middle;
        }
        li {
            display: inline-block;
        }
    }
</style>

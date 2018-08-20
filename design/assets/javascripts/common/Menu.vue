<template>
    <div class="app-menu">
        <ul>
            <li><a href="./project-list.html">プロジェクト管理</a></li>
            <li><a href="./orders">受注管理</a></li>
            <li><a href="./sales-outputs">売上管理</a></li>
            <li><a href="./staffs">社員管理</a></li>
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
        ul {
            margin: 0;
            vertical-align: middle;
        }
        li {
            display: inline-block;
            margin: 0 10px;

            a:any-link {
                color: #ffffff;
                font-size: 16px;
                text-decoration: none;
            }
        }
    }
</style>

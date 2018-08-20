
<template>
    <div>
        <section class="app-section-header">
        </section>

        <section class="app-section-menu">
            <div class="app-top-menu"><Menu/></div>
            <div class="app-top-user"><LoginUser v-bind:loginUser="loginUser"></LoginUser></div>
        </section>

        <section class="app-section-contents">
            <table>
                <tr>
                    <th>ID</th>
                    <th>プロジェクトNo</th>
                    <th>プロジェクト名</th>
                    <th>開始日</th>
                    <th>終了日</th>
                    <th>備考</th>
                </tr>
                <tr v-for="project in projectList">
                    <td >{{ project.id }}</td>
                    <td >{{ project.no }}</td>
                    <td >{{ project.name }}</td>
                    <td >{{ project.start_day }}</td>
                    <td >{{ project.end_day }}</td>
                    <td >{{ project.description }}</td>
                </tr>
            </table>
        </section>
    </div>
</template>

<script>
    import Menu from './common/Menu.vue'
    import LoginUser from './common/LoginUser'
    import dataLoginUser from './data/LoginUser.json'
    import dataProjectList from './data/ProjectList.json'

    export default {
        name: "ProjectList",
        components: {
            Menu,
            LoginUser
        },
        data: function() {
            return {
                loginUser: dataLoginUser,
                projectList: dataProjectList
            }
        }
    }
</script>

<style scoped lang="scss">

</style>

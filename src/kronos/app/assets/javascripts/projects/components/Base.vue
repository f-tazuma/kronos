<template>
    <ul>
        <li>{{greet}}</li>
    </ul>
</template>

<script lang="ts">
    import Logger from "./../../common/logger"
    import * as $ from 'jquery';
    import Vue from "vue";
    export default {
        name: "base",
        data(this: any) {
          return {
              data: this.apiGetData.done((data: any) => {
                  this.data = data
              })
          }
        },
        methods: {
            apiGetData: () => {
                let defer = $.Deferred();
                let url = "/api/projects/1"
                $.ajax({
                    url: url,
                    method: "GET"
                })
                    .done((data) => {
                        Logger.info(url + " success to call api.");
                        Logger.debug(data);
                        defer.resolve(data);
                    })
                    .fail(() => {
                        Logger.error(url + " failed to call api.");
                        defer.reject;
                    })
                return defer.promise();
            }
        }
    }
</script>

<style scoped>

</style>
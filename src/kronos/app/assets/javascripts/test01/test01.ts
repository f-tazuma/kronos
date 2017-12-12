import Vue from "vue";
import Test1Component from "./components/test1.vue";
import ApiTest from './api_test';

let app = new Vue({
    el: '#app',
    template: `
                <div>
                <section>
                    <test1-component v-bind:test1="test1"></test1-component>
                </section>
                </div>
            `,
    components: { Test1Component },
    data() {
        return {
            test1 : {text1 : "こんにちわ"},
            projectInfo : {}
        };
    },
    created : function() {
    }
    ,
    methods : {
        updatePlanWorkHours : () => {

        }
    }
});
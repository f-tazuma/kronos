import Vue from "vue";
import Test1Component from "./components/test1.vue";
import ApiTest from './api_test';

let app = new Vue({
    el: '#app',
    template: `
                <div>
                <section>
                    <test1-component v-bind:param="param"></test1-component>
                </section>
                </div>
            `,
    components: { Test1Component },
    data() {
        return {
            test1 : {
                text1 : "こんにちわ"
            },
            param : {
                param1: {name: "鈴木", age: 30}
            }
        };
    },
    created : function() {
    }
    ,
    methods : {
        updateParam1: function(name: string, age: number) {
            this.param.param1.name = name
            this.param.param1.age = age
        }
    }
});
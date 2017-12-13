import Vue from "vue";

export default class Filter {
    constructor() {
        // 金額表示
        Vue.filter('money', function (value :any) {
            if (!value) return ''
            return value.toLocaleString();
        })
    }
}
import Vue from "vue";
import BaseComponent from "./components/Base.vue";

let v = new Vue({
    el: "#app",
    template: `
        <div>
            <base-component/>
        </div>
    `,
    components: {
        BaseComponent
    }
});
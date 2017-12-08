// import * as $ from "jquery";
import axios from 'axios';
import Logger from "../common/logger";

class ApiTest {

    static getProjectData() {
        let url = "/api/projects/1"
        axios.get(url)
            .then((res) => {
                return res.data
            });
    }

    static getProjectData1() {
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

}export default ApiTest;
export default class Logger {

    static level(){
        return "debug";
    }

    static get logLevels(){
        let levels = {}
        levels["debug"] = 0
        levels["info"] = 1
        levels["warning"] = 2
        levels["error"] = 3
        return levels;
    }

    static debug(msg) {
        let levels = this.logLevels;
        if(levels[this.level] <= levels["debug"]) {
            this.log(msg);
        }
    }

    static info(msg) {
        let levels = this.logLevels;
        if(levels[this.level] <= levels["info"]) {
            this.log(msg);
        }
    }

    static warning(msg) {
        let levels = this.logLevels;
        if(levels[this.level] <= levels["warning"]) {
            this.log(msg);
        }
    }

    static error(msg) {
        let levels = this.logLevels;
        if(levels[this.level] <= levels["error"]) {
            this.log(msg);
        }
    }

    static log(msg) {
        console.log(msg);
    }
}

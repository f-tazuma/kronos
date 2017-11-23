class Logger {

    static get level() :string{
        return "debug";
    }

    static get logLevels() :any{
        let levels = {
            "debug" : 0,
            "info" : 1,
            "warning" : 2,
            "error" : 3
        };
        return levels;
    }

    static debug(msg :string) {
        let levels = this.logLevels;
        if(levels[this.level] <= levels["debug"]) {
            this.log(msg);
        }
    }

    static info(msg :string) {
        let levels = this.logLevels;
        if(levels[this.level] <= levels["info"]) {
            this.log(msg);
        }
    }

    static warning(msg :string) {
        let levels = this.logLevels;
        if(levels[this.level] <= levels["warning"]) {
            this.log(msg);
        }
    }

    static error(msg :string) {
        let levels = this.logLevels;
        if(levels[this.level] <= levels["error"]) {
            this.log(msg);
        }
    }

    static log(msg :string) {
        console.log(msg);
    }
}
export default Logger
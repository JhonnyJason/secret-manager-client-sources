network = {}

if typeof window == "object"
    network = require("./networkbrowser")
else
    network = require("./networknode")

module.exports = network
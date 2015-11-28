local skynet = require "skynet"


skynet.start(function()
    skynet.newservice ("test_proto")
end)

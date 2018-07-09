require "reload"


local ss = require "test"  
local ave,sum = ss.average(1,2,3,4,5)
print(ave,sum)  -- 3 15  
ss.sayHello()   -- hello world!
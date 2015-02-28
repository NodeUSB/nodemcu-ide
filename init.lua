
host="i.nodeusb.com"
function getFile(p,f)
  local strPost = "GET /"..p.."f="..f.." HTTP/1.0\r\nHost: "..host.."\r\n\r\n"
  local sk=net.createConnection(net.TCP, 0)

  local s=0
  file.remove(f)
  file.open(f,"a")

  sk:on("connection", function(sck) sk:send(strPost) end)

  sk:on("receive", function(sck, res)
     local pos=string.find(res,"%c%c%c")
     if pos~=nil then
          s=1
          pos=pos+4
     else
        pos=0
     end
     if s==1 then
          file.write(res:sub(pos))
     end
     res=nil 
     collectgarbage() 
  end)

  sk:dns(host,function(conn,ip) sk:connect(80,ip) end)
  tmr.alarm(5,2000,0,function() sk:close() sk=nil strPost = nil file.close() collectgarbage() end)
end

tmr.alarm(0,3000,1,function()

     ip = wifi.sta.getip()
     if(ip==nil) then
          print("Offline")
     else
          print('downloading\r\nd.lua')
          tmr.stop(0)
          
          getFile('e?','d.lua')

          tmr.alarm(1,4000,0,function() collectgarbage() node.compile('d.lua') print('i.lua') getFile('e?','i.lua') collectgarbage() end)
          tmr.alarm(2,8000,0,function() collectgarbage() node.compile('i.lua') print('init.lua') getFile('e?','init.lua') collectgarbage() tmr.alarm(3,5000,0,function() print("Done,reboot") node.restart() end) end)
          
          collectgarbage()
     end

end)

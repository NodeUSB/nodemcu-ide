local moduleName = ...
local M = {}
_G[moduleName] = M

host="i.nodeusb.com"

function M.g(p,f,a)
  local strPost = "GET /"..p.."f="..f.." HTTP/1.0\r\nHost: "..host.."\r\n\r\n"
  local sk=net.createConnection(net.TCP, 0)

  local s=0

  if a==nil then
     file.remove(f)
  end
  file.open(f,"a")

  sk:on("connection", function(sck) sk:send(strPost) end)

  sk:on("receive", function(sck, res)
     local pos=string.find(res,"%c%c%c")
     --print(pos)
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

function M.r(ip,mac)
 local strPost = "GET /a?ip="..ip.."&mac="..mac.." HTTP/1.0\r\nHost: "..host.."\r\n\r\n"
 local sk=net.createConnection(net.TCP, 0)

 sk:on("connection", function(sck) sk:send(strPost) end)
 sk:on("receive", function(sck, res) print(res) res=nil collectgarbage() end)
 sk:dns(host,function(conn,ip) sk:connect(80,ip) print(ip) collectgarbage() end)
 tmr.alarm(5,2000,0,function() sk:close() sk=nil strPost = nil collectgarbage() end)
end

return M

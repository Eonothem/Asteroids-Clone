--Just a little function I found online to make an interator
--Since lua doesn't have one built in

function list_iter(t)
    local i = 0
    local n = table.getn(t)
    
    return function ()
        i = i + 1
        if i <= n then return t[i] end
    end
end
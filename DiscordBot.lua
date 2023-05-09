local function expect(func, arg, expected)
    if type(arg) ~= expected then
        return error('bad argument, expected ' .. expected .. ', got ' .. type(arg) .. ' in function: ' .. func)
    end
end

local function sendHTTP(url, data, headers)
    local request, message = http.post(url, data, headers)
    if request then
        return true
    end
    return false
end

function createBot(token)
    expect('DiscordBot', token, 'string')
    local header = {['Authorization'] = 'Bot ' .. token}
    local _ = {}

    function _.send(message, channelID)
        expect('send', message, 'string')
        expect('send', channelID, 'string')
        local data = 'content=' .. textutils.urlEncode(message)
        local success = sendHTTP('https://discord.com/api/v10/users/@me/channels/' .. channelID .. '/messages', data, header)
    end

    return _
end
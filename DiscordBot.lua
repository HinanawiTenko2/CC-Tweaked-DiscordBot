local function expect(func, arg, expected)
    if type(arg) ~= expected then
        return error('bad argument, expected ' .. expected .. ', got ' .. type(arg) .. ' in function: ' .. func)
    end
end

local function sendHTTP(url, data, headers)
    local request, message = http.post(url, data, headers)
    if request then
        return true, request, message
    end
    return false, request, message
end

function createBot(token)
    expect('DiscordBot', token, 'string')

    local auth = 'Bot ' .. token
    local _ = {}

    function _.send(message, channelID)
        local header = {['Authorization'] = auth, ['Content-Type'] = 'application/x-www-form-urlencoded'}
        print(auth)
        expect('send', message, 'string')
        expect('send', channelID, 'string')
        local data = 'content=' .. textutils.urlEncode(message)
        print(data)
        local url = 'https://discord.com/api/v10/users/@me/channels/' .. channelID .. '/messages'
        print(url)
        local success, request, message = sendHTTP(url, data, header)
        return success, request, message
    end

    return _
end
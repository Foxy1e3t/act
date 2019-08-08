script_name("AutoCarTheft")
script_authors("Foxy1e3t")
script_version("1.0")
script_version_number(1)

local sampev = require 'lib.samp.events'

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
    autoupdate("http://foxy1e3t.000webhostapp.com/autoupdate.json", '['..string.upper(thisScript().name)..']: ', "https://gitlab.com/Foxy1e3t/act/blob/a9f399788938459401cd4228f33393a1e5770b9d/act")
    sampAddChatMessage("{454545}[ACT]{FFFFFF}by {999999}Foxy1e3t", -1)
    sampAddChatMessage("{454545}[ACT]{FFFFFF}Команда взлома:{999999}/act", -1)
    sampAddChatMessage("{454545}[ACT]{FFFFFF}Команда включение отображения id текстдравов:{999999}/actt", -1)
    sampRegisterChatCommand('act',theft)
    sampRegisterChatCommand('actt', function() funk = not funk end)
    wait(-1)
end

function theft(text)
    if text == ''then
        sampAddChatMessage('Введите модель конкретной машины и Id текстдрава "clear point".',-1)
        sampAddChatMessage('Пример: /act sultan 2130',-1)
    end 
    if text == "sultan 2130" then
        lua_thread.create(function()
            for i = 1, 70 do
            sampSendClickTextdraw(2126)
            wait(1)
            end
            for i = 1, 68 do
                sampSendClickTextdraw(2130)
                wait(1)
            end
            for i = 1, 47 do
                sampSendClickTextdraw(2132)
                wait(1)
            end
            for i = 1, 66 do
                sampSendClickTextdraw(2140)
                wait(1)
            end
            for i = 1, 54 do
                sampSendClickTextdraw(2146)
                wait(1)
            end
            sampSendClickTextdraw(2065)
       end)

    elseif text == "cheetah" then
        lua_thread.create(function()
            for i = 1, 66 do
            sampSendClickTextdraw(2126)
            wait(1)
            end
            for i = 1, 56 do
                sampSendClickTextdraw(2130)
                wait(1)
            end
            for i = 1, 39 do
                sampSendClickTextdraw(2134)
                wait(1)
            end
            for i = 1, 60 do
                sampSendClickTextdraw(2138)
                wait(1)
            end
            for i = 1, 74 do
                sampSendClickTextdraw(2142)
                wait(1)
            end
            for i = 1, 80 do
                sampSendClickTextdraw(2144)
                wair(1)
            end
            sampSendClickTextdraw(2065)
    end)
    elseif text == "euros" then
        lua_thread.create(function()
            for i = 1, 55 do
            sampSendClickTextdraw(2136)
            wait(1)
            end
            for i = 1, 60 do
                sampSendClickTextdraw(2140)
                wait(1)
            end
            for i = 1, 59 do
                sampSendClickTextdraw(2146)
                wait(1)
            end
            for i = 1, 61 do
                sampSendClickTextdraw(2148)
                wait(1)
            end
            sampSendClickTextdraw(2065)
    end)
end
end

function sampev.onSendClickTextDraw(id)
 if funk then
    sampAddChatMessage(id, -1)
    return true
end
end


function autoupdate(json_url, prefix, url)
    local dlstatus = require('moonloader').download_status
    local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
    if doesFileExist(json) then os.remove(json) end
    downloadUrlToFile(json_url, json,
      function(id, status, p1, p2)
        if status == dlstatus.STATUSEX_ENDDOWNLOAD then
          if doesFileExist(json) then
            local f = io.open(json, 'r')
            if f then
              local info = decodeJson(f:read('*a'))
              updatelink = info.updateurl
              updateversion = info.latest
              f:close()
              os.remove(json)
              if updateversion ~= thisScript().version then
                lua_thread.create(function(prefix)
                  local dlstatus = require('moonloader').download_status
                  local color = -1
                  sampAddChatMessage((prefix..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion), color)
                  wait(250)
                  downloadUrlToFile(updatelink, thisScript().path,
                    function(id3, status1, p13, p23)
                      if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                        print(string.format('Загружено %d из %d.', p13, p23))
                      elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                        print('Загрузка обновления завершена.')
                        sampAddChatMessage((prefix..'Обновление завершено!'), color)
                        goupdatestatus = true
                        lua_thread.create(function() wait(500) thisScript():reload() end)
                      end
                      if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                        if goupdatestatus == nil then
                          sampAddChatMessage((prefix..'Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
                          update = false
                        end
                      end
                    end
                  )
                  end, prefix
                )
              else
                update = false
                print('v'..thisScript().version..': Обновление не требуется.')
              end
            end
          else
            print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..url)
            update = false
          end
        end
      end
    )
    while update ~= false do wait(100) end
  end
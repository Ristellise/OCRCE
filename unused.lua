local eof = false
-- Render Thread now uses structs!


-- Timer function to time updates
--[[
local function timer()
    local continue = true
    while continue do
        local ftick = 1
        while true do
            if tablelength(framebuffer) >= 15 then
                -- We have enough frames. Move them to secondary framebuffer
                for k,v in pairs(framebuffer) do
                    if k > 15 then
                        break
                    else
                        secondframebuff[k] = v
                        table.remove(framebuffer,k)
                    end
                end
                break
            else
                if not eof then
                    continue = false
                end
                -- not enough frames for a full second.. soo we wait.
                os.sleep(0)
            end
        end
        local dt = computer.uptime()
        while true do
            -- We are out of time for this second.
            if computer.uptime() - dt >= 1.00 then
                print("Emptying DT")
                -- Empty 15 frame/sec buffer
                secondframebuff = {}
                break
            end
            if ftick == 16 then
                print("Waiting for next second")
                -- We are early.. which is nice...
                break
            else
                -- render frame. and delete it from 15frame/sec buffer
                print("rendering...")
                render()
                ftick = ftick + 1
            end
            -- so that it doesnt look like we all at one shot just rendered it.
            -- But it's the hard truth
            os.sleep(0.005)
        end
    end
    return true
end
--]]
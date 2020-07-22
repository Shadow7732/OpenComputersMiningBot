r = require "robot"
invHandler = require "inventoryHandler"

distanceToMove = 10

tunnelWidth = 3
tunnelHeight = 3

currentTunnelX = 1
currentTunnelY = 1

removeBlockSleepTime = 0.5

while distanceToMove >= 0 do
    if r.durability() == 0 or r.durability() == nil then

		if invHandler.exchangeTool(tool) then
            print("Tool was exchanged...")
            
		else
			print("Error: No tool")
			while r.durability() == 0 or r.durability() == nil do
				os.sleep(5)
            end
            
            print("Found a tool now, continuing...")
            
		end
    end
    
    while tunnelWidth > currentTunnelX do
        while tunnelHeight > currentTunnelY do

            if r.detectUp() == true then
                r.swingUp()
            end

            os.sleep(removeBlockSleepTime)
            r.up()
            currentTunnelY = currentTunnelY + 1
        end

        if currentTunnelY > 1 then
            for i = tunnelHeight, 2, -1 do
                r.down()
                currentTunnelY = currentTunnelY - 1
            end
        end

        r.turnRight()

        if r.detect() == true then
            r.swing()
            os.sleep(removeBlockSleepTime)
        end
        
        r.forward()
        currentTunnelX = currentTunnelX + 1
        r.turnLeft()
        
    end
    
    if currentTunnelY == 1 then
        for i = tunnelHeight, 2, -1 do
            if r.detectUp() == true then
                r.swingUp()
            end
            r.up()
            currentTunnelY = currentTunnelY + 1
        end
        for i = tunnelHeight, 2, -1 do
            r.down()
            currentTunnelY = currentTunnelY - 1
        end
    end

    if tunnelWidth ~= 1 then --Yeh we be doing nested if statements boo hoo, deal with it. ("and" isn't working, does lua support?)
        if currentTunnelX > 1 then
            r.turnLeft()
            for i = tunnelWidth, 2, -1 do
                r.forward()
                currentTunnelX = currentTunnelX - 1
            end
            r.turnRight()
        end
    end
        
    if r.detect() == true then
        r.swing()
        os.sleep(removeBlockSleepTime)
        r.forward()
        distanceToMove = distanceToMove - 1
    end
end

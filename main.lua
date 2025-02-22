function love.load()
    width, height = love.graphics.getDimensions()

    rondje1 = {}

    rondje1.x = width / 2
    rondje1.y = height / 2
    rondje1.r = 20
    rondje1.DistanceConstraint = 100
    rondje1.langerdan = true

    rondje2 = {}

    rondje2.x = width / 2 + 50
    rondje2.y = height / 2 + 50
    rondje2.r = rondje1.r
    rondje2.angle = 0

    distance = 0
    lengthline = 0
    heightline = 0

    angle = 0
    FPS = 0
    counter = 0
    xMl = 0
    yMl = 0

    muisangle = 0
end

function love.update(dt)
    xM, yM = love.mouse.getPosition()

    distance = (((rondje2.y - rondje1.y)^2) + ((rondje2.x - rondje1.x)^2))^0.5

    lengthline = rondje2.x - rondje1.x
    heightline = rondje2.y - rondje1.y

    if distance > rondje1.DistanceConstraint then
        rondje1.langerdan = true
    else
        rondje1.langerdan = false
    end


    if love.keyboard.isDown("d") then
        rondje1.x = math.ceil(rondje1.x + 220 * dt)
    end
    if love.keyboard.isDown("a") then
        rondje1.x = math.floor(rondje1.x - 220  * dt)
    end
    if love.keyboard.isDown("w") then
        rondje1.y = math.floor(rondje1.y - 220  * dt)
    end
    if love.keyboard.isDown("s") then
        rondje1.y = math.ceil(rondje1.y + 220  * dt)
    end

    if rondje2.x > rondje1.x + 50 then
        rondje2.x = rondje1.x + 50
    elseif rondje2.x < rondje1.x - 50 then
        rondje2.x = rondje1.x - 50
    end

    -- if rondje2.y > ronedje1.y + 50 then
    --     rondje2.y = rondje1.y + 50
    -- elseif rondje2.y < rondje1.y - 50 then
    --     rondje2.y = rondje1.y - 50
    -- end

    rondje2.x = rondje1.x + math.cos(muisangle) * rondje1.DistanceConstraint
    rondje2.y = rondje1.y + math.sin(muisangle) * rondje1.DistanceConstraint
    counter = counter + dt
    if counter > 0.75 then
        counter = 0
        FPS = 1000 / dt
    end

    rondje2.angle = math.atan2(heightline, lengthline)
    muisangle = math.atan2(yM - rondje1.y, xM - rondje1.x)
end

function love.draw()
    love.graphics.setColor(0, 1, 0)

    love.graphics.print("Distance: " ..distance)
    love.graphics.print("langer dan: " ..tostring(rondje1.langerdan),0 ,14)

    love.graphics.circle("line", rondje1.x, rondje1.y, rondje1.r)
    love.graphics.circle("line", rondje2.x, rondje2.y, rondje2.r)

    love.graphics.line(rondje1.x, rondje1.y, rondje2.x, rondje2.y)
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("line", rondje1.x, rondje1.y, rondje1.DistanceConstraint)

    love.graphics.setColor(1,1,0)

    love.graphics.line(rondje1.x, rondje1.y, rondje2.x, rondje1.y)
    love.graphics.line(rondje2.x, rondje2.y, rondje2.x, rondje1.y)

    love.graphics.print(lengthline,rondje1.x + (lengthline / 2),rondje1.y)
    love.graphics.print(heightline, rondje2.x , rondje2.y - heightline / 2)
    love.graphics.print("Oppervlakte: "..math.abs((heightline * lengthline) / 2),0,28+28)

    love.graphics.print("Frames Per Second: "..math.floor(FPS), width - 180, 0)
    love.graphics.print("Angle rondje2: "..math.deg(rondje2.angle),0,28+28+14)
    love.graphics.print("Angle Muis: "..math.deg(muisangle),0,28+28+28)

end
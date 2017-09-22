local isColliding = false
--aabb collision
gravity=true
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end


function love.load()
--cellsize I like working with
cellsize=32
--width and height
w=32
h=32
--player information
player={x=32,y=32,w=30,h=30,speed=3,velocity=0}
--map array
tilemap={
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,1,0,1,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
      }
      
  cols = {}
  --If the array value is 0, then add to the cols table
  for y=1, #tilemap do
    for x=1, #tilemap[y] do
      if tilemap[y][x] == 1 then
        table.insert(cols, {x=(x-1)*cellsize, y=(y-1)*cellsize})
      end 
      end
      end
  
end


function love.update(dt)
  --controls wether to permit movement
  local dx=0
  local dy=0
  jumpheight=-700
  gravity_vel=-300*dt
 --controls
  if love.keyboard.isDown('space') and isColliding then
    if player.velocity==0 then
      player.velocity= -7500*dt
    end
  end
 
  if love.keyboard.isDown('left')then
    dx= -1
  end
  if love.keyboard.isDown('right')  then
    dx= 1
  end
 
  -- 1st Loop to check collision and stop horizontal movement
local oldx=player.x
player.x=player.x+(player.speed*dx)
for k, v in ipairs(cols) do
if CheckCollision(player.x, player.y,player.w, player.h, v.x, v.y, cellsize, cellsize) then
      isColliding = true
      
      break
    else
      isColliding = false
    end
  end

if isColliding then
  player.x=oldx
   dx=0
end 

local oldy=player.y

if player.velocity ~=0 then
player.y=player.y+(player.velocity*dt)
player.velocity=player.velocity-gravity_vel
end
player.y=player.y+(player.speed*dy)
if gravity==true and player.velocity==0 then
  player.y=player.y+3
  end
--second loop to check collision and stop verticle movement
for k, v in ipairs(cols) do
if CheckCollision(player.x, player.y,player.w , player.h, v.x, v.y, cellsize, cellsize) then
      isColliding = true
    player.velocity=0
      break
    else
      isColliding = false
     
    end
    end

if isColliding then
  
 player.y=oldy
 dy=-1
end 

end

function love.keypressed(key) 
if key == 'space' and canjump then
  dy=-1
  end
end

function love.draw() 
  --the tile array
    for i,row in ipairs(tilemap) do
      for j,tile in ipairs(row) do
        --changes the color of the tiles based on what they are defined as in the tilemap array
            if tile ~= -1 then
              if tile ==0 then
                love.graphics.setColor(25,25,255)
              elseif tile ==1  then
                 love.graphics.setColor(25,255,255)
                end
                --prints the tile array
              love.graphics.rectangle("fill", (j-1)*cellsize,(i-1)*cellsize, w, h)
            end
            end
            end
  --the player character object
  love.graphics.setColor(255,25,25)
  love.graphics.rectangle('fill',player.x,player.y,player.w,player.h)
  --collision check
  if isColliding then
    love.graphics.print('Colliding, yeey')
  else
    love.graphics.print('No colliding D:')
  end
end
